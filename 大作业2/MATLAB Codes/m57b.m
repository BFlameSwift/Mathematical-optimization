%�˳���Ϊ������5.7��ţ�ٷ�
clc;
clear;
X=zeros(5,1);
P=zeros(5,1);
x=7.88;
step=0;
fun =@(x) 9*x-4*log(x-7);
%while (abs(g(x))>0.000001)
while (step<5)
    step=step+1;
    x=x-g(x)./G(x);
    X(step)=x;
    P(step)=f(x);
   %x=x-0.25*(x-7)*(9*x-67)
end

%[s1,s2]= fminsearch(fun,7);
function y=f(x)
y=9*x-4*log(x-7);
end

function y=g(x)
y=9-4./(x-7);
end 

function y=G(x)
y=4./(x-7).^2;
end
