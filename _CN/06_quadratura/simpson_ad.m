function [ Js nodes ] = simpson_ad( f, a, b, tol, hmin )
%SIMPSON_AD Summary of this function goes here
%   Detailed explanation goes here

A = [a b]; S = []; N = [];

Js = 0; nodes = [];

while isempty(A)==0 %%A(2)-A(1) ~= 0

	Is = simpsonc(A(1),A(end),1,f);
	Isc = simpsonc(A(1),A(end),2,f); 
	% genera 5 nodi totali e questi salverò
	
	DI = abs(Is-Isc);

	gamma = (15/2)*tol*(A(end)-A(1))/(b-a); % magic number teorico
	
	if DI < gamma || A(end)-A(1) < hmin % ramo che può far terminare
		Js = Js + Isc;
		nodes = [nodes linspace(A(1),A(end),5)]; 
		%NON è magic number, ma per costruzione!
		
		S = union(S,A);
		S = [S(1) S(end)]; % sono interessato solo agli estremi
		A = N;
		N = [];
	else
		Amid = (A(end)+A(1))/2;
		N = union( [ Amid A(end) ], N);
		N = [N(1) N(end)];	
		A = [ A(1) Amid ];
	end
end