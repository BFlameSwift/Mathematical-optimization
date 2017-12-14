%ţ��Armijo���ݷ�
%%
%�÷��ű��ʽ����Ŀ�꺯��
clc;
clear;
syms x1 x2;
X=[x1,x2];
f=100*(X(2)-X(1)^2)^2+(1-X(1))^2;

F=eval(['@(x1,x2)',vectorize(f)]);
fx=diff(f,x1); %��f��x1ƫ����
fy=diff(f,x2); %��f��x2ƫ����
fxx=diff(fx,x1); %�����ƫ���� ��x1�ٶ�x1
fxy=diff(fx,x2); %�����ƫ���� ��x1�ٶ�x2
fyx=diff(fy,x1); %�����ƫ���� ��x2�ٶ�x1
fyy=diff(fy,x2); %�����ƫ���� ��x2�ٶ�x2
Gradient=[fx;fy];     %�����ݶȱ��ʽ
Hesse=[fxx,fxy;fyx,fyy];
x=[-1.2,1];        %�����ʼ��

%%
N=100;     %�ܵ�������
e=0.000001;
P=zeros(N,2);    %�����Ĺ켣
OPT=zeros(N,2);     %��������ֵ�½��Ĺ켣
g=subs(Gradient,[x1 x2],[x(1) x(2)]);
step=1;
P(step,:)=x;
optim_fx=subs(f,[x1 x2],[x(1) x(2)]);
fprintf('Step[%d]:  x=[ %f %f ] optim_fx=%f\n',step,x(1),x(2),double(optim_fx));
OPT(step,:)=optim_fx;
%%

while (norm(g)>e  && step < N)       %��g��2-����С���ض�ֵʱ�������������������ʱ��ֹͣ����
    step=step+1;
    %����Ŀ�꺯����x(k)��һ�׵���ֵ
    g=subs(Gradient,[x1 x2],[x(1) x(2)]);
    %����Ŀ�꺯����x(k)��Hesse����
    G=subs(Hesse,[x1 x2],[x(1) x(2)]);
    %����Ŀ�꺯����x(k)����������p
    p=-inv(G)*g;
    %p=-g;
    %��x(k)������������
    %ak=Alpha(p,g,G);
    %ak=1;
    ak=1;
    xk=x+ak*double(p');
    %����Armijo���������Ʋ���ak
    while(F(xk(1),xk(2)) > (F(x(1),x(2))+0.01*double(p'*g)*ak))
        ak=0.5*ak;
        xk=x+ak*double(p');
    end
    x=x+double(ak*p');
    %������
    optim_fx=subs(f,[x1 x2],[x(1) x(2)]);
    fprintf('Step[%d]:  x=[ %f %f ] optim_fx=%f\n',step,x(1),x(2),double(optim_fx));
    P(step,:)=x;
    OPT(step,:)=optim_fx;
    g=subs(Gradient,[x1 x2],[x(1) x(2)]);
end
%������
optim_fx=subs(f,[x1 x2],[x(1) x(2)]);
fprintf('\nţ��Armijo���ݷ�,,������ %d ��\n�����\n  x=[ %d %d ] optim_fx=%f\n',step,x(1),x(2),double(optim_fx));
P(step+1:N,:)=[];      %ɾȥP�еĶ���ռ�
figure;
plot(P(:,1),P(:,2),'-o')
hold on;
xx =linspace(-1.5,1.5);
yy = linspace(-0.5,1.5);
[X,Y] = meshgrid(xx,yy);
Z=F(X,Y);
contour(X,Y,Z,'ShowText','on')
figure;
plot(OPT)
%%
% ���㾫ȷ����ak
function a=Alpha(p,g,G)
    a=-(p'*g)/(p'*G*p);
end

%����Armijo���������Ʋ���ak
function a=Armijo(x,p,g)
    a=1;
    xk=x+a*double(p);
    while(F(xk(1),xk(2)) > F(x(1),x(2))+0.01*doubel(p'*g)*a)
        a=0.9*a;
        xk=xk+a*double(p);
    end
end