1;
function xdot = f (x,t)
    xdot=-x;
endfunction 

x = lsode("f", 100, (t = linspace(0,5,50)'));

hold on
plot(t,x, "g-");
hold off
xlabel("Tempo");
ylabel("Moleculas");
%legend("RRE");
axis([0 5 0 100]);