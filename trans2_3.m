function x = trans2_3(theta, point)
    mat2_3 = [cosd(theta) -sind(theta) 0 3; sind(theta) cosd(theta) 0 0; 0 0 1 0; 0 0 0 1];
    x = mat2_3*point;
end