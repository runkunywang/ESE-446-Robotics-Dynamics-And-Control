function x = trans3_E(point)
    mat3_E = [1 0 0 2; 0 1 0 0; 0 0 1 0; 0 0 0 1];
    x = mat3_E*point;
end