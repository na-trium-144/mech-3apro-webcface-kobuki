import pybullet as p
import time
import pybullet_data
physicsClient = p.connect(p.GUI)#or p.DIRECT for non-graphical version
p.setAdditionalSearchPath(pybullet_data.getDataPath()) #optionally
planeId = p.loadURDF("plane.urdf")
startPos = [0,0,0]
startOrientation = p.getQuaternionFromEuler([0,0,0])
robotId = p.loadURDF("../ik/robot.urdf", startPos, startOrientation)

import webcface
wcli = webcface.Client("bullet-sim")
wcli.start()

import math
def rad2servo(angle: float) -> float:
    return (math.degrees(angle) + 150) * 1023 / 300
def servo2rad(angle: float) -> float:
    return math.radians(angle / 1023 * 300 - 150)

# dynamixelに仕様をあわせる
@wcli.func(args = [webcface.Arg(type=float)] * 7)
def move_servo(*angles):
    print(f"move_servo {angles}")
    arm_joint = [30, 31, 33, 35, 36, 37, 39]
    for i in range(7):
        p.setJointMotorControl2(
            robotId,
            arm_joint[i],
            p.POSITION_CONTROL,
            servo2rad(angles[i]),
            force=3,
            positionGain=0.1,
            velocityGain=1,
        )

p.setGravity(0,0,-10)

@wcli.func()
def reset_pos():
    p.resetBasePositionAndOrientation(robotId, startPos, startOrientation)
    p.resetBaseVelocity(robotId, [0, 0, 0], [0, 0, 0])

arm_joint = [30, 31, 33, 35, 36, 37, 39]

while True:
    p.stepSimulation()
    for i in range(1, 8):
        wcli.value(f"servo/{i}").set(rad2servo(p.getJointState(robotId, arm_joint[i - 1])[0]))
    wcli.sync()
    time.sleep(1./240.)
    