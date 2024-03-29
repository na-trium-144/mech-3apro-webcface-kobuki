#include <iostream>
#include <string>
#include <csignal>
#include <ecl/time.hpp>
// #include <ecl/command_line.hpp>
#include <ecl/sigslots.hpp>
#include <ecl/linear_algebra.hpp>
#include <ecl/geometry.hpp>
#include <kobuki_core/kobuki.hpp>
#include <webcface/webcface.h>

class KobukiManager {
  public:
    KobukiManager(const std::string &device)
        : pose(), wcli("kobuki"),
          slot_button_event(&KobukiManager::processButtonEvent, *this),
          slot_stream_data(&KobukiManager::processStreamData, *this),
          slot_debug(&KobukiManager::logCustomDebug, *this),
          slot_info(&KobukiManager::logCustomInfo, *this),
          slot_warning(&KobukiManager::logCustomWarning, *this),
          slot_error(&KobukiManager::logCustomError, *this) {
        kobuki::Parameters parameters;
        // Specify the device port, default: /dev/kobuki
        parameters.device_port = device;

        // Other parameters are typically happy enough as defaults, some
        // examples follow
        //
        // namespaces all sigslot connection names, default: /kobuki
        parameters.sigslots_namespace = "/kobuki";
        // Most use cases will bring their own smoothing algorithms, but if
        // you wish to utilise kobuki's minimal acceleration limiter, set to
        // true
        parameters.enable_acceleration_limiter = false;
        // Adjust battery thresholds if your levels are significantly varying
        // from factory settings. This will affect led status as well as
        // triggering driver signals
        parameters.battery_capacity = 16.5;
        parameters.battery_low = 14.0;
        parameters.battery_dangerous = 13.2;

        // Disable the default loggers
        parameters.log_level = kobuki::LogLevel::NONE;

        // Wire them up ourselves
        slot_debug.connect(parameters.sigslots_namespace + "/debug");
        slot_info.connect(parameters.sigslots_namespace + "/info");
        slot_warning.connect(parameters.sigslots_namespace + "/warning");
        slot_error.connect(parameters.sigslots_namespace + "/error");

        // Initialise - exceptions are thrown if parameter validation or
        // initialisation fails.
        // try {
        kobuki.init(parameters);
        // } catch (ecl::StandardException &e) {
        //     std::cout << e.what();
        // }

        slot_button_event.connect("/kobuki/button_event");
        slot_stream_data.connect("/kobuki/stream_data");

        wcli.value("button/0") = 0;
        wcli.value("button/1") = 0;
        wcli.value("button/2") = 0;

        wcli.func("baseControl")
            .set([this](double l, double r) {
                if (kobuki.isEnabled()) {
                    kobuki.setBaseControl(l, r);
                }
            })
            .setArgs({webcface::Arg("linear"), webcface::Arg("angular")});
        wcli.func("emergencyOn").set([this]{emergencyOn();});
        wcli.func("emergencyOff").set([this]{emergencyOff();});
        updateView();
        wcli.start();
    }
    void emergencyOn() {
        kobuki.setBaseControl(0, 0);
        kobuki.disable();
        updateView();
    }
    void emergencyOff() {
        kobuki.enable();
        updateView();
    }
    void updateView() {
        using namespace webcface::ViewComponents;
        using namespace webcface;
        auto v = wcli.view("emergency");

        v << button("緊急停止", [this] {
                 emergencyOn();
             }).bgColor(ViewColor::red);
        v << (kobuki.isEnabled() ? text(" off").textColor(ViewColor::green)
                                 : text(" on").textColor(ViewColor::red))
          << std::endl;
        v << button("解除", [this] { emergencyOff(); });
        v.sync();

        wcli.value("emergency").set(!kobuki.isEnabled());
    }

    ~KobukiManager() {
        kobuki.setBaseControl(
            0, 0); // linear_velocity, angular_velocity in (m/s), (rad/s)
        kobuki.disable();
    }
    void logCustomDebug(const std::string &message) {
        wcli.logger()->debug(message);
    }

    void logCustomInfo(const std::string &message) {
        wcli.logger()->info(message);
    }

    void logCustomWarning(const std::string &message) {
        wcli.logger()->warn(message);
    }

    void logCustomError(const std::string &message) {
        wcli.logger()->error(message);
    }
    /*
     * Nothing to do in the main thread, just put it to sleep
     */
    void spin() {
        ecl::Sleep sleep(1);
        while (true) {
            sleep();
            wcli.sync();
        }
    }

    /*
     * Catches button events and prints a curious message to stdout.
     */
    void processButtonEvent(const kobuki::ButtonEvent &event) {
        std::string button_id;
        switch (event.button) {
        case kobuki::ButtonEvent::Button::Button0:
            button_id = "button/0";
            break;
        case kobuki::ButtonEvent::Button::Button1:
            button_id = "button/1";
            break;
        case kobuki::ButtonEvent::Button::Button2:
            button_id = "button/2";
            break;
        }
        wcli.value(button_id) =
            event.state == kobuki::ButtonEvent::State::Pressed;
        wcli.sync();
    }

    /*
     * Called whenever the kobuki receives a data packet.
     * Up to you from here to process it.
     */
    void processStreamData() {
        // kobuki::CoreSensors::Data data = kobuki.getCoreSensorData();
        // std::cout << "Encoders [" << data.left_encoder << ","
        //           << data.right_encoder << "]" << std::endl;
        ecl::linear_algebra::Vector3d pose_update;
        ecl::linear_algebra::Vector3d pose_update_rates;
        kobuki.updateOdometry(pose_update, pose_update_rates);
        pose = ecl::concatenate_poses(pose, pose_update);
        wcli.value("pose/x") = pose[0];
        wcli.value("pose/y") = pose[1];
        wcli.value("pose/th") = pose[2];
        wcli.sync();
    }

  private:
    webcface::Client wcli;
    kobuki::Kobuki kobuki;
    ecl::Slot<const kobuki::ButtonEvent &> slot_button_event;
    ecl::Slot<> slot_stream_data;
    ecl::Slot<const std::string &> slot_debug, slot_info, slot_warning,
        slot_error;
    ecl::linear_algebra::Vector3d pose; // x, y, heading
};

bool shutdown_req = false;
void signalHandler(int /* signum */) { shutdown_req = true; }

int main(int argc, char **argv) {
    // ecl::CmdLine cmd_line("chirp", ' ', "0.2");
    // ecl::ValueArg<std::string> device_port(
    //     "p", "port", "Path to device file of serial port to open", false,
    //     "/dev/kobuki", "string");
    // cmd_line.add(device_port);
    // cmd_line.parse(argc, argv);

    // KobukiManager kobuki_manager(device_port.getValue());
    // ecl::Sleep()(5);
    if (argc < 2) {
        std::cerr << "please specify port" << std::endl;
        return 1;
    }
    try {
        KobukiManager kobuki_manager(argv[1]);
        kobuki_manager.spin();
    } catch (ecl::StandardException &e) {
        std::cout << e.what();
    }
    return 0;
}