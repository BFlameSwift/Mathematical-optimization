%��ţ�ٷ�
%For Problem 5.8  
%%
%�÷��ű��ʽ����Ŀ�꺯��
clc;
clear;
mu=1;
syms x1 x2;
X=[x1,x2];
f=-9*X(1)-10*X(2)-mu*(log(100-X(1)-X(2))+log(X(1))+log(X(2))+log(50-X(1)+X(2)));

F=eval(['@(x1,x2)',vectorize(f)]);
fx=diff(f,x1); %��f��x1ƫ����
fy=diff(f,x2); %��f��x2ƫ����
fxx=diff(fx,x1); %�����ƫ���� ��x1�ٶ�x1
fxy=diff(fx,x2); %�����ƫ���� ��x1�ٶ�x2
fyx=diff(fy,x1); %�����ƫ���� ��x2�ٶ�x1
fyy=diff(fy,x2); %�����ƫ���� ��x2�ٶ�x2
Gradient=[fx;fy];     %�����ݶȱ��ʽ
Hesse=[fxx,fxy;fyx,fyy];

figure;
hold on;

xx =linspace(0,75,300);
yy = linspace(0,100,400);
[X,Y] = meshgrid(xx,yy);

Z=(X+Y<100).*(X-Y<50).*real(F(X,Y));

imagesc([0,75],[0,100],Z)
axis tight

colorbar
title('\mu=1 with linear seach')


%%
x=[8,90];        %�����ʼ��

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

while (norm(g)>e  && step < N)       %��g��2-����С���ض�ֵʱ�������������������ʱ��ֹͣ����
    if(Check(x))
        break;
    end
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
%    ����Armijo���������Ʋ���ak
%         while(F(xk(1),xk(2)) > (F(x(1),x(2))+0.01*double(p'*g)*ak)||Check(x+ak*double(p')))
%             ak=0.5*ak;
%             xk=x+ak*double(p');
%         end
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
OPT(step+1:N,:)=[];  


%figure;
plot(P(:,1),P(:,2),'-ro')
%axis equal tight
%figure;
%plot(OPT,'b')

%%
x=[1,40];        %�����ʼ��

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

while (norm(g)>e  && step < N)       %��g��2-����С���ض�ֵʱ�������������������ʱ��ֹͣ����
      if(Check(x))
        break;
    end
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
%    ����Armijo���������Ʋ���ak
%         while(F(xk(1),xk(2)) > (F(x(1),x(2))+0.01*double(p'*g)*ak)||Check(x+ak*double(p')))
%             ak=0.5*ak;
%             xk=x+ak*double(p');
%         end
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
OPT(step+1:N,:)=[];  


%figure;
plot(P(:,1),P(:,2),'-black*')
%axis equal tight
%figure;
%plot(OPT,'b')
%%
x=[15,68.69];        %�����ʼ��

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

while (norm(g)>e  && step < N)       %��g��2-����С���ض�ֵʱ�������������������ʱ��ֹͣ����
      if(Check(x))
        break;
    end
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
%    ����Armijo���������Ʋ���ak
%         while(F(xk(1),xk(2)) > (F(x(1),x(2))+0.01*double(p'*g)*ak)||Check(x+ak*double(p')))
%             ak=0.5*ak;
%             xk=x+ak*double(p');
%         end
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
OPT(step+1:N,:)=[];  


%figure;
plot(P(:,1),P(:,2),'-c>')
%axis equal tight
%figure;
%plot(OPT,'b')
%%
x=[10,20];        %�����ʼ��

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

while (norm(g)>e  && step < N)       %��g��2-����С���ض�ֵʱ�������������������ʱ��ֹͣ����
      if(Check(x))
        break;
    end
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
%    ����Armijo���������Ʋ���ak
%         while(F(xk(1),xk(2)) > (F(x(1),x(2))+0.01*double(p'*g)*ak)||Check(x+ak*double(p')))
%             ak=0.5*ak;
%             xk=x+ak*double(p');
%         end
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
OPT(step+1:N,:)=[];  


%figure;
plot(P(:,1),P(:,2),'-ws')
%axis equal tight
%figure;
%plot(OPT,'b')
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

function bool=Check(x)
%�жϵ�x�Ƿ�Խ��
bool=1;
if (x(1)>0&& x(2)>0 && x(1)+x(2)<100&&x(1)-x(2)<50)
    bool=0;
end
end
