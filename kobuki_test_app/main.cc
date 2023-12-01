#include <iostream>
#include <string>
#include <csignal>
#include <ecl/time.hpp>
// #include <ecl/command_line.hpp>
#include <ecl/sigslots.hpp>
#include <ecl/linear_algebra.hpp>
#include <ecl/geometry.hpp>
#include <kobuki_core/kobuki.hpp>

class KobukiManager {
  public:
    KobukiManager(const std::string &device)
        : dx(0), dth(0), length(0.1),
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
    }

    ~KobukiManager() {
        kobuki.setBaseControl(
            0, 0); // linear_velocity, angular_velocity in (m/s), (rad/s)
        kobuki.disable();
    }
    void logCustomDebug(const std::string &message) {
        std::cout << ecl::green << "[DEBUG_WITH_COLANDERS] " << message
                  << ecl::reset << std::endl;
    }

    void logCustomInfo(const std::string &message) {
        std::cout << "[INFO_WITH_COLANDERS] " << message << ecl::reset
                  << std::endl;
    }

    void logCustomWarning(const std::string &message) {
        std::cout << ecl::yellow << "[WARNING_WITH_COLANDERS] " << message
                  << ecl::reset << std::endl;
    }

    void logCustomError(const std::string &message) {
        std::cout << ecl::red << "[ERROR_WITH_COLANDERS] " << message
                  << ecl::reset << std::endl;
    }
    /*
     * Nothing to do in the main thread, just put it to sleep
     */
    void spin() {
        ecl::Sleep sleep(1);
        while (true) {
            sleep();
        }
    }

    /*
     * Catches button events and prints a curious message to stdout.
     */
    void processButtonEvent(const kobuki::ButtonEvent &event) {
        std::vector<std::string> quotes = {
            "That's right buddy, keep pressin' my buttons. See what happens!",
            "Anything less than immortality is a complete waste of time",
            "I can detect humour, you are just not funny",
            "I choose to believe ... what I was programmed to believe",
            "My story is a lot like yours, only more interesting ‘cause it "
            "involves robots.",
            "I wish you'd just tell me rather trying to engage my enthusiasm "
            "with these buttons, because I haven't got one.",
        };
        std::random_device r;
        std::default_random_engine generator(r());
        std::uniform_int_distribution<int> distribution(0, 5);
        if (event.state == kobuki::ButtonEvent::Released) {
            std::cout << quotes[distribution(generator)] << std::endl;
        }
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
        ecl::concatenate_poses(pose, pose_update);
        dx += pose_update[0];  // x
        dth += pose_update[2]; // heading
        // std::cout << dx << ", " << dth << std::endl;
        // std::cout << kobuki.getHeading() << ", " << pose.heading() <<
        // std::endl; std::cout << "[" << pose[0] << ", " << pose.y() << ", " <<
        // pose.heading() << "]" << std::endl;

        // processMotion();
    }
    // Generate square motion
    void processMotion() {
        const double buffer = 0.05;
        double longitudinal_velocity = 0.0;
        double rotational_velocity = 0.0;
        if (dx >= (length) && dth >= ecl::pi / 2.0) {
            std::cout << "[Z] ";
            dx = 0.0;
            dth = 0.0;
        } else if (dx >= (length + buffer)) {
            std::cout << "[R] ";
            rotational_velocity = 1.1;
        } else {
            std::cout << "[L] ";
            longitudinal_velocity = 0.3;
        }
        std::cout << "[dx: " << dx << "][dth: " << dth << "][" << pose[0]
                  << ", " << pose[1] << ", " << pose[2] << "]" << std::endl;
        kobuki.setBaseControl(longitudinal_velocity, rotational_velocity);
    }

    const ecl::linear_algebra::Vector3d &getPose() { return pose; }

  private:
    kobuki::Kobuki kobuki;
    ecl::Slot<const kobuki::ButtonEvent &> slot_button_event;
    ecl::Slot<> slot_stream_data;
    ecl::Slot<const std::string &> slot_debug, slot_info, slot_warning,
        slot_error;
    double dx, dth;
    const double length;
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
    try {
        KobukiManager kobuki_manager("/dev/kobuki");
        kobuki_manager.spin();
        ecl::Sleep sleep(1);
        ecl::linear_algebra::Vector3d pose; // x, y, heading
        while (!shutdown_req) {
            sleep();
            pose = kobuki_manager.getPose();
            // std::cout << "current pose: [" << pose[0] << ", " << pose[1] <<
            // ", " << pose[2] << "]" << std::endl;
        }
    } catch (ecl::StandardException &e) {
        std::cout << e.what();
    }
    return 0;
}