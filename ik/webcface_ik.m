function webcface_ik(is_sim)

robot = importrobot("robot.urdf");
q = homeConfiguration(robot);
dof = length(q);

if exist("wcli", "var")
    clib.webcface.wcfClose(wcli);
end
addpath("webcface")
configObj = clibConfiguration("webcface", ExecutionMode="outofprocess")
import clib.webcface.*
wcli = clib.webcface.wcfInit("matlab-test", "127.0.0.1", 7530);
clib.webcface.wcfStart(wcli);

% Generate robot
%robot = loadrobot("kinovaGen3","DataFormat","column");
robot = importrobot("robot.urdf");
q = homeConfiguration(robot);
dof = length(q);

p0 = tform2trvec(getTransform(robot, q, "arm_link5_link", "base_link"));
x0 = p0(1)
y0 = p0(2)
z0 = p0(3)

% Define IK solver
ik = inverseKinematics('RigidBodyTree', robot);
weights = [0, 0, 0, 1, 1, 1];
%weights = [1, 1, 1, 1, 1, 1];
endEffector = 'arm_link5_link';

if is_sim
    target = "bullet-sim"
else
    target = "dynamixel"
end
reverse = [1 1 1 1 1 1 1];

use_plot = 0;

q = homeConfiguration(robot);
qa = clib.array.webcface.wcfMultiVal(7);
for j = 1:7
    qa(j) = clib.webcface.wcfValD(rad2deg(q(j).JointPosition) * reverse(j) / 300 * 1023 + 500);
end
clib.webcface.wcfFuncRun(wcli, target, "move_servo", qa)
if use_plot
    show(robot, q, Frames="off");
    xlim([-0.4 0.6])
    ylim([-0.5 0.5])
    zlim([-0.25 0.75])
end

clib.webcface.wcfFuncListen(wcli, "setDest", [4, 4, 4], 0)
clib.webcface.wcfFuncListen(wcli, "setDestDiff", [4, 4, 4], 0)
r = rateControl(5);
clib.webcface.wcfSync(wcli)
x = x0;
y = y0;
z = z0;
while true
    
    [ret, h] = clib.webcface.wcfFuncFetchCall(wcli, "setDest");
    if ret == 0
        x = h.args(1).as_double;
        y = h.args(2).as_double;
        z = h.args(3).as_double;
        q = ik(endEffector,trvec2tform([x y z]),weights,q);
        qa = clib.array.webcface.wcfMultiVal(7);
        for j = 1:7
            qa(j) = clib.webcface.wcfValD(rad2deg(q(j).JointPosition) * reverse(j) / 300 * 1023 + 500);
        end
        clib.webcface.wcfFuncRunAsync(wcli, target, "move_servo", qa)
        if use_plot
            show(robot, q, Frames="off");
            xlim([-0.4 0.6])
            ylim([-0.5 0.5])
            zlim([-0.25 0.75])
        end
        clib.webcface.wcfFuncRespond(h, clib.webcface.wcfValI(0))
    end
    [ret, h] = clib.webcface.wcfFuncFetchCall(wcli, "setDestDiff");
    if ret == 0
        dx = h.args(1).as_double;
        dy = h.args(2).as_double;
        dz = h.args(3).as_double;
        q2 = ik(endEffector,trvec2tform([x+dx y+dy z+dz]),weights,q);
        ok = true;
        for j = 1:7
            % if abs(q2(j).JointPosition - q(j).JointPosition) > deg2rad(120)
            if abs(q2(j).JointPosition) > deg2rad(150)
                ok = false;
            end
        end
        if ok
            q = q2;
            x = x + dx;
            y = y + dy;
            z = z + dz;
            qa = clib.array.webcface.wcfMultiVal(7);
            for j = 1:7
                qa(j) = clib.webcface.wcfValD(rad2deg(q(j).JointPosition) * reverse(j) / 300 * 1023 + 500);
            end
            clib.webcface.wcfFuncRunAsync(wcli, target, "move_servo", qa)
            if use_plot
                show(robot, q, Frames="off");
                xlim([-0.4 0.6])
                ylim([-0.5 0.5])
                zlim([-0.25 0.75])
            end
            clib.webcface.wcfFuncRespond(h, clib.webcface.wcfValI(0))
        else
            clib.webcface.wcfFuncReject(h, "ik failed")
        end
    end
    waitfor r
end

end
