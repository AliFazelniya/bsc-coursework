clc;
clear;
close all;

lambda1 = 10;
lambda2 = 4;
p = 0.3;
N1 = 100;

T = N1 / lambda1;

Runs = 1000;
Acc = zeros(Runs,1);

for k = 1:Runs

    N2 = poissrnd(lambda2*T);

    accidents = 0;

    for i = 1:N2
        if rand < p
            accidents = accidents + 1;
        end
    end

    Acc(k) = accidents;

end

fprintf('Average accidents = %.2f\n',mean(Acc));
fprintf('Std = %.2f\n',std(Acc));
fprintf('Minimum = %d\n',min(Acc));
fprintf('Maximum = %d\n',max(Acc));