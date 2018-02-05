%SSA_MM.m


rand('state', 100)

V = [-1 0 0; 0 0 0];

%%%Condições iniciais
nA = 6.023e23;             %Constante de avogrado
vol = 1e-15;               %Volume do sistema
X = zeros(2,1);
X(1) = 100; % moleculas de substrato
c(1) = 1; c(2) = 0; c(3) = 0;
X(2) = 0.0;


%%%%%%%%%%%%%%%%%%CME%%%%%%%%%%%%%%%%%%%%

subs_cme = [];
product_cme = [];
time_cme = [];
t = 0;
tfinal = 50;
while t < tfinal
    a(1) = c(1)*X(1);    
    asum = sum(a);
    if (asum == 0)
        break;
    end
    j = min(find(rand<cumsum(a/asum)));    
    tau = log(1/rand)/asum;
    X = X + V(:,j);
    t = t + tau;
    subs_cme = [subs_cme, X(1)];        
    time_cme = [time_cme, t];
end

hold on
plot ( time_cme, subs_cme, 'r-');
axis([0 5 0 100]);
grid on;

hold off
xlabel("Tempo");
ylabel("Moleculas");
legend("RRE", "CLE", "CME");