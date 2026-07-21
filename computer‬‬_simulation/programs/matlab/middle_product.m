clc;
clear;

x1 = input('Enter seed1: ');
x2 = input('Enter seed2: ');
n = input('Enter number of randoms: ');

seri = zeros(1, n);
seri(1) = x1;
seri(2) = x2;

s = num2str(x1);
n1 = length(s);

for tt = 3:n

    x = seri(tt-1) * seri(tt-2);
    ss = num2str(x);
    n2 = length(ss);
    
    if n2 < 2 * n1
        ss = [repmat('0', 1, 2*n1 - n2), ss];
    end
    
    start_idx = floor(n1/2) + 1;
    end_idx = floor(3*n1/2);
    
    sss = ss(start_idx:end_idx);
    seri(tt) = str2double(sss);
end

plot(1:n, seri, ':o');
grid on;
title('Mid-Product Random Number Generation');
xlabel('Index');
ylabel('Value');
