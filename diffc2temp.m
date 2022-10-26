function T_out = calc_temp_at_D(D, T_unit)
% function D_out = calc_temp_at_D(T, T_unit, D_unit)
% By Filip Szczepankiewicz, 2015-11-09

% Function calculates the diffusivity D [m^2/s]
% of pure water at given temperature T [K or C], based on
% Holz et al. 2000, Phys. Chem. Chem. Phys., 2, 4740-4742.
% The function is intended for the interval 5 to 55 °C.

% Input / Output
%   T      - Scalar or matrix of temperatures
%   T_unit - Unit in which T is specified
%   D_unit - Unit of the output diffusivity
%   D_out  - Diffusion coefficient in unit specified by D_unit


D0    = 1.635E-8; % m^2/s
Ts    = 215.05;   % K
gamma = 2.063;    % [1]


if nargin < 2
    T_unit = 'C';
end


T_K = ( (D / D0)^(1/gamma) + 1 )*Ts;


switch upper(T_unit)
    case 'K' % Kelvin
        T_out = T_K;
        
    case 'C' % Celsius
        T_out = T_K - 273.15;
        
    case 'F' % Farenheit
        T_out = (T-273.15)*1.8 + 32;
        
    otherwise
        error('Temperature unit not supported! Try K, F, or C!');
end



if numel(T_K) == 1
    if T_K > (55 + 273.15) || T_K < (5 + 273.15)
        warning(['Specified temperature (' num2str(T_out) ' °' upper(T_unit) ') is outside ' ...
            'the intended interval (5 to 55 °C)!'])
    end
end




