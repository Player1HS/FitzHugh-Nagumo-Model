clear all; close all; clc;

dt=0.5;
t=0:dt:100;
% v' = v - (1/3)v^3 - w + (1/10)(5+sin(pi*t/10))
% w' = (0.7+v-w)/12
v0=0.1;
w0=1;
v0=[v0;w0];
N=@(t,f) ([f(1)-(1/3).*(f(1).^3)-f(2)+(1/10)*(5+sin(pi*t/10));(0.7+f(1)-f(2))./12]); % v=f(1) & w=f(2)
f=zeros(2,length(t)); % 1st row of f is for v, 2nd for w
f(:,1)=v0;

for i=1:length(t)-1 % handmade RK4
    k1=dt.*N(t(i),f(:,i));
    k2=dt.*N(t(i)+(dt/2),f(:,i)+(k1./2));
    k3=dt.*N(t(i)+(dt/2),f(:,i)+(k2./2));
    k4=dt.*N(t(i+1),f(:,i)+k3);
    f(:,i+1)=f(:,i)+(1/6).*(k1+(2.*k2)+(2.*k3)+k4);
end
A7=f(1,:);
plot(t,A7)
[~,maxvidx]=max(A7);
A8=t(maxvidx);
[~,maxvidx2]=max(A7(maxvidx+1:end));
A9=t(maxvidx2+maxvidx);
A10=1/(A9-A8);