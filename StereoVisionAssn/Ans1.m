% Reset all the variables
clear 
clc
close all

% Read the input images
L = iread('rocks2-l.png', 'reduce', 2);
R = iread('rocks2-r.png', 'reduce', 2);

% To view the images in stereo vision next to each other 
% figure;
% stdisp(L, R)

% % Dense stereo matching without interpolation
% [d, sim, DSI] = istereo(L, R, [40,90], 3);
% figure;
% idisp(d,'bar');
% figure;
% % To plot the similarity values
% ihist(sim(isfinite(sim)), 'normcdf');

% % Stereo vision with interpolation
[di, sim, peak] = istereo(L, R, [40 90], 3, 'interp');
figure;
idisp(di,'bar');
% di1 = ipixswitch(isnan(di), 'red', (di-40)/50);
% figure;
% idisp(di1,'bar');

% Status to mark valid pixel which have a high similarity value
status = ones(size(di));
[U, V] = imeshgrid(L);
status(U <= 90) = 2; % no overlap
status(sim<0.8) = 3; % weak match
status(peak.A >= -0.1) = 4; % broad peak
status(isnan(di)) = 5;
di(status>1) = NaN;
figure;
ipixswitch(isnan(di), 'red', di);

% Plot the reconstruction
di = di + 274;
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
colormap(hot)
