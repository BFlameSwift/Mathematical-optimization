m = 128; n = 256;
A = randn(m,n);

u = sprandn(n,1,0,1);
b = A*u;
% solve 
x0 = zeros(n,1);
x_original = 0.01; x_now = x_original;
step = 0.1;
i =1;
while x_now <= 1
    x0 = zeros(n,1);
    func = @(x) norm(x,x_now);
    x_para_now = fmincon(func,x0,[],[],A,b);
    subplot(2,5,i);
    scatter(1:n,x_para_now);

    i = i +1;
    x_now = x_now +step;
    title(x_now,'范数极小化解')

end
i=1;
while x_now <= 2
    x0 = zeros(n,1);
    func = @(x) norm(x,x_now);
    x_para_now = fmincon(func,x0,[],[],A,b);
    subplot(2,5,i);
    scatter(1:n,x_para_now);

    i = i +1;
    x_now = x_now +step;
    title(x_now,'范数极小化解')

end


