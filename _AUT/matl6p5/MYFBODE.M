function [magout,phase,w] = myfbode(rit,a,b,c,d,iu,w)
%updated 28/4/2004
warning off
nargs = nargin;
if nargs==0, eval('exresp(''fbode'')'), return, end

error(nargchk(2,6,nargs));

% --- Determine which syntax is being used ---
if (nargs==1|nargs==2),
	error('Wrong number of input arguments.');

elseif (nargs==3),	% Transfer function form without frequency vector
	num = a;
	den = b;
	T=rit;npt=100;
	w = freqint(num,den,npt);
	

%-----------------------------------------------------------------
if T>0
  lowfreq=round(log10(w(1,1)));
  highfreq=lowfreq+4;
  if (10^highfreq>w(size(w,1),size(w,2)))
	npt=max(size(w,1),size(w,2))+10^highfreq/w(size(w,1),size(w,2));
	w=logspace(lowfreq,highfreq,npt);
  end
end

dinuovo=1;
while dinuovo
  clc
  risposta=input('Desideri introdurre le pulsazioni? (si/no)  ','s');
  if strcmp(risposta,'no')
	dinuovo=0;
  elseif strcmp(risposta,'si')

	sbagliato=1;
	while sbagliato
		lowfreq=input('w minima (>0):  ') ;
		if size(lowfreq)==[1 1] & isempty(find(imag(lowfreq))) & lowfreq>=0
			sbagliato=0; 
		end
	end

	sbagliato=1;
	while sbagliato
		highfreq=input('w massima: '); 
		if size(highfreq)==[1 1] & isempty(find(imag(highfreq))) & highfreq>lowfreq
			sbagliato=0; 
		end
	end

  	lowfreq=round(log10(lowfreq)-0.5);
	highfreq=round(log10(highfreq)+0.499);
	w=logspace(lowfreq,highfreq,npt);
	dinuovo=0;
  end
	
end
w=w(:);
figure;

%------------------------------------------------------------------

	[ny,nn] = size(num); nu = 1;

elseif (nargs==4),	% Transfer function form with frequency vector
	num = a; den = b;
	w = c;
	[ny,nn] = size(num); nu = 1;

elseif (nargs==5),	% State space system, w/o iu or frequency vector
	error(abcdchk(a,b,c,d));
	w = freqint(a,b,c,d,30);
	[iu,nargs,mag,phase]=mulresp('bode',a,b,c,d,w,nargout,1);
	if ~iu, if nargout, magout = mag; end, return, end
	[ny,nu] = size(d);

elseif (nargs==5),	% State space system, with iu but w/o freq. vector
	error(abcdchk(a,b,c,d));
	w = freqint(a,b,c,d,30);
	[ny,nu] = size(d);

else			% State space system, with iu and freq. vector
	error(abcdchk(a,b,c,d));
	[ny,nu] = size(d);
	
end
if nu*ny==0, phase=[]; w=[]; if nargout~=0, magout=[]; end, return, end


% --- Evaluate the frequency response ---
if (nargs==3)|(nargs==4),
	g = freqresp(num,den,sqrt(-1)*w);
else
	g = freqresp(a,b,c,d,iu,sqrt(-1)*w);
end

%-----------------------------------------------

%if (nargs == 3)|(nargs == 4)
	% It is in transfer function form.  Do directly, using Horner's method
	% of polynomial evaluation at the frequency points, for each row in
	% the numerator.  Then divide by the denominator.
%	[ma,na] = size(num);
%	s = sqrt(-1)*w(:);
%	for i=1:ma
%		g(:,i) = polyval(num(i,:),s);
%	end
%	g = polyval(den,s)*ones(1,ma).\g;
%else
%	[no,nu] = size(d);
%	[ns,na] = size(a);
%	nw = max(size(w));

%	[p,a] = eig(a);	   % Reduce A to diagonal form
%	if rcond(p)<sqrt(eps), 
%		disp('Warning: Diagonalization matrix singular.  Use BODE instead.')
%	end
%	% Apply similarity transformations to B and C
%	if ns>0,
%		b = p \ b(:,iu);  
%		c = c * p;
%		d = d(:,iu);
%		s = (w*sqrt(-1)).';
%		s = s(ones(ns,1),:);
%		a2 = diag(a)*ones(1,nw);
%		b = b*ones(1,nw);
%		g = (c*((1 ./(s-a2)).*b) + diag(d)*ones(no,nw)).';
%	else
%		d = d(:,iu);
%		g = (diag(d)*ones(no,nw)).';
%	end				
%end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

mag=abs(g);%
phase=(180./pi)*unwrap(atan2(imag(g),real(g)));%
phase=phase-180/pi*w*T;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Uncomment out the following statement if you don't want the phase to  
% be unwrapped.  Note that phase unwrapping will not always work; it is
% only a "guess" as to whether +-360 should be added to the phase 
% to make it more aesthetically pleasing.  (See UNWRAP.M)

%phase = (180./pi)*atan2(imag(g),real(g));



%Try to correct phase anomaly for plants with integrators
%by adding multiples of -360 degrees.
if (nargs == 3 | nargs == 4) 
	nd = length(den);
	f = find(fliplr(den) == zeros(1,nd));
	nintgs = sum(f == 1:length(f));	
	if phase(1) > 0 & nintgs > 0
		phase = phase - 360;
	end
else 
	if abs(det(a)) < eps
		if phase(1) > 0 & nintgs > 0
		    phase = phase - 360;
		end
	end
end

% If no left hand arguments then plot graph.
if nargout==0
	holdon = ishold;
	subplot(211) 
	if holdon
		hold on
	end
	semilogx(w,20*log10(mag),w,zeros(1,length(w)),'w:')
	% If hold is set to on on the current axis then set it on the first axis too.
	% This enables two bode response to be superimposed on each other with
	% the following commands:
	%	bode(num, den); hold on; bode(num2, den2)
	grid
	xlabel('Frequency (rad/sec)'), ylabel('Gain dB')

	subplot(212), 
	semilogx(w,phase)
	xlabel('Frequency (rad/sec)'), ylabel('Phase deg')


	% Set tick marks up to be in multiples of 30, 90, 180, 360 ... degrees.
	ytick = get(gca, 'ytick');
	ylim = get(gca, 'ylim');
	yrange = ylim(2) - ylim(1);
	n = round(log(yrange/(length(ytick)*90))/log(2));

	%set(gca, 'ylimmode', 'manual')

	if n >=0 
		%ytick = [-90*2^n:-(90*2^n):ylim(1), 0:(90*2^n):ylim(2)];
		set(gca,'ytick',ytick);
	elseif n >= -2 
		%ytick = [-30:-30:ylim(1), 0:30:ylim(2)];
		set(gca,'ytick',ytick);
	end
	grid
	% Reset the graph: subplot(111)
	subplot(111)
	return % Suppress output 
end

% Uncomment the following line for decibels, but be warned that the
% MARGIN function will not work with decibel data.
% mag = 20*log10(mag);

magout = mag; 
