clc; clear;

x1 = input('Enter seed1: ');
x2 = input('Enter seed2: ');
n  = input('Enter number of randoms: ');

seri = zeros(1, n);
seri(1) = x1;
seri(2) = x2;

tt = 2;
while tt < n
    tt = tt + 1;
    
    x = seri(tt-1) * seri(tt-2);
    ss = num2str(x);
    n1 = length(ss);
    
    if length(ss) < 4 
        ss = [repmat('0', 1, 4-length(ss)), ss];
        n1 = length(ss);
    end
 
    mid_start = floor(n1/2) - 1; 
    mid_end = mid_start + 3;

    if mid_start < 1, mid_start = 1; end
    if mid_end > n1, mid_end = n1; end
    
    sss = ss(mid_start : mid_end);
    seri(tt) = str2double(sss);
    
    if seri(tt) < 1000
        seri(tt) = seri(tt) + 1373;
    end
end

plot(1:n, seri, ':o');
title('Random Sequence - Improved Middle Square');
xlabel('Index'); ylabel('Value');
grid on;
