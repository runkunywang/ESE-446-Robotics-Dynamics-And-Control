function x = trans0_1(theta, point)
    mat0_1 = [cosd(theta) -sind(theta) 0 0; sind(theta) cosd(theta) 0 0; 0 0 1 0; 0 0 0 1];
    x = mat0_1*point;
end 