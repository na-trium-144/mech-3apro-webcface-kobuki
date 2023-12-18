clear all;
close all;

% Setting
t = (0:0.2:10)';
count = length(t);
fps = 5;
r = rateControl(fps);

% Generate robot
%robot = loadrobot("kinovaGen3","DataFormat","column");
robot = importrobot("robot.urdf");
q = homeConfiguration(robot);
dof = length(q);

% Generage target end-effector position (circle)
points = [(0.5:-0.01:0.4)' zeros(11, 1) (0.3:0.01:0.4)']
count = length(points)

% Define IK solver
q_t = zeros(count, dof);
ik = inverseKinematics('RigidBodyTree', robot);
weights = [0, 0, 0, 1, 1, 1];
%weights = [1, 1, 1, 1, 1, 1];
endEffector = 'arm_link7_link';

% Follow the trajectory
for i = 1:count
point = points(i,:);
q = ik(endEffector,trvec2tform(point),weights,q); 
%q = ik(endEffector,trvec2tform(pos)*axang2tform(att),weights,q);
for j = 1:dof
    q_t(i,j) = q(j).JointPosition;
end
end

% Draw robot
for i = 1:count
q_now = q;
for j = 1:dof
    q_now(j).JointPosition = q_t(i, j)
end
show(robot,q_now,'PreservePlot', true);
drawnow
waitfor(r);
end
