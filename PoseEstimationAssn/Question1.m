%%% Question 1 %%%
clc 
clear
% Pose of Target coordinate frame wrt Camera coordinate frame
cTt = SE3(0.1, -0.2, 1.5) * SE3.rpy(0.1, 0.2, 0.3);

% Generate the real worlkd points using mkgrid
P = mkgrid(2, 0.2);

% Create a Camera as specified in the question
cam = CentralCamera('focal', 0.015, 'pixel', 10e-6, 'resolution', [1280 1024], 'pose', inv(cTt));

% Find the image plane points 
P = e2h(P);
p = cam.project(P);

% Homography is for p And P 
H = homography(P(1:2, :), p)

% Call h2tr function to estimate the pose 
Est_cTt = h2tr(cam.K, H)