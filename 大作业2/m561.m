%��ʵ����������½���������Ϊ��ȷ����
%%
%�÷��ű��ʽ����Ŀ�꺯��
clc;
clear;
syms x1 x2;
X=[x1,x2];
f=(10*X(1)^2-18*X(1)*X(2)+10*X(2)^2)/2+4*X(1)-15*X(2)+13;
F=eval(['@(x1,x2)',vectorize(f)]);
fx=diff(f,x1); %��f��x1ƫ����
fy=diff(f,x2); %��f��x2ƫ����
fxx=diff(fx,x1); %�����ƫ���� ��x1�ٶ�x1
fxy=diff(fx,x2); %�����ƫ���� ��x1�ٶ�x2
fyx=diff(fy,x1); %�����ƫ���� ��x2�ٶ�x1
fyy=diff(fy,x2); %�����ƫ���� ��x2�ٶ�x2
Gradient=[fx;fy];     %�����ݶȱ��ʽ
Hesse=[fxx,fxy;fyx,fyy];
x=[10,0];        %�����ʼ��

%%
N=200;     %�ܵ�������
e=0.000001;
P=zeros(N,2);    %�����Ĺ켣

%OPT=zeros(N,2);    
g=subs(Gradient,[x1 x2],[x(1) x(2)]);
step=1;
P(step,:)=x;
optim_fx=double(subs(f,[x1 x2],[x(1) x(2)]));
fprintf('Step[%d]:  x=[ %f %f ] optim_fx=%f\n',step,x(1),x(2),double(optim_fx));
OPT(step,:)=optim_fx;   %��������ֵ�½��Ĺ켣
%%
while (norm(g)>e  && step < N)       %��g��2-����С���ض�ֵʱ�������������������ʱ��ֹͣ����
    step=step+1;
    %����Ŀ�꺯����x(k)��һ�׵���ֵ
    g=subs(Gradient,[x1 x2],[x(1) x(2)]);
    %����Ŀ�꺯����x(k)��Hesse����
    G=subs(Hesse,[x1 x2],[x(1) x(2)]);
    %����Ŀ�꺯����x(k)����������p
    %p=-G\g';
    p=-g;
    %��x(k)������������
   
    ak=1;
    ak=Alpha(p,g,G);
%     xk=x+ak*double(p');
%     %����Armijo���������Ʋ���ak
%     while(F(xk(1),xk(2)) > (F(x(1),x(2))+0.1*double(p'*g)*ak))
%         ak=0.5*ak;
%         xk=x+ak*double(p');
%     end
    x=x+double(ak*p');
    %������
    optim_fx=double(subs(f,[x1 x2],[x(1) x(2)]));
    P(step,:)=x;
    OPT(step,:)=optim_fx;
    kk(step-1)=(optim_fx+22)/(OPT(step-1,:)+22);
    fprintf('Step[%d]:  x=[ %f %f ] optim_fx=%f,kk=%f \n',step,x(1),x(2),double(optim_fx),kk(step-1));
    g=subs(Gradient,[x1 x2],[x(1) x(2)]);
end
%������
optim_fx=subs(f,[x1 x2],[x(1) x(2)]);
fprintf('\n�����½���,������ %d ��\n�����\n  x=[ %d %d ] optim_fx=%f\n',step,x(1),x(2),double(optim_fx));
P(step+1:N,:)=[];      %ɾȥP�еĶ���ռ�\
figure;
plot(P(:,1),P(:,2))
hold on;
xx =linspace(-1,12);
yy = linspace(-1,7);
[X,Y] = meshgrid(xx,yy);
Z=F(X,Y);
plot(5,6,'rd')
contour(X,Y,Z,'ShowText','on')
legend('q contours','minimum')
figure;
plot(OPT)
xlabel('n/��������')
ylabel('q(x)')
figure;
plot(kk,'*-')
%%
% �����½����ӳ��򣬼��㾫ȷ����ak
function a=Alpha(p,g,G)
a=-(p'*g)/(p'*G*p);
a=double(a);
end