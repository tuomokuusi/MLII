function integrator(n)


% Lecture 5 example

smallness = 1/5; 

h= smallness / n;


% Scattered values of the function 
xh = [0:h:2];
 fh = (3*(xh.^2 - xh - 1).^2  + cos(10*xh))/6;


% With oscillatory data nothing works. Test it with the following 
% fh = cos(67*xh);


% Plot the scattered data

scatter(xh,fh)
set(gcf,'Name','Discrete function');

string1 = 'f(x)';

legend(string1,'Location','northeast','fontsize',14)




% The next thing is to plot the original function and compute a rather sharp approximation of the
% integral
hsmall = 10^(-6);
x = [0:hsmall:2];
xint = [0:hsmall:1];
f = (3*(x.^2 - x - 1).^2  + cos(10*x))/6;

% 
% f = cos(67*x);


real_integral = sum(f( 1:floor(length(f)/2) )) * hsmall;



%%%%%%%%

%The weight function to compute the derivatives

A = zeros(n+1);
A(1,1) = 1;

for i=1:n
    A(i+1,1) = 1;
    for j=1:n
        
        A(i+1,j+1) = i^j;  
    
    end
end


% Organize the shifts of fh to a matrix 

for k=1:n+1
    Value_f(k,:) = fh(k:k + length(fh) - n - 1);
end

% The approximation of derivatives is then 

Derivatives_f = inv(A) * Value_f;

% Each column corresponds values [f,h f',  h^2 f''/2! , h^3 f'''/3! ,  h^4 f''''/4!]'
% evaluated at point corresponding the slot in xh

% Let's next see how good is this approximation via these derivatives

fappr = []; 
xappr = [];

for j=1:length(fh) - n - 1

    xapprtemp = [xh(j): hsmall : xh(j+1)-hsmall] - xh(j);
    fapprtemp = 0;
    
    for k=1:n+1

        fapprtemp = fapprtemp + Derivatives_f(k,j) * (xapprtemp/h).^(k-1);
        
    end
    
    xappr = [xappr,xh(j) + xapprtemp];
    fappr = [fappr,fapprtemp];
end

figure

scatter(xh,fh,'filled')

hold on;
plot(x,f,'Linewidth',2)
plot(xappr,fappr,'Linewidth',2)
set(gcf,'Name','Function and its approximation')

string1 = 'Discrete values';
string2 = 'f(x)';
string3 = 'Approximation';

legend({string1,string2,string3},'Location','northeast','fontsize',14)



figure

plot(xappr,fappr - f(1:length(fappr)),'Linewidth',2)
set(gcf,'Name','Approximation Error')
string1 = 'Approximation Error';
legend(string1,'Location','northeast','fontsize',14)

% Then integration by integrating the Taylor series from x to x + h

approx_integral = 0;

for j= 1 : floor( length(fh)/2 )
    
    for k=1:n+1

        approx_integral = approx_integral + (1/k) * Derivatives_f(k,j) * h;
        
    end
    
end
format long


real_integral
approx_integral

error_integral = real_integral - approx_integral


% To estimate the error by means 


