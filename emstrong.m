%
% Convergencia forte para o metodo Euler - Maruyama
%
% Resolve dX = lambda*X dt + mu*X dW, X(0) = Xzero, 
% lambda = 2, mu = 1 Xzer0 = 1
%
% Caminho Browniano discretizado sobre [0,1] com dt = 2^ (-9)
% E-M usa 5 diferentes discretizacoes: 16dt, 8dt, 4dt, 2dt e dt
% Testaremos a convergencia forte pata T = 1: E | X_L - X(T) |
%
rand('state', 100)
lambda = 2;mu = 1; Xzero = 1;  % parametros dos problema
T = 1; N = 2^9; dt = T/N;
M = 1000;                      % numero de caminhos amostrados

Xerr = zeros (M,5);

for s = 1:M;   
    dW    = sqrt(dt)*randn(1, N);                    % incrementos Brownianos
    W     = cumsum(dW);                              % Movimento browniano discretizado
    Xtrue = Xzero*exp((lambda-0.5*mu^2)+mu*W(end));  % Solucao analitica
    
    for p = 1:5       

        R = 2^(p-1); Dt = R*dt; L = N/R;             % passo L  de tamanho Dt = R*dt
        Xtemp = Xzero;
        
        for j = 1:L
            Winc = sum( dW( R*(j - 1) + 1:R*j ) );
            Xtemp = Xtemp + Dt*lambda*Xtemp + mu*Xtemp*Winc;
        end  
        Xerr(s, p) = abs( Xtemp - Xtrue ); % guarda o erro para t = 1
    end
end

Dtvals = dt*(2.^([0:4]));
%subplot(221);


loglog(Dtvals, mean(Xerr), 'b*-'), hold on
loglog(Dtvals,(Dtvals.^(.5)), 'r--'), hold off % inclinacao 1/2
axis([1e-3 1e-1 1e-4 1])
xlabel('\Delta t'), ylabel('Sample average of | X_L - X(T) | ')
title('emstrong.m', 'FontSize', 10)

A = [ones(5,1), log(Dtvals)']; rhs = log(mean(Xerr)');
sol = A\rhs; q = sol(2)
resid = norm( A*sol - rhs )

