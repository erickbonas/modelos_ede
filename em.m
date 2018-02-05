% Metodo Euler-Maruyama

randn( 'state', 100 ) 
lambda = 2; mu = 1; Xzero = 1; 
T = 1; N = 2^8; dt = 1/N;
dW = sqrt( dt )*randn( 1, N );
W = cumsum( dW );

Xtrue = Xzero*exp((lambda-0.5*mu^ 2)*([dt:dt:T])+mu*W);
plot( [0:dt:T], [Xzero, Xtrue], 'b-'), hold on

R = 4; Dt = R*dt; L = N/R; 
Xem = zeros( 1, L );
Xtemp = Xzero;
for j = 1:L
    Winc = sum( dW(R*(j - 1)+1:R*j ) );
    Xtemp = Xtemp + Dt*lambda*Xtemp + mu*Xtemp*Winc;
    Xem(j) = Xtemp;
end

plot( [0:Dt:T], [Xzero, Xem], 'r--*'), hold off
xlabel('t', 'FontSize', 12)
ylabel('X', 'FontSize', 16, 'Rotation', 0, 'HorizontalAlignment', 'right')


emerr = abs(Xem(end)-Xtrue(end))