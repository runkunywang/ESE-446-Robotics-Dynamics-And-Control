clear all
t=[0 2 4 6 8];
t=0:2:8;
tt=0:0.001:8;

t1=[0 30 45 150 180]*pi/180;
t2=[0 -10 130 10 0]*pi/180;
t3=[90 70 -85 70 -90]*pi/180;
 YY=spline(t, t1,tt);

  YY2=spline(t, t2,tt);
 YY3=spline(t, t3,tt);

%  figure(1)
%  plot(t,t1,'o',tt,YY)
%  
%  figure(2)
%  plot(t,t2,'o',tt,YY2)
%  
%  figure(3)
%  plot(t,t3,'o',tt,YY3)
 
trajectory=transpose([tt; YY; YY2; YY3]);
