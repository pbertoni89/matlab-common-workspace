close all;
clc;
clear all;
format compact;

m=1;
L=1;
J=m*L^2;
F1=1;
F2=0;
h=0.2;
x0=[0.1,0]';

%% 1) equazioni
% x1 posizione ang.
% x2 velocità ang.
%
%J*Dx2=-F1*L*sin(x1)-F2*L*cos(x1)-h*x2
%Dx1=x2
%Dx2=-F1*L*sin(x1)/J-F2*L/J*cos(x1)-h/J*x2
%% 2) punti di equilibrio
% Dx1=0 -> x2=0
% Dx2=0 ->
% -F1*L*sin(x1)-F2*L*cos(x1)=0
% -F1*sin(x1)-F2*cos(x1)=0
% F1*sin(x1)=0
% sin(x1)=0 -> x1=0 o x1=pi
% eq1=[0;0]
% eq2=[pi;0]
%% 3) linearizzazione
%Dx1=x2
%Dx2=-F1*L*sin(x1)/J-F2*L/J*cos(x1)-h/J*x2
% y=x1
%
%A=[0                           1;
%-F1*L*cos(x1)/J+F2*L/J*sin(x1) -h/J];
%B=[0 0;
%-L/J*sin(x1) -L/J*cos(x1)];
%C=[1 0];
%D=[0 0];
%
%% eq1 x1=0,F1=1,F2=0
%A=[0 1;-1*L/J -h/J]
%B=[0 0;0 -L/J]
%C=[1 0];
%D=[0 0];

%% eq2 x1=pi,F1=1,F2=0
%A=[0 1;1*L/J -h/J]
%B=[0 0;0 L/J]
%C=[1 0];
%D=[0 0];

%% 4) Classificazione
%% 5) legge di controllo eq1 tass=1
%% 5a) considerando solo F1
%% 5b) considerando solo F2

%% 6) Osservatore eq1