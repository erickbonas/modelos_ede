%CLE_MM.m
%
%
% Chemical Langevin Equation for the Michaelis-Menten system

rand('state', 100)

%
V = [-1 1 0; -1 1 1; 1 -1 -1; 0 0 1];

%%%%%%%Paramtros e condicoes iniciais%%%%%%%
nA = 6.023e23;             %Constante de avogrado
vol = 1e-15;               %Volume do sistema
Y = zeros(4,1);
Y(1) = round(5e-7*nA*vol); % moleculas de substrato
Y(2) = round(2e-7*nA*vol); % moleculas de enzima
c(1) = 1e6/(nA*vol); c(2) = 1e-4; c(3) = 0.1;
tfinal = 50;
subs = [];
product = [];
L = 250;
tau = tfinal/L; %stepsize

for k = 1:L
    a(1) = c(1)*Y(1)*Y(2);
    a(2) = c(2)*Y(3);
    a(3) = c(3)*Y(3);
    d(1) = tau*a(1) + sqrt(abs(tau*a(1)))*randn;
    d(2) = tau*a(2) + sqrt(abs(tau*a(2)))*randn;
    d(3) = tau*a(3) + sqrt(abs(tau*a(3)))*randn;
    Y = Y + d(1)*V(:,1) + d(2)*V(:,2) + d(3)*V(:,3);
    
    subs    = [subs, Y(1)];    
    product = [product, Y(4)];
end
t = 0:tau:50;
subs = [subs, 0];
product = [product, product(250)];

plot (t, subs, '-o', t, product, '-x');
xlabel("Tempo");
ylabel("Moleculas");
legend("Substrato", "Produto");
axis([0 55 0 320]);
grid on;
