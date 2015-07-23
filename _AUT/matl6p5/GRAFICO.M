function ris=grafico(scelta,margini2,b,a,T)
warning off


[b,a]=simplify(b,a);

if ~isempty(find(b~=0))
if scelta==1
%	figure;
[mag,phase,w] = myfbode(T,b,a); 

   [bms,bfsf,omegas,omegasf]=diagas(b,a,w);
   
   magdb=20*log10(mag);
   bms=20*log10(bms);
   subplot(211),semilogx(omegas,bms,'b',w,magdb,'r-')
   title('Diagramma di Bode - Modulo')
   ylabel('dB'),grid;
   
   if T==0
      subplot(212),semilogx(omegasf,bfsf,'b',w,phase,'r-')
   else 
      subplot(212),semilogx(w,phase,'r-')
   end
      title('Diagramma di Bode - Fase')
      ylabel('gradi');

	if margini2
		[Gm,Pm,Wcg,Wcp] = imargin(mag,phase,w); % per tenere conto del ritardo
%		[Gm,Pm,Wcg,Wcp] = margin(mag,phase);
		title(['Gm=',num2str(20*log10(Gm)),' dB (w= ',num2str(Wcg),' rad/sec), Pm=', num2str(Pm), ' gradi (w=', num2str(Wcp),' rad/sec)' ]);	
	end

	
	% Set tick marks up to be in multiples of 30, 90, 180, 360 ... degrees.
   h=gca;
   ytick = get(h, 'ytick');
   ylim = get(h, 'ylim');
   yrange = ylim(2) - ylim(1);
   set(gca, 'ylimmode', 'manual');
	ytick = [-90*round(abs(ylim(1)-90)/90):90:ylim(2)];
   if size(ytick,2)>10
      n=round(size(ytick,2)/10);
      ytick = [-90*round(abs(ylim(1)-90)/90):n*90:ylim(2)];
   end
   	set(gca,'ytick',ytick);
   grid
	% Reset the graph: subplot(111)
	subplot(111)
	return % Suppress output 
	
elseif scelta==2
	figure;
	man=gcf;
	set(man,'numbertitle','off');
	set(man,'name','Diagramma di Nyquist');
	if T==0 nyquistnew(b,a);
	else mynyq(T,b,a);
	end

elseif scelta==3
	
	if T==0	figure; 
		man=gcf;
		set(man,'numbertitle','off');
		set(man,'name','Luogo delle radici');
		rlocus(b,a); 	
	end
end
clear man

end
return;
