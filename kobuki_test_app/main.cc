#include <iostream>
#include <string>
// #include <ecl/time.hpp>
// #include <ecl/command_line.hpp>
#include <ecl/sigslots.hpp>
#include <kobuki_core/kobuki.hpp>

class KobukiManager {
  public:
    KobukiManager(const std::string &device)
        : slot_button_event(&KobukiManager::processButtonEvent, *this),
          slot_stream_data(&KobukiManager::processStreamData, *this) {
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
        kobuki::CoreSensors::Data data = kobuki.getCoreSensorData();
        std::cout << "Encoders [" << data.left_encoder << ","
                  << data.right_encoder << "]" << std::endl;
    }

  private:
    kobuki::Kobuki kobuki;
    ecl::Slot<const kobuki::ButtonEvent &> slot_button_event;
    ecl::Slot<> slot_stream_data;
};

int main(int argc, char **argv) {
    // ecl::CmdLine cmd_line("chirp", ' ', "0.2");
    // ecl::ValueArg<std::string> device_port(
    //     "p", "port", "Path to device file of serial port to open", false,
    //     "/dev/kobuki", "string");
    // cmd_line.add(device_port);
    // cmd_line.parse(argc, argv);

    // KobukiManager kobuki_manager(device_port.getValue());
    // ecl::Sleep()(5);
    KobukiManager kobuki_manager("/dev/kobuki");
    kobuki_manager.spin();

    return 0;
}