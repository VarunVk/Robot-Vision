% qp2tr
function T = qp2tr(P, Q)
    SumP = sum(P,2);
    SumQ = sum(Q,2);
    AvgP = SumP/size(P,2);
    AvgQ = SumQ/size(Q,2);
    t = AvgQ -AvgP
    T=2;
end 