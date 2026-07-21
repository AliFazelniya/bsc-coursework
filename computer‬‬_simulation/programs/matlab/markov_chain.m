clc;
P = [0.20 0.70 0.10;
    0.60 0.30 0.10;
    0.80 0.20 0.0];
x = 0;
k = input('Enter k: ');
S = eye(3);

StartPoint = [0.10 0.90 0.0];
for i = 1:k
    S = S * P;
    x(i) = S(1, 1) + S(2, 2) + S(3, 3);
end
FinalProb = StartPoint * S;
P; S; plot(1:k, x, '-O')