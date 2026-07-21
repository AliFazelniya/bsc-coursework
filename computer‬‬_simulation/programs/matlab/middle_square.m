clc;
clear;

x = input('Enter seed: ');
n = input('Enter number of randoms: ');

seri = zeros(1, n);
tt = 0;

while tt < n
    tt = tt + 1;
    seri(tt) = x;
    
    s = num2str(x);
    n1 = length(s);
    
    xx = x * x;
    ss = num2str(xx);
    n2 = length(ss);
    
    if n2 < 2 * n1
        for i = 1:(2 * n1 - n2)
            ss = ['0', ss];
        end
    end

    start_idx = floor(n1 / 2) + 1;
    end_idx = floor(3 * n1 / 2);
    
    sss = ss(start_idx : end_idx);
    x = str2double(sss);
end

plot(1:n, seri, ':o')
grid on;
