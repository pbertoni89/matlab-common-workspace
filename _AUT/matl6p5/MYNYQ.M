function [reout,im,w] = mynyq(T,a,b)
%NYQUIST Nyquist frequency response for continuous-time linear systems with delay T.


if nargin==0, eval('exresp(''nyquist'')'), return, end

% --- Determine which syntax is being used ---
if (nargin==1|nargin==2),
	error('Wrong number of input arguments.');

elseif (nargin==3),	% Transfer function form without frequency vector
	num  = a; den = b; npt=100;
	w = freqint2(num,den,npt);
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
w=w(:);

if T>0 
	giri=2;
	if T>=.1
		delta_w=w(2:size(w,1),1)-w(1:size(w,1)-1,1);
		delta=min(delta_w);
		if (w(size(w,1),size(w,2))>giri*2*pi/T)
			if (giri*2*pi/T-w(1,1))/npt<delta
			   delta=(giri*2*pi/T-w(1,1))/npt;
			end
		end
	
		if (giri*2*pi/T-w(1,1))/delta>10000
			   delta=(giri*2*pi/T-w(1,1))/10000;
		end
		sup=[w(1,1):delta:giri*2*pi/T];
	
	else
		sup=w(:);
		if (w(size(w,1),size(w,2))-w(1,1))>giri*2*pi/T
			sup=w/(w(size(w,1),size(w,2))-w(1,1))*giri*2*pi/T;
		end

	end
	w=sup(:);	
	npt=max(size(w,1),size(w,2));
	if npt<1000
	delta_w=w(2:size(w,1),1)-w(1:size(w,1)-1,1);
	delta=min(delta_w);

	if (w(size(w,1),size(w,2))-w(1,1))/delta>10000
		   delta=(w(size(w,1),size(w,2))-w(1,1))/10000;
	end
	sup=[w(1,1):delta:w(size(w,1),size(w,2))];
end

w=sup(:);
npt=max(size(w,1),size(w,2));

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

	[ny,nn] = size(num); nu = 1;


else
	error(abcdchk(a,b));
	[ny,nu] = size(d);

end

if nu*ny==0, im=[]; w=[]; if nargout~=0, reout=[]; end, return, end

% Compute frequency response
if (nargin==3)
   gt = freqresp(num,den,sqrt(-1)*w);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if T>0
gt=gt.*exp(-i*w*T);
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ret=real(gt); 
imt=imag(gt);


% If no left hand arguments then plot graph.
if nargout==0,
   status = ishold;
   plot(ret,imt,'r-',ret,-imt,'g--')
   set(gca, 'YLimMode', 'auto')
   limits = axis;
   % Set axis hold on because next plot command may rescale
   set(gca, 'YLimMode', 'auto')
   set(gca, 'XLimMode', 'manual')
   hold on
   % Make arrows


   xlabel('Real Axis'), ylabel('Imag Axis')

   limits = axis;
   % Make cross at s = -1 + j0, i.e the -1 point
   if limits(2) >= -1.5  & limits(1) <= -0.5 % Only plot if -1 point is not far out.
	line1 = (limits(2)-limits(1))/50;
	line2 = (limits(4)-limits(3))/50;
	plot([-1+line1, -1-line1], [0,0], 'w-', [-1, -1], [line2, -line2], 'w-')
   end

   % Axis
   plot([limits(1:2);0,0]',[0,0;limits(3:4)]','w:');

   if ~status, hold off, end	% Return hold to previous status
   return % Suppress output
end
reout = ret; 

