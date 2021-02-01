function RRRplot(thetas)
    
    %angles of the joints of the robot
    theta1 = thetas(1);
    theta2 = thetas(2);
    theta3 = thetas(3);
    
    %base
    p0 = [0; 0; 0];
    
    %first link
    p1 = [0; 0; 0; 1];
    p2 = [4; 0; 0; 1];
    
    %transformed first link
    np1 = trans0_1(theta1, p1);
    np2 = trans0_1(theta1, p2);
    
    %second link
    p3 = [0; 0; 0; 1];
    p4 = [3; 0; 0; 1];
    
    %transformed second link
    np3 = trans0_1(theta1, trans1_2(theta2, p3));
    np4 = trans0_1(theta1, trans1_2(theta2, p4));
    
    %third link
    p5 = [0; 0; 0; 1];
    p6 = [2; 0; 0; 1];
    
    %transformed third link
    np5 = trans0_1(theta1, trans1_2(theta2, trans2_3(theta3, trans3_E(p5))));
    np6 = trans0_1(theta1, trans1_2(theta2, trans2_3(theta3, trans3_E(p6))));
    
    plot3([p0(1) np1(1) np2(1) np3(1) np4(1) np5(1) np6(1)], [p0(2) np1(2) np2(2) np3(2) np4(2) np5(2) np6(2)], [p0(3) np1(3) np2(3) np3(3) np4(3) np5(3) np6(3)])
    grid on
    axis ([-15 15 -15 15 -15 15])
end
    
    
    
    
    