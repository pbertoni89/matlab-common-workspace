clear amb;
clear all;
clc;

cam_params=[10 11 12 13 14];
city_params=[1234 1000];

amb=ambiente();

amb=amb.new_camino(cam_params);

amb=amb.new_city(city_params);

[mtx,amb]=amb.dump();