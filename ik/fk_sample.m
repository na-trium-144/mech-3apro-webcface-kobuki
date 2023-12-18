clear all;
close all;

% Setting
cnt = 100;
fps = 3;
r = rateControl(fps);

% Robot
%robot = loadrobot("kinovaGen3","DataFormat","column");

robot = importrobot("robot.urdf");
q = homeConfiguration(robot);


dof = length(q);

% Set joint angles trajectories
q_t = zeros(dof, cnt);
for i = 1:dof
    q_t(i, :) = linspace(0, pi/3, cnt);
end

p_e = [];
for i = 1:10:cnt
    for j = 1:dof
        q(j).JointPosition = q_t(j, i);
    end
    show(robot, q);
    hold on;
    p_e = [p_e; tform2trvec(getTransform(robot, q, "arm_link7_link", "base_link"))];
    plot3(p_e(:, 1), p_e(:, 2), p_e(:, 3), 'r');
    hold off;
    waitfor(r);
end
