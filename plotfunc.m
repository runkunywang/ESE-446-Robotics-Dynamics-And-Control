function plotfunc(thetas)
    t1=thetas(1);
    t2=thetas(2);
    t3=thetas(3);

   %base
    base=[0 0;
         0 0;
         0 0;
         1 1];
     
    %first link
    L1=[0 4;
        0 0;
        0 0;
        1 1];
    %second link
    L2=[0 3;
        0 0;
        0 0;
        1 1]; 
    
    %third link
    L3=[0 2;
        0 0;
        0 0;
        1 1];
    %end effector 
    LE=[0.5 0 0.5;
        0.5 0 -0.5;
        0   0 0;
        1   1 1];
    l1=4;
    l2=3;
    l3=2;

    c1=cos(t1);
    s1=sin(t1);
    c12=cos(t1+t2);
    s12=sin(t1+t2);
    c123=cos(t1+t2+t3);
    s123=sin(t1+t2+t3);

            T01=[c1 -s1 0 0;
                s1   c1 0 0;
                0     0 1 0;
                0     0 0 1];

            T02=[c12 -s12 0       l1*c1;
                s12 c12   0       l1*s1;
                0                   0   1       0;
                0                   0   0       1];

            T03=[c123 -s123  0    l2*c12+l1*c1;
                s123 c123    0    l2*s12+l1*s1;
                0                   0          1    0;
                0                   0          0    1];

            T0E=[c123 -s123  0    l3*c123+l2*c12+l1*c1;
                s123 c123    0    l3*s123+l2*s12+l1*s1;
                0                   0          1    0;
                0                   0          0    1];

            L1b=T01*L1;
            L2b=T02*L2;
            L3b=T03*L3;
            LEb=T0E*LE;
            plot(base(1,:),base(2,:),'k');
            plot(L1b(1,:),L1b(2,:),'r','linewidth',3);
            xlim([-10, 10]);
            ylim([-10, 10]);
            hold on;
            plot(L2b(1,:),L2b(2,:),'b','linewidth',3);
            plot(L3b(1,:),L3b(2,:),'g','linewidth',3);
            plot(LEb(1,:),LEb(2,:),'k','linewidth',3);
            %pause(0.00001);
            hold off;

end 