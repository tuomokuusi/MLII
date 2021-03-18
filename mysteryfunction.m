function [value,slope,tangentline] = mysteryfunction(x,plotx,reveal)

% This is the code to find the mystery function used in the second lecture
% of ML2

% The function and its slope are evaluated and plotted at point 'x' using
% 'plotx'

% If the input 'reveal' is given value 'revealmystery', then the whole
% graph of function is plotted



if strcmp(reveal,'revealmystery')

    value = exp(x) + exp(-x) + sin(4*x);
    valuex = exp(plotx) + exp(-plotx) + sin(4*plotx);
    slope = exp(x) - exp(-x) + 4*cos(4*x);
    tangentline = value + slope * (plotx - x);
    plot(plotx , tangentline,':');
    hold on
    scatter(x,value)
    plot(plotx , valuex);

else
    
    value = exp(x) + exp(-x) + sin(4*x);    
    slope = exp(x) - exp(-x) + 4*cos(4*x);

    tangentline = value + slope * (plotx - x);

    plot(plotx , tangentline,':');
    hold on
    scatter(x,value)

end

