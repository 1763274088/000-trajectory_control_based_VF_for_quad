function [] = motor_response

%================================Constants=================================

% Motor Parameters
rotor_mass = 6;                     % mass of rotating motor                (g)
motor_constant = 3100;              % motor revolutions per volt            (KV)
motor_efficiency = 70;              % motor efficiency                      (%)
motor_diameter = 18;                % diameter of the motor                 (mm)                                 
motor_poles = 9;                    % quantity of stator poles
wire_resistance = 0.12;             % line to line motor winding resistance (ohms)
wire_diameter = 0.25;               % winding wire diameter                 (mm)
prop_diameter = 140;                % diameter of the propellor             (mm)
prop_chord = 12;                    % average length of propellor chord     (mm)
prop_mass = 5;                      % mass of the propellor                 (g)

%==========================================================================

clc

wire_length = wire_resistance*pi*(wire_diameter/2*1E-3)^2/(1.68*1E-8);
coil_diameter = (pi*motor_diameter/2*1E-3)/motor_poles;
coil_area = pi*(coil_diameter/2)^2;
coil_turns = (wire_length/(motor_poles/3))/(pi*coil_diameter);
L = 4*pi*1E-7*coil_turns^2*coil_area/(motor_diameter/6*1E-3);

R = wire_resistance/2;
Ke = 1/(motor_constant*motor_efficiency/100)*9.54929659643;
Kt = Ke/0.0605;
J = rotor_mass*1E-3*(motor_diameter/2*1E-3)^2 +...
    prop_mass/12*1E-3*((prop_diameter*1E-3)^2 + (prop_chord*1E-3)^2);

Te = L/(3*R);
Tm = 3*R*J/(Ke*Kt);

display(['Numerator:    [' num2str(1/Ke) ']']);
display(['Denominator:  [' num2str(Tm*Te) ' ' num2str(Tm) ' ' num2str(1) ']']);

%==========================================================================