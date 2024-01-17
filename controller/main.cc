#include <webcface/webcface.h>
#include <string>
#include <thread>
#include <iostream>
#include <numbers>

int main(int argc, char **argv){
    if(argc < 2){
        std::wcerr << L"引数に0または1" << std::endl;
        return 1;
    }
    bool is_sim = (std::string(argv[1]) == "1");

    webcface::Client wcli("controller");

    using namespace webcface::ViewComponents;
    double servo_diff = 0.02;
    auto v = wcli.view("control");
    v.add("kobuki　　　　dynamixel\n");
    v.add("　　");
    v.add(button("↑", [&]{wcli.member("kobuki").func("baseControl").run(0.1, 0);}));
    v.add("　　　　");
    v.add(button("↑", [&]{wcli.member("matlab-test").func("setDestDiff").run(0, 0, servo_diff);}));
    v.add("　　");
    v.add(button("x↑", [&]{wcli.member("matlab-test").func("setDestDiff").run(servo_diff, 0, 0);}));
    v.add("\n");
    v.add(button("←", [&]{wcli.member("kobuki").func("baseControl").run(0, 0.1);}));
    v.add(button("×", [&]{wcli.member("kobuki").func("baseControl").run(0, 0);}));
    v.add(button("→", [&]{wcli.member("kobuki").func("baseControl").run(0, -0.1);}));
    v.add(" ");
    v.add(button("←", [&]{wcli.member("matlab-test").func("setDestDiff").run(0, servo_diff, 0);}));
    v.add("　");
    v.add(button("→", [&]{wcli.member("matlab-test").func("setDestDiff").run(0, -servo_diff, 0);}));
    v.add("\n");
    v.add("　　");
    v.add(button("↓", [&]{wcli.member("kobuki").func("baseControl").run(-0.1, 0);}));
    v.add("　　　　");
    v.add(button("↓", [&]{wcli.member("matlab-test").func("setDestDiff").run(0, 0, -servo_diff);}));
    v.add("　　");
    v.add(button("x↓", [&]{wcli.member("matlab-test").func("setDestDiff").run(-servo_diff, 0, 0);}));
    v.add("\n");
    v.sync();

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
            circle(webcface::identity(), 0.178)},
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
        auto world = wcli.canvas3D("world");
        world.add(plane(webcface::identity(), 10, 10), webcface::ViewColor::white);
        world.add(line(webcface::identity(), {10, 0, 0}), webcface::ViewColor::red);
        world.add(robot, webcface::identity(), conf);
        world.sync();

        std::this_thread::sleep_for(std::chrono::milliseconds(50));
        wcli.sync();
    }
}