



delta = 0.5;



% Width of the middle layer
n = 5;




x = [0.1:0.1:1]';

% Initialize matrices
A1 = zeros(n,length(x));
A2 = zeros(n,n);
A3 = ones(length(x),n);

b1 = zeros(n,1);
b2 = zeros(n,1);
b3 = zeros(length(x),1);



% Activation function sigma(x) = 1./(1 + exp(-x)), 
% sigma'(x) = sigma(x) - sigma^2(x) 

% f(x) = sigma( A3 sigma(A2 sigma( A1 x + b1) + b2 ) + b3 ) 
% Loss fct (1\2) || f(x) - x ||^2 



for k=1:100000
% Function evaluations

    f1 = 1./(1 + exp( - (A1 * x  + b1) ));
    f2 = 1./(1 + exp( - (A2 * f1 + b2) ));
    f3 = 1./(1 + exp( - (A3 * f2 + b3) ));

    L = (1\2) * norm(f3 - x)^2 ;
    
    if mod(k,1000) == 0 
        
        L
        plot(x,f3);
        pause(0.1)
        
    end;
    
    
    if mod(k,10) == 0 && k<1000
        
        L
        plot(x,f3);
        pause(0.2)
        
    end;
    
    if L<10^(-5)
        
        L
        k
        plot(x,f3);
        break;
        
    end
        
    
    
% Derivatives hitting the activation fct

    S1 = diag( f1 - f1.^2 );
    S2 = diag( f2 - f2.^2 );
    S3 = diag( f3 - f3.^2 );

% Cost derivative D_{f3} L

    DL = (f3 - x)'; 

% Last layer D_{b3} L, and update b3

    Db3 = DL * S3;

    b3 = b3 - delta * Db3';

% Last layer D_{A3} L, use Db3 to compute it

    DA3 = (f2 * Db3);

% Second last layer D_{b2} L, update b2 and A3

    Db2 = Db3 * A3 * S2;

    b2 = b2 - delta * Db2';

    A3 = A3 - delta * DA3'; 

% Second last  layer D_{A2} L

    DA2 = (f1 * Db2);

% First layer D_{b1} L, update b1 and A2

    Db1 = Db2 * A2 * S1;
    b1 = b1 - delta * Db1';
    A2 = A2 - delta * DA2'; 

% First layer D_{A1} L, update A3

    DA1 = (x * Db1);
    A1 = A1 - delta * DA1'; 

end