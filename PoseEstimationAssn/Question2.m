%%%%%%%%%%%%%%%%  Question 2  %%%%%%%%%%%%%%%%%%%
clear
clc

% Calculate the Q points with the known qTp
qTp = SE3(0.1, -0.2, 1.5) * SE3.rpy(0.1, 0.2, 0.3);
N = 20;
P = randn(3, N);
Qh = qTp.T * e2h(P);
Q = h2e(Qh);

%%%%%%%%%%%% PART A %%%%%%%%%%%%
Pose1 = pq2tr(P,Q)
qTp

%%%%%%%%%%%% PART B %%%%%%%%%%%%
% Get the jumbled input
Pr = P(:, randperm(N));
Qr = Q(:, randperm(N));
[corresp, dist] = closest(Pr, Qr);
% Update Qr with the corresponding closest Pr
for i=1:size(Pr,2)
    Pr_new(:, i) = Pr(:, corresp(i));
end
T2 = pq2tr(Pr_new, Qr)
qTp

%%%%%%%%%%%% PART C %%%%%%%%%%%%
T3 = ICP_simple(Pr, Qr, 10)
qTp

%%%%%%%% FUNCTION DEFINITIONS %%%%%%%%
function [Pose] = pq2tr(M,D)
    W = (M-mean(M,2))*(D-mean(M,2))';
    [U,S,V] = svd(W);
    R = V*U';
    t = (Dmean-R*Mmean);
    Pose = [R t; 0 0 0 1];
end

function [Pose] = ICP_simple(M, D, N=10)
    for i=1:N
       [corresp, dist] = closest(D,M);
       for j=1:size(corresp,2)
           M_new(:,j) = M(:,corresp(j));
       end
       
       dT = pq2tr(M_new, D);
       distance = mean(dist)
       
       %% For the first iteration use the dT as the Pose
       if i == 1
            Pose = dT;
            M = h2e(Pose*e2h(M_new));
       else
            M = h2e(Pose*e2h(M_new));
            Pose = Pose * dT;
       end 
    end
end
