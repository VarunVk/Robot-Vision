%Question 2
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
for i=1:size(Qr,2)
    Qr_new(:, i) = Qr(:, corresp(i));
end
T2 = pq2tr(Qr_new, Pr)
qTp

%%%%%%%%%%%% PART C %%%%%%%%%%%%
M=Pr;D=Qr;
N = 10;
T3 = ICP_simple(Pr, Qr, N)
qTp

function [Pose] = pq2tr(M,D)
    W = (M-mean(M,2))*(D-mean(M,2))';
    [U,S,V] = svd(W);
    R = V*U';
    t = (Dmean-R*Mmean);
    Pose = [R t; 0 0 0 1];
end

function [T] = ICP_simple(M, D, N)
    T = eye(4,4)
    for i=1:10
       [corresp, dist] = closest(D,M);
       for j=1:size(corresp,2)
           M_new(:,j) = M(:,corresp(j));
       end
       M = M_new;
       Dmean = mean(D,2);
       Mmean = mean(M,2);
       W = (M-Mmean)*(D-Dmean)';
       [U,S,V] = svd(W);
       R = V*U';
       t = (Dmean-R*Mmean);

       %%%%%%%%%%%
       %Get back angle and x,y,z for translation
       %[theta, v] = tr2angvec(R);

       %%%%%%%%%%%
       dT = [R t; 0 0 0 1];
       mean(dist)
       mean_dist=norm((mean(M))-(mean(D)));

       if i == 1
           T = T*dT;
       end
       M = h2e(dT*e2h(M));
    end
end
