function myHist1D(X)

nCamp = length(X);

dx = .01;
x = floor(min(X))-1:dx:ceil(max(X))+1; % asse del codominio delle VC
binCenters = floor(min(X))-1+dx/2:dx:ceil(max(X))+1-dx/2; % asse dei centri (per istogrammi)

h_X = hist(X,binCenters);
pdf_X = h_X/(dx*nCamp);
figure, plot(binCenters,pdf_X), axis([floor(min(X))-1 ceil(max(X))+1 0 ceil(max(pdf_X))])