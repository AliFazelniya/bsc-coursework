% AbelBaker.m
% Skeleton implementation of Abel & Baker queue simulation.
clc; clear; close all;

N = 100;
lambdaA = 2;
muAbel = 3;
muBaker = 2;
queueCap = inf;

arrival = cumsum(-log(rand(N,1))/lambdaA);
serviceA = -log(rand(N,1))/muAbel;
serviceB = -log(rand(N,1))/muBaker;

serverFree = [0 0];
serverName = strings(N,1);
startService = zeros(N,1);
endService = zeros(N,1);
wait = zeros(N,1);

for i=1:N
    t = arrival(i);

    if serverFree(1)<=t
        s=1;
    elseif serverFree(2)<=t
        s=2;
    else
        if serverFree(1)<=serverFree(2)
            s=1;
            t=serverFree(1);
        else
            s=2;
            t=serverFree(2);
        end
    end

    startService(i)=t;
    wait(i)=startService(i)-arrival(i);

    if s==1
        endService(i)=t+serviceA(i);
        serverFree(1)=endService(i);
        serverName(i)="Abel";
    else
        endService(i)=t+serviceB(i);
        serverFree(2)=endService(i);
        serverName(i)="Baker";
    end
end

T = table((1:N)',arrival,startService,endService,wait,serverName,...
    'VariableNames',{'Customer','Arrival','Start','End','Waiting','Server'});
disp(T)

figure;
plot(arrival,'b'); hold on;
plot(startService,'g');
plot(endService,'r');
legend('Arrival','Start','End');
grid on;
xlabel('Customer');
ylabel('Time');
title('Abel & Baker Simulation');
