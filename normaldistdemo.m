
function normaldistdemo(k,n)





% k is the number of the dices rolled
% n is the number of dice rolls 

close all; 



% Generate dice rolls from equidistribution on (0,1)

dice = ceil(6 * rand(n,k))';

z = sum(dice)'; % sum



% Compute empirical mean and variance

m = mean(z)
v = var(z)


% Define the range of interest by means of variance
plotmax = round( m + 4*sqrt(v));
plotmin = round( m - 4*sqrt(v) );


x = [plotmin:1:plotmax];
CDFemp = 0;
CDFnorm = 0;

% Normal distribution with mean m and variance v

g = exp(-(x - m).^2/(2 * v))/(sqrt(2 * pi * v)); 



% Compute the cumulative distribution function 

for j = 0 : ( plotmax - plotmin ) 
    
    F(j+1) = sum(z == plotmin + j )/n;
    CDFemptemp = CDFemp(j+1) + F(j+1);
    CDFnormtemp = CDFnorm(j+1) + g(j+1);
    CDFemp = [CDFemp, CDFemptemp];
    CDFnorm = [CDFnorm, CDFnormtemp];
end

CDFnormm = 0;



% Plot empirical distribution and normal distribution 
plot(x,F,'Linewidth',2)
hold on; 
plot(x,g,'Linewidth',2)
string1 = 'Normalized histogram';
string2 = 'Normal distribution';
legend({string1,string2},'Location','northwest','fontsize',14)

figure 

% Plot cumulative distribution functions
plot(CDFemp,'Linewidth',2)
hold on; 
plot(CDFnorm,'Linewidth',2)
string3 = 'CDF empirical';
string4 = 'CDF normal';
legend({string3,string4},'Location','northwest','fontsize',14)


end