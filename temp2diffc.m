function D_out = calc_D_at_temp(T, T_unit, D_unit)
% function D = calc_D_at_temp(T, T_unit)
% By Filip Szczepankiewicz, 2015-08-03

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
gamma = 2.066;    % [1]


if nargin < 2
    T_unit = 'C';
end

if nargin < 3
    D_unit = 'm^2/s';
end


switch upper(T_unit)
    case 'K' % Kelvin
        T_K = T;
        
    case 'C' % Celsius
        T_K = T + 273.15;
        
    case 'F' % Farenheit
        T_K = (T+459.67) * 5/9;
        
    otherwise
        error('Temperature unit not supported! Try K, F, or C!');
        
end


D = D0*(T_K./Ts-1).^gamma;


switch D_unit
    case {'m^2/s', 'm2/s', 'm^2s^-1', 'm2s-1'}
        D_out = D;
        
    case {'µm^2/ms', 'µm2/ms', 'µm^2ms^-1', 'µm2ms-1'}
        D_out = D * 1E9;
        
    case {'mm^2/s', 'mm2/s', 'mm^2s^-1', 'mm2s-1'}
        D_out = D * 1E6;
   
    otherwise
        error('Output unit not supported!')
        
end



if numel(T) == 1
    if T_K > (55 + 273.15) || T_K < (5 + 273.15)
        warning(['Specified temperature (' num2str(T) ' °' upper(T_unit) ') is outside ' ...
            'the intended prediction interval (5 to 55 °C)!'])
    end
end




