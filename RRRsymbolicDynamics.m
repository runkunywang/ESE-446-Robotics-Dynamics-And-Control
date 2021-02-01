%syms l1 l2 l3 m1 m2 m3
syms q1 real
syms q2 real
syms q3 real
syms g real
l1 = 4;
l2 = 3;
l3 = 2;
m1 = 20;
m2 = 15;
m3 = 10;
ic1 = 0.5;
ic2 = 0.2;
ic3 = 0.1;

%transformation matrices
trans01 = [cos(q1) -sin(q1) 0 0; sin(q1) cos(q1) 0 0; 0 0 1 0; 0 0 0 1];
trans12 = [cos(q2) -sin(q2) 0 l1; sin(q2) cos(q2) 0 0; 0 0 1 0; 0 0 0 1];
trans23 = [cos(q3) -sin(q3) 0 l2; sin(q3) cos(q3) 0 0; 0 0 1 0; 0 0 0 1];
trans3E = [1 0 0 l3; 0 1 0 0; 0 0 1 0; 0 0 0 1];

%pcn point
pc1 = [l1/2; 0; 0; 1];
pc2 = [l2/2; 0; 0; 1];
pc3 = [l3/2; 0; 0; 1];
pcE = [0; 0; 0; 1];

%transposed pcn point
transPc1 = trans01*pc1;
transPc2 = trans01*trans12*pc2;
transPc3 = trans01*trans12*trans23*pc3;
transPcE = trans01*trans12*trans23*trans3E*pcE;

transPc1 = transPc1';
transPc2 = transPc2';
transPc3 = transPc3';

%jacobian 
jv1 = jacobian(transPc1(1:3), [q1 q2 q3]);
jv2 = jacobian(transPc2(1:3), [q1 q2 q3]);
jv3 = jacobian(transPc3(1:3), [q1 q2 q3]);

jv1 = simplify(jv1)
jv2 = simplify(jv2)
jv3 = simplify(jv3)

jw1 = [0 0 0; 0 0 0; 1 0 0];
jw2 = [0 0 0; 0 0 0; 1 1 0];
jw3 = [0 0 0; 0 0 0; 1 1 1];

%inertial matrix
Ic1 = [0 0 0; 0 0 0; 0 0 ic1];
Ic2 = [0 0 0; 0 0 0; 0 0 ic2];
Ic3 = [0 0 0; 0 0 0; 0 0 ic3];

%mass matrix
mv1 = simplify(jv1'*jv1*m1);
mv2 = simplify(jv2'*jv2*m2);
mv3 = simplify(jv3'*jv3*m3);
mw1 = jw1'*Ic1*jw1;
mw2 = jw2'*Ic2*jw2;
mw3 = jw3'*Ic3*jw3;

mtotal = mv1+mv2+mv3+mw1+mw2+mw3;
mtotal = simplify(mtotal);

m11 = mtotal(1,1)
m12 = mtotal(1,2)
m13 = mtotal(1,3)
m21 = mtotal(2,1)
m22 = mtotal(2,2)
m23 = mtotal(2,3)
m31 = mtotal(3,1)
m32 = mtotal(3,2)
m33 = mtotal(3,3)

%%
GMatrix=-(jv1'*[0;-m1*g;0]+(jv2'*[0;-m2*g;0])+(jv3'*[0;-m3*g;0]))
GMatrix = simplify(GMatrix)

%%
%b111=diff()
