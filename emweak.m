%
% Teste de convergencia fraca para o metodo Euler-Maruyama
%
% Resolve dX = lambda*X dt + mu*X dW, X(0) = Xzero, 
% lambda = 2, mu = 1, Xzer0 = 1
randn('state', 100);

lambda = 2;
mu = 0.1;
Xzero = 1; 
T = 1;
M = 50000;

Xem = zeros( 5, 1 );
for p = 1:5

    Dt = 2^(p-10);
    L = T/Dt;
    Xtemp = Xzero*ones( M, 1 );
    for j = 1:L
        Winc = sqrt(Dt)*randn( M, 1 );
        Xtemp = Xtemp + Dt*lambda*Xtemp + mu*Xtemp.*Winc;
    end
    Xem(p) = mean(Xtemp);
end
Xerr = abs( Xem - exp( lambda ) );

Dtvals = 2.^([1:5]-10);

loglog( Dtvals, Xerr, 'b*-'), hold on
loglog( Dtvals, Dtvals, 'r--'), hold off
axis([1e-3 1e-1 1e-4 1])
xlabel('\Delta t'), ylabel('| E(X(T)) - Sample average of X_L |')
title('emweak.m', 'FontSize', 10)


