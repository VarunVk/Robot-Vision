function pose = h2tr(K, H)
    ProdR1R2t = inv(K) * H;
    
    % First Row is  R1
    R1 = ProdR1R2t(:, 1);
    R1norm = norm(R1);
    R1 = R1/R1norm;
    
    % Second Row is  R2
    R2 = ProdR1R2t(:, 2);
    R2 = R2/norm(R2);
        
    % Cross product of  R1 and R2
    R1xR2 = cross(R1, R2);
    
    % Third Row is t
    t = ProdR1R2t(:,3)/R1norm;
    
    pose = [R1 R2 R1xR2 t; 0 0 0 1];
end