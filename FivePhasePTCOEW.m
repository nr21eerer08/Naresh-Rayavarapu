% Variables required by the control algorithm
% global Ts Rs Lr Lm Ls p tr kr r_sigma t_sigma lambda v states
% Sampling time of the predictive algorithm [s]
 Ts = 5e-5;
% PI speed controller parameters
 Tsw = 0.002; % Sampling time of the PI controller [s]
 Kp =0.032; % Proportional gain
 Ki = 0.0022; % Integrative gain
 Kp1 = 0.081;
 Ki1 = 0.28;
% Machine parameters
 J = 0.0148; % Moment of inertia [kg m^2]
 p = 2; % Pole pairs
 P = 4;
 Lm = 84.73e-3; % Magnetizing inductance [H]
 Ls = 90e-3; % Stator inductance [H]
 Lr = 90e-3; % Rotor inductance [H]
 Llr= 6e-3;
 Lls = 6e-3; % Stator Leakage inductance [H]
 Rs = 1.05; % Stator resistance [Ohm]
 Rr = 1.42; % Rotor resistance [Ohm]
 sf_nom = 0.2; % Nominal stator flux [Wb]
 T_nom = 5; % Nominal torque [Nm]
 % DC-link voltage [V]
 Vdc = 100;
 % Auxiliary constants
 ts = Ls/Rs;
 tr = Lr/Rr;
 sigma = 1-(((Lm)^2)/(Lr*Ls));
 kr = Lm/Lr;
 r_sigma = Rs+kr^2*Rr;
t_sigma = sigma*Ls/r_sigma;
 % Weighting factor for the cost function of PTC
 lambda = 1*T_nom/sf_nom;
% Voltage vectors
v32  = 0;
v25 = (1.1707+1j*0.3804)*Vdc;  %%(0.6472*Vdc)-(-0.5235*Vdc-1i*0.3804*Vdc);                  
v24 = (0.7235+1j*0.9959)*Vdc;  %%(0.5235*Vdc+1i*0.3804*Vdc)-(-0.1999*Vdc-1i*0.6155*Vdc);
v28 = (1i*1.2310)*Vdc;         %%(0.1999*Vdc+1i*0.6155*Vdc)-(0.1999*Vdc-1i*0.6155*Vdc);
v12 = (-0.7235+1j*0.9959)*Vdc; %%(-0.1999*Vdc+1i*0.6155*Vdc)-(0.5235*Vdc-1i*0.3804*Vdc);
v14 = (-1.1707+1j*0.3804)*Vdc; %%(-0.5235*Vdc+1i*0.3804*Vdc)-(0.6472*Vdc);
v6  = (-1.1707-1j*0.3804)*Vdc; %%(-0.6472*Vdc)-(0.5235*Vdc+1i*0.3804*Vdc);
v7  = (-0.7235-1j*0.9959)*Vdc; %%(-0.5235*Vdc-1i*0.3804*Vdc)-(0.1999*Vdc+1i*0.6155*Vdc);
v3  = (-1j*1.2310)*Vdc;        %%(-0.1999*Vdc-1i*0.6155*Vdc)-(-0.1999*Vdc+1i*0.6155*Vdc);
v19 = (0.7235-1j*0.9959)*Vdc;  %%(0.1999*Vdc-1i*0.6155*Vdc)-(-0.5235*Vdc+1i*0.3804*Vdc);
v17 = (1.1707-1j*0.3804)*Vdc;  %%(0.5235*Vdc-1i*0.3804*Vdc)-(-0.6472*Vdc);
v31 = 0;
v =  [v32 v25 v24 v28 v12 v14 v6 v7 v3 v19 v17 v31];
% Switching states
states1 = [0 0 0 0 0;1 1 0 0 1;1 1 0 0 0;1 1 1 0 0;0 1 1 0 0;0 1 1 1 0;0 0 1 1 0;0 0 1 1 1;0 0 0 1 1;1 0 0 1 1;1 0 0 0 1;1 1 1 1 1];
states2 = [0 0 0 0 0;0 0 1 1 1;0 0 0 1 1;1 0 0 1 1;1 0 0 0 1;1 1 0 0 1;1 1 0 0 0;1 1 1 0 0;0 1 1 0 0;0 1 1 1 0;0 0 1 1 0;1 1 1 1 1];