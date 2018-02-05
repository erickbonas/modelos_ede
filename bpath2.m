%BPATH Brownian path simulation: vectorized

%randn('state', 100 ) 
1;
function [W,dt] = wierner ( T, N )    
    dt = T/N;
    dW = sqrt(dt)*randn(1,N);
    W = cumsum(dW);
end 

hold on 

[W,dt] = wierner( 1, 100 );
plot([0:dt:T], [0,W], 'r--')

[W,dt] = wierner( 1, 1000 );
plot([0:dt:T], [0,W], 'b--')

[W,dt] = wierner( 1, 10000 );
plot([0:dt:T], [0,W], 'g--')


hold off
xlabel('t', 'FontSize', 16)
ylabel('W(t)', 'FontSize', 16, 'Rotation', 0)
