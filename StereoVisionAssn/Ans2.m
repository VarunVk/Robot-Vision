% % Solution to HW3 Answer 2
clear 
clc
close all

SCALE = 4;
% % Part A % %
L = iread('mc0.png', 'reduce', SCALE);
R = iread('mc1.png', 'reduce', SCALE);

[di,sim,peak] = istereo(L, R, [5 60], 3, 'interp');
figure;
idisp(di, 'bar');

% % Part B % %
% Status to mark valid pixel which have a high similarity value
status = ones(size(di));
[U, V] = imeshgrid(L);
status(isnan(di)) = 5;
status(U <= 60) = 2; % no overlap
status(sim<0.3) = 3; % weak match
status(peak.A >= -0.009) = 4; % broad peak
di(status>1) = NaN;

u0 = 1244.772/SCALE; u1 = 1369.115/SCALE; v0 = 1019.507/SCALE; b = 0.193;
% di = di-(u0-u1);
Z = (3979.911/SCALE) * b ./ di;
figure; surf(Z); shading interp; view(0, -90); colormap((hot)); colorbar; grid on;

% % Part C % %
THRESHOLD = 5;
Z = ipixswitch(Z<=THRESHOLD, Z, NaN);
figure; surf(Z); shading interp; view(0, -90); colormap((hot)); colorbar; grid on;