function x = trans1_2(theta, point)
    mat1_2 = [cosd(theta) -sind(theta) 0 4; sind(theta) cosd(theta) 0 0; 0 0 1 0; 0 0 0 1];
    x = mat1_2*point;
end