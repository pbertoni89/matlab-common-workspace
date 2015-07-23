function I = midpointc(a,b,M,f) 
%Formula composita del punto medio. 
	 Hmid=(b-a)/M; 
	 xmid = linspace(a,b,M+1)
	 I=0; 
	 for k=2:M+1; 
		 I=I+f((xmid(k-1)+xmid(k))/2); 
	 end
	 I=I*Hmid; 
return