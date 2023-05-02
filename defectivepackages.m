
function defectivepackages(p,m,n)

% m is the number of packages 
% p is the probability that the package is defective
% n is the number of the simulations


close all;

z = 1-floor(min( rand(m,1) / p ,1 ));

def = [];


for k=1:n 

    z = 1-floor(min( rand(m,1) / p ,1 ));
    def = [def,sum(z)];
    
end

y = binopdf([0:1:m],m,p); 


histogram(def);


figure 


yc = 0; 
yg = [];
for k=1:400
    yc = yc + y(k); 
    yg = [yg , yc]; 
     
end

histogram(def,'Normalization','probability');
hold on
plot([0:1:m/10],y(1:m/10+1),'Linewidth',2);
set(gca,'XLim',[-0.500 m/10]);


set(gcf,'Name','Binomial distribution')

string1 = 'Normalized histogram of 10^6 simulations';
string2 = 'Binomial distribution: (p=0.02,m=400)';


legend({string1,string2},'Location','northeast','fontsize',14)



figure 


string3 = 'Cumulative Distribution Function';


set(gcf,'Name','Probability distribution and CDF')
plot([0:1:m/20],y(1:m/20+1),'Linewidth',2);
hold on;
plot([0:1:m/20],yg(1:m/20+1),'Linewidth',2);

legend({string2,string3},'Location','northwest','fontsize',14)

set(gca,'YLim',[0 1])





y = binopdf([0:1:m],m,p); 



end