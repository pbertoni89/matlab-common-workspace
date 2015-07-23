clear, clc, close all
load ict;

% Y = INTEL !

figure('name','Indexes'), plot(apple,'r'), hold on, plot(microsoft,'b')
        plot(nike, 'g'), plot(intel, 'k'), legend('apple','microsoft','nike','intel')

% definizione matrice dei dati
M1 = [apple microsoft nike ones(731,1)]; 
theta1 = inv(M1'*M1)*M1'*intel
yout1 = M1*theta1; 

[n p] = size(M1); 
sigma2 = (1/(n-p)) * sum((intel-yout1).^2);
I = sigma2 * diag(inv(M1'*M1));
conf_I_tstd = tinv(0.975, n-p) * sqrt(I)

mse1 = (1/length(yout1)) * (sum((intel-yout1).^2))
corr1 = corrcoef(yout1, intel)

% feature selection: da modello vuoto, con valori pvalue di default
[b2,se,pval,inmodel_out2] = stepwisefit(M1(:,1:p-1),intel,'penter',0.01);

M2 = M1(:,find(inmodel_out2>0));
M2 = [M2 ones(n,1)];
theta2 = inv(M2'*M2)*M2'*intel;
yout2 = M2*theta2;

mse2 = (1/length(yout2))*sum((intel-yout2).^2)
corr2 = corrcoef(yout2, intel)

% dal precedente comando stepwisefit si verifica (vedere processo di
% calcolo nella command window) che la prima colonna selezionata (con la
% convenzione usata a riga 5 per la definizione di M1) è la colonna 2,
% ovvero quella relativa alla microsoft
% => il titolo che maggiormente influenza il calcolo del titolo intel è microsoft
%   => andiamo ora a stimare il modello avente solo questo come input

M3 = M1(:,2); % prendo soltanto la colonna relativa a microsoft

M3 = [M3 ones(n,1)];
theta3 = inv(M3'*M3)*M3'*intel;
yout3 = M3 * theta3;

mse3 = (1/length(yout3)) * sum((intel-yout3).^2)
corr3 = corrcoef(yout3,intel)
disp('per costruzione uguale a')
corr_microsoft_intel = corrcoef(microsoft, intel)

figure('name','Intel vs Model'), plot(intel, 'k'), hold on
        plot(yout1,'r'), plot(yout2,'g'), plot(yout3,'b'),
        legend('intel', 'model1', 'model2', 'model3')
        
figure('name','Mean Square Errors'), bar([mse1 mse2 mse3])
figure('name','Correlations'), bar([corr1(1,2) corr2(1,2) corr3(1,2)])