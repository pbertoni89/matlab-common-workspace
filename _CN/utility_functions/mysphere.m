function [ x,y,z ] = mysphere( c, r )
%MYSPHERE Returns x,y,z ready for plot3 of a sphere
	% c center, r radius.
	
	phi = linspace(0,pi,30);
	theta = linspace(0,2*pi,40);
	
	[phi, theta] = meshgrid(phi, theta);
	
	x = r*sin(phi).*cos(theta);
	y = r*sin(phi).*sin(theta);
	z = r*cos(phi);

end


