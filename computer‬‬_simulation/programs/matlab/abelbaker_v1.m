clc;
clear;
close all;

%% Parameters
n = 10;          % Queue Capacity
N = 20;          % Number of Customers

LambdaA = 2;     % Arrival Rate (customer/min)
LambdaS = 2;     % Service Rate (customer/min)

%% Initialization

TbArr = zeros(1,N);      % Time Between Arrivals
TArr  = zeros(1,N);      % Arrival Times

LoQu  = zeros(1,N);      % Queue Length
DfQu  = zeros(1,N);      % Dropped Customers

StartSer = zeros(1,N);
EndSer   = zeros(1,N);
TServ    = zeros(1,N);
Totaltime= zeros(1,N);

NiQu = 0;

%% First Customer

iQ = 1;

TbArr(1) = -log(rand)/LambdaA;
TArr(1)  = TbArr(1);

NiQu = 1;

iSer = 1;

StartSer(1) = TArr(1);
TServ(1) = -log(rand)/LambdaS;
EndSer(1) = StartSer(1)+TServ(1);

Timer = EndSer(1);

Totaltime(1)=EndSer(1)-TArr(1);

NiQu = NiQu-1;

LoQu(1)=NiQu;

%% Simulation

while(iQ < N)

    summ = 0;

    while(summ < TServ(iSer))

        x = -log(rand)/LambdaA;

        if(x < TServ(iSer)-summ)

            iQ = iQ + 1;

            TbArr(iQ)=x;
            TArr(iQ)=TArr(iQ-1)+x;

            summ = summ + x;

            if(NiQu < n)

                NiQu = NiQu + 1;

            else

                DfQu(iQ)=1;

                NiQu=n;

            end

            LoQu(iQ)=NiQu;

        else

            summ = TServ(iSer);

        end

    end

    if(iSer < iQ && NiQu>0)

        iSer = iSer + 1;

        StartSer(iSer)=Timer;

        if(StartSer(iSer)<TArr(iSer))
            StartSer(iSer)=TArr(iSer);
        end

        TServ(iSer)=-log(rand)/LambdaS;

        EndSer(iSer)=StartSer(iSer)+TServ(iSer);

        Timer=EndSer(iSer);

        Totaltime(iSer)=EndSer(iSer)-TArr(iSer);

        NiQu=NiQu-1;

    end

end

%% ==========================
%% Plot Section (Extracted)
%% ==========================

% plot(TArr(1:30),LoQu(1:30),'--*', ...
%      TArr(1:30),DfQu(1:30),'-o', ...
%      TArr(1:30),EndSer(1:30),'->', ...
%      TArr(1:30),StartSer(1:30),'-<')

N1 = length(TServ);
N2 = length(EndSer);
N3 = length(StartSer);
N4 = length(LoQu);
N5 = length(DfQu);
N6 = length(TbArr);

figure;

plot( ...
    1:N4,LoQu(1:N4),'--*', ...
    1:N5,DfQu(1:N5),'-o', ...
    1:N2,EndSer(1:N2),'->', ...
    1:N3,StartSer(1:N3),'-<', ...
    1:N6,TbArr(1:N6),':o', ...
    'LineWidth',1.5);

grid on;

legend( ...
    'Queue Length', ...
    'Dropped Customers', ...
    'End Service', ...
    'Start Service', ...
    'Interarrival Time', ...
    'Location','best');

xlabel('Customer Number');
ylabel('Time (minute)');
title('Queue Simulation Results');

%% ==========================
%% Statistics
%% ==========================

fprintf('\n----------- Simulation Results -----------\n');

fprintf('Total Customers           : %d\n',N);

fprintf('Served Customers          : %d\n',iSer);

fprintf('Dropped Customers         : %d\n',sum(DfQu));

fprintf('Average Service Time      : %.4f\n',mean(TServ(1:iSer)));

fprintf('Average Total Time        : %.4f\n',mean(Totaltime(1:iSer)));

fprintf('Maximum Queue Length      : %d\n',max(LoQu));

fprintf('------------------------------------------\n');