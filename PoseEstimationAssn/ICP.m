% ICP - Iterative closest point
clc 
clear



qTp = SE3(0.1, -0.2, 1.5) * SE3.rpy(0.1, 0.2, 0.3);
N = 20;
P = randn(3, N);
Qh = qTp.T * e2h(P);
Q = h2e(Qh);
T = qp2tr(P,Q);