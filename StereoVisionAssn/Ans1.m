% Reset all the variables
clear 
clc
close all

% Read left and right images - scale down by 2
L = iread('rocks2-l.png', 'reduce', 2);
R = iread('rocks2-r.png', 'reduce', 2);

% To view the images in stereo vision next to each other 
% figure;
% stdisp(L, R)

% % Stereo vision with interpolation
[di, sim, peak] = istereo(L, R, [40 90], 3, 'interp');
figure;
idisp(di,'bar');

% Mark all invalid pixels as NaN
status = ones(size(di));
[U, V] = imeshgrid(L);
status(U <= 90)   = 2;        % no overlap - 90 pixels of left image
status(sim < 0.8) = 3;        % weak match - all similarity values less than 0.8 are marked as invalid
status(peak.A >= -0.1) = 4;   % broad peak
status(isnan(di)) = 5;        % To mark all NaN of di as NaN in status
di(status>1) = NaN;
figure;
ipixswitch(isnan(di), 'red', di);

% Plot the reconstruction
di = di + 274;               % Offset from the real image
figure;
[U,V] = imeshgrid(L);
u0 = size(L,2)/2;
v0 = size(L,1)/2;
b = 0.160;
X = b*(U-u0) ./ di;
Y = b*(V-v0) ./ di;
Z = 3740 * b ./ di;
surf(Z)
shading interp; view(-150, 75)
set(gca,'ZDir', 'reverse'); set(gca,'XDir', 'reverse')
shading interp; 
colormap(hot);
