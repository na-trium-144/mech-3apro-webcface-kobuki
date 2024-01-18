#include <webcface/webcface.h>
#include <string>
#include <thread>
#include <iostream>
#include <numbers>

int main(int argc, char **argv){
    // if(argc < 2){
    //     std::wcerr << L"引数に0または1" << std::endl;
    //     return 1;
    // }
    // bool is_sim = (std::string(argv[1]) == "1");

    webcface::Client wcli("controller");

    using namespace webcface::ViewComponents;
    double servo_diff = 0.02;
    double kobuki_move = 0, kobuki_move_diff = 0.1;
    double kobuki_rot = 0, kobuki_rot_diff = 0.3;

    auto kobuki = wcli.member("kobuki");
    auto matlab = wcli.member("matlab-test");

    auto robot = wcli.robotModel("turtlebot");
    using namespace webcface::RobotJoints;
    using namespace webcface::Geometries;
    double pi = std::numbers::pi;
    robot.set({
        {"base_link",
            fixedAbsolute(webcface::identity()),
            cylinder({{0, 0, 0}, {0, -pi/2, 0}}, 0.178, 0.11)},
        {"plate_top_link",
            fixedAbsolute({{0, 0, 0.4}, {0, 0, 0}}),
            cylinder({{0, 0, 0}, {0, -pi/2, 0}}, 0.178, 0.01)},
        {"pole1",
            fixedAbsolute({{-0.05, -0.15, 0}, {0, 0, 0}}),
            cylinder({{0, 0, 0}, {0, -pi/2, 0}}, 0.005, 0.4)},
        {"pole2",
            fixedAbsolute({{0.05, -0.15, 0}, {0, 0, 0}}),
            cylinder({{0, 0, 0}, {0, -pi/2, 0}}, 0.005, 0.4)},
        {"pole3",
            fixedAbsolute({{-0.05, 0.15, 0}, {0, 0, 0}}),
            cylinder({{0, 0, 0}, {0, -pi/2, 0}}, 0.005, 0.4)},
        {"pole4",
            fixedAbsolute({{0.05, 0.15, 0}, {0, 0, 0}}),
            cylinder({{0, 0, 0}, {0, -pi/2, 0}}, 0.005, 0.4)},
        {"arm_link0_link",
            fixedJoint("base_link", {{0.2134, 0, 0.3716}, {0, 0, 0}}),
            line({0, 0, 0}, {-0.05, 0, 0})},
        // x左、y上、z前 y軸順転 -> identity
        {"arm_link1_link",
            rotationalJoint("arm_joint1", "arm_link0_link", {{0, 0, 0}, {0, 0, 0}}),
            line({0, 0, 0}, {0.05, 0, 0})},
        {"arm_link1_j",
            fixedJoint("arm_link1_link", webcface::identity()),
            sphere(webcface::identity(), 0.01),
            webcface::ViewColor::yellow},
        // x上、y左、z後ろ z軸反転 -> x下、y左、z前
        {"arm_link2_link",
            rotationalJoint("arm_joint2", "arm_link1_link", {{0.05, 0, 0}, {0, pi/2, 0}}),
            line({0, 0, 0}, {0.06, 0, 0.02})},
        {"arm_link2_j",
            fixedJoint("arm_link2_link", webcface::identity()),
            sphere(webcface::identity(), 0.01),
            webcface::ViewColor::yellow},
        // x上、y右、z前 y軸順転 -> x下、y前、z右
        {"arm_link3_link",
            rotationalJoint("arm_joint3", "arm_link2_link", {{0.06, 0, 0.02}, {0, 0, pi/2}}),
            line({0, 0, 0}, {0.014, 0.105, 0})},
        {"arm_link3_j",
            fixedJoint("arm_link3_link", webcface::identity()),
            sphere(webcface::identity(), 0.01),
            webcface::ViewColor::yellow},
        // x上、y左、z後ろ z軸反転 -> x下、y左、z前 (link2と同じ)
        {"arm_link4_link",
            rotationalJoint("arm_joint4", "arm_link3_link", {{0.014, 0.105, 0}, {0, 0, -pi/2}}),
            line({0, 0, 0}, {0, 0, 0})},
        {"arm_link4_j",
            fixedJoint("arm_link4_link", webcface::identity()),
            sphere(webcface::identity(), 0.01),
            webcface::ViewColor::yellow},
        // x後ろ、y下、z右 z軸順転 -> x下、y前、z右 (link3と同じ)
        {"arm_link5_link",
            rotationalJoint("arm_joint5", "arm_link4_link", {{0, 0, 0}, {0, 0, pi/2}}),
            line({0, 0, 0}, {0, 0.07, 0})},
        {"arm_link5_j",
            fixedJoint("arm_link5_link", webcface::identity()),
            sphere(webcface::identity(), 0.01),
            webcface::ViewColor::yellow},
        // x下、y右、z後ろ z軸反転 -> x下、y左、z前 (link2と同じ)
        {"arm_link6_link",
            rotationalJoint("arm_joint6", "arm_link5_link", {{0, 0.07, 0}, {0, 0, -pi/2}}),
            line({0, 0, 0}, {0, 0, 0.1})},
        {"arm_link6_j",
            fixedJoint("arm_link6_link", webcface::identity()),
            sphere(webcface::identity(), 0.01),
            webcface::ViewColor::yellow},
    });

    std::unordered_map<std::string, double> conf;
    for(int i = 1; i <= 6; i++){
        wcli.func("joint" + std::to_string(i)) = [&conf, i](double a){
            conf["arm_joint" + std::to_string(i)] = a;
        };
    }

    while(true){
        for(int i = 1; i <= 7; i++){
            if(matlab.value("q/" + std::to_string(i)).tryGet()){
                conf["arm_joint" + std::to_string(i)] = matlab.value("q/" + std::to_string(i)).get();
            }
        }
        auto world = wcli.canvas3D("world");
        world.add(plane(webcface::identity(), 10, 10), webcface::ViewColor::white);
        world.add(line(webcface::identity(), {10, 0, 0}), webcface::ViewColor::red);
        world.add(robot, webcface::identity(), conf);
        world.add(
            sphere(webcface::identity(), 0.02),
            {{matlab.value("x"), matlab.value("y"), matlab.value("z")}, {0, 0, 0}},
            webcface::ViewColor::red);
        world.sync();

        auto v = wcli.view("control");
        v << "kobuki ";
        if(kobuki.value("emergency").tryGet()){
            if(kobuki.value("emergency").get()){
                v << text("停止中").textColor(webcface::ViewColor::red);
            }else{
                v << text("ok").textColor(webcface::ViewColor::green);
            }
            v << button("緊急停止", wcli.member("kobuki").func("emergencyOn"))
                    .bgColor(kobuki.value("emergency").get()
                                ? webcface::ViewColor::gray
                                : webcface::ViewColor::red)
              << button("解除", wcli.member("kobuki").func("emergencyOff"))
                    .bgColor(kobuki.value("emergency").get()
                                ? webcface::ViewColor::yellow
                                : webcface::ViewColor::gray);
        }
        v << std::endl;
        auto kobuki_update = [&, kobuki]{
            kobuki.func("baseControl").runAsync(kobuki_move, 0);
        };
        auto up = button("↑", [&]{
            kobuki_move += kobuki_move_diff;
            kobuki_update();
        });
        auto down = button("↓", [&]{
            kobuki_move -= kobuki_move_diff;
            kobuki_update();
        });
        auto left = button("←", [&]{
            kobuki_rot += kobuki_rot_diff;
            kobuki_update();
        });
        auto right = button("→", [&]{
            kobuki_rot -= kobuki_rot_diff;
            kobuki_update();
        });
        auto stop = button("×", [&]{
            kobuki_move = 0;
            kobuki_rot = 0;
            kobuki_update();
        });
        v << "　　" << up << "　　　" << "linear = " << kobuki_move << std::endl;
        v << left << stop << right <<"　angular = " << kobuki_rot << std::endl;
        v << "　　" << down << std::endl;
        v << std::endl;

        v << "dynamixel (matlab)"
          << button("Free", wcli.member("dynamixel").func("free_servo"))
                .bgColor(webcface::ViewColor::red)
          << std::endl;
        v << "x = " << matlab.value("x");
        v << ", y = " << matlab.value("y");
        v << ", z = " << matlab.value("z") << std::endl;
        auto set_dest = matlab.func("setDestDiff");
        auto zplus = button("↑", [=]{set_dest.runAsync(0, 0, servo_diff);});
        auto zminus = button("↓", [=]{set_dest.runAsync(0, 0, -servo_diff);});
        auto yplus = button("←", [=]{set_dest.runAsync(0, servo_diff, 0);});
        auto yminus = button("→", [=]{set_dest.runAsync(0, -servo_diff, 0);});
        auto xplus = button("前↑", [=]{set_dest.runAsync(servo_diff, 0, 0);});
        auto xminus = button("後↓", [=]{set_dest.runAsync(-servo_diff, 0, 0);});
        v << xplus << "　　　" << zplus << std::endl;
        v << "　　　　" << yplus << "　　" << yminus << std::endl;
        v << xminus << "　　　" << zminus << std::endl;

        v.sync();

        std::this_thread::sleep_for(std::chrono::milliseconds(50));
        wcli.sync();
    }
}