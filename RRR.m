function y=RRR(tau,q)
% %syms l1 l2 l3 m1 m2 m3
% syms q1 q2 q3
% syms tau
% 
% syms q1dot q2dot q3dot 
q1=q(1);
q1dot=q(2);
q2=q(3);
q2dot=q(4);
q3=q(5);
q3dot=q(6);


SF1=5;
DF1=5;

SF2=0;
DF2=0;

SF3=0;
DF3=0;

% syms g real
% syms a real
% m=[a]; %note m is 3 by 3 by 3
% b=[a]; %note b is 3 by 3 by 3
% C=[a]; %note C is 3 by 3
% B=[a]; %note b is 3 by 3

%syms b111 b122 133 real
%syms b211 b222 b233 real
%syms b311 b322 b333 real

l1 = 4;
l2 = 3;
l3 = 2;
m1 = 20;
m2 = 15;
m3 = 10;
ic1 = 0.5;
ic2 = 0.2;
ic3 = 0.1;
%%
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

jv1 = simplify(jv1);
jv2 = simplify(jv2);
jv3 = simplify(jv3);

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

m11 = mtotal(1,1);
m12 = mtotal(1,2);
m13 = mtotal(1,3);
m21 = mtotal(2,1);
m22 = mtotal(2,2);
m23 = mtotal(2,3);
m31 = mtotal(3,1);
m32 = mtotal(3,2);
m33 = mtotal(3,3);

%%
GMatrix=-(jv1'*[0;-m1*g;0]+(jv2'*[0;-m2*g;0])+(jv3'*[0;-m3*g;0]));


%%


%1st row b(ijk)=1/2*(mijk+mikj-mjki)


for i=1:3
    for j=1:3
    m(i,j,1)=diff(mtotal(i,j),q1);  %calculate m111 m211 m311
    m(i,j,2)=diff(mtotal(i,j),q2);  %calculate m122 m222 m322
    m(i,j,3)=diff(mtotal(i,j),q3);  %calculate m133 m233 m333
    end 
end 

%%

for i=1:3
    for j=1:3
        for k=1:3
            b(i,j,k)=1/2*(m(i,j,k)+m(i,k,j)-m(j,k,i));
        end 
    end 
end 

for i=1:3
    for j=1:3
      C(i,j)=b(i,j,j);
    end 
end 



for i=1:3
    for j=1:2
      B(i,j)=2*b(i,1,j+1);
    end 
end 

B(1,3)=2*b(1,2,3);
B(2,3)=2*b(2,2,3);
B(3,3)=2*b(3,2,3);

J1F=SF1*sign(q1dot)+DF1*q1dot;
J2F=SF2*sign(q2dot)+DF2*q2dot;
J3F=SF3*sign(q3dot)+DF3*q3dot;

q1dd=pinv(mtotal)*(tau-V-G);

xdot=q1dd;
y=xdot;
end 