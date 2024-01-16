from dynamixel_driver.dynamixel_io import DynamixelIO
import webcface
import time
import threading

io = DynamixelIO("COM6", 1000000)

wcli = webcface.Client("dynamixel")
wcli.start()

@wcli.func(args=[webcface.Arg(type=int, min=300, max=700, init=500)] * 7)
def move_servo(*angles):
    for i in range(7):
        io.set_position_and_speed(i + 1, angles[i], int(1023*0.111*1))

@wcli.func()
def free_servo():
    for i in range(7):
        io.set_torque_enabled(i + 1, 0)
free_servo()

from webcface.view_components import button
servo_diff = 0.02
with wcli.view("control") as v:
    v.add("kobuki　　　　dynamixel\n")
    v.add("　　")
    v.add(button("↑", lambda:wcli.member("kobuki").func("baseControl").run(0.1, 0)))
    v.add("　　　　")
    v.add(button("↑", lambda:wcli.member("matlab-test").func("setDestDiff").run(0, 0, servo_diff)))
    v.add("　　")
    v.add(button("x↑", lambda:wcli.member("matlab-test").func("setDestDiff").run(servo_diff, 0, 0)))
    v.add("\n")
    v.add(button("←", lambda:wcli.member("kobuki").func("baseControl").run(0, 0.1)))
    v.add(button("×", lambda:wcli.member("kobuki").func("baseControl").run(0, 0)))
    v.add(button("→", lambda:wcli.member("kobuki").func("baseControl").run(0, -0.1)))
    v.add(" ")
    v.add(button("←", lambda:wcli.member("matlab-test").func("setDestDiff").run(0, servo_diff, 0)))
    v.add("　")
    v.add(button("→", lambda:wcli.member("matlab-test").func("setDestDiff").run(0, -servo_diff, 0)))
    v.add("\n")
    v.add("　　")
    v.add(button("↓", lambda:wcli.member("kobuki").func("baseControl").run(-0.1, 0)))
    v.add("　　　　")
    v.add(button("↓", lambda:wcli.member("matlab-test").func("setDestDiff").run(0, 0, -servo_diff)))
    v.add("　　")
    v.add(button("x↓", lambda:wcli.member("matlab-test").func("setDestDiff").run(-servo_diff, 0, 0)))
    v.add("\n")
wcli.sync()

while True:
    try:
        time.sleep(0.1)
        for i in range(1, 8):
            wcli.value(f"servo/{i}").set(io.get_position(i))
        wcli.sync()
    except KeyboardInterrupt:
        wcli.close()
        free_servo()
        io.close()
        break
    except:
        pass

