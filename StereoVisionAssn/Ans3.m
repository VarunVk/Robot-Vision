% % Solution to HW3 Answer 2
clear 
clc
close all

SCALE = 2;
% % Part A % %
L = iread('mc0.png', 'reduce', SCALE);
R = iread('mc1.png', 'reduce', SCALE);

[di,sim,peak] = istereo(L, R, [10 120], 3, 'interp');
figure;
idisp(di, 'bar');

% % Part B % %
% Status to mark valid pixel which have a high similarity value
status = ones(size(di));
[U, V] = imeshgrid(L);
status(U <= 120) = 2; % no overlap
status(sim<0.4) = 3; % weak match
status(peak.A >= -0.02) = 4; % broad peak
status(isnan(di)) = 5;
di(status>1) = NaN;

b = 0.193;
Z = (3979.911/SCALE) * b ./ di;
figure; surf(Z); shading interp; view(0, -90); colormap((hot)); colorbar; grid on;

% % Part C % %
THRESHOLD = 5;
Z = ipixswitch(Z<=THRESHOLD, Z, NaN);
figure; surf(Z); shading interp; view(0, -90); colormap((hot)); colorbar; grid on;