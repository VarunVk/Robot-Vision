%% Clear stuff
clear all;
clc

%% PBVS 
cam = CentralCamera('default');
T_C0 = SE3(1,1,-3)*SE3.Rz(0.6);
Cd_T_G = SE3(0, 0, 1);
pbvs = PBVS(cam, 'pose0', T_C0, 'posef', Cd_T_G, 'axis', [-1 2 -1 2 -3 0.5])
pbvs.run();
figure
pbvs.plot_p();
figure
pbvs.plot_vel();
figure
pbvs.plot_camera();

%% IBVS
cam = CentralCamera('default');
T_C0 = SE3(1,1,-3)*SE3.Rz(0.6);
pd = bsxfun(@plus, 200*[-1 -1 1 1; -1 1 1 -1], cam.pp')
ibvs = IBVS(cam, 'pose0', T_C0, 'pstar', pd, 'axis', [-1 2 -1 2 -3 0.5])
ibvs.run();
figure
ibvs.plot_p();
figure
ibvs.plot_vel();
figure
ibvs.plot_camera();

%% IBVS Camera retreat value
cam = CentralCamera('default');
pd = bsxfun(@plus, 200*[-1 -1 1 1; -1 1 1 -1], cam.pp')
ibvs = IBVS(cam, 'pose0', SE3(0, 0, -1)*SE3.Rz(1), 'pstar', pd, 'axis', [-1 1 -1 1 -1.5 0.5])
ibvs.run();

%% PBVS Camera retreat value
cam = CentralCamera('default');
pd = bsxfun(@plus, 200*[-1 -1 1 1; -1 1 1 -1], cam.pp')
pbvs = PBVS(cam, 'pose0', SE3(0, 0, -1)*SE3.Rz(1), 'axis', [-1 1 -1 1 -1.5 0.5])
pbvs.run();
