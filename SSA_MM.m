%SSA_MM.m


rand('state', 100)


V = [-1 1 0; -1 1 1; 1 -1 -1; 0 0 1];


%%%Condições iniciais
nA = 6.023e23;             %Constante de avogrado
vol = 1e-15;               %Volume do sistema
X = zeros(4,1);
X(1) = round(5e-7*nA*vol); % moleculas de substrato
X(2) = round(2e-7*nA*vol); % moleculas de enzima
c(1) = 1e6/(nA*vol); c(2) = 1e-4; c(3) = 0.1;

subs = [];
product = [];
time = [];
t = 0;
tfinal = 50;
while t < tfinal
    a(1) = c(1)*X(1)*X(2);
    a(2) = c(2)*X(3);
    a(3) = c(3)*X(3);
    asum = sum(a);
    j = min(find(rand<cumsum(a/asum)));
    tau = log(1/rand)/asum;
    X = X + V(:,j);
    t = t + tau; 
    
        
    subs = [subs, X(1)];    
    product = [product, X(4)];
    time = [time, t];
end
plot ( time, subs, '-o', time, product, '-x' );
xlabel("Tempo");
ylabel("Moleculas");
legend("Substrato", "Produto");
axis([0 55 0 320]);
grid on;
