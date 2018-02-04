%% Constant Definitions
Rl = 0.0304;
Ron = 0.027;
Vg = 10;

%% Generate Mesh
R = linspace(35,350,1000);
D = linspace(0.65,0.75,1000);
V = zeros(1000,1000);
eta = zeros(1000,1000);

for i=1:1000
    for j = 1:1000
        eta(i,j) = (1-D(i))/((1-D(i)) + ((Ron + Rl) / (R(j) * (1-D(i)))) );
        V(i,j) = 1 / ((1-D(i)) + ((1/(1-D(i))) * ((Ron+Rl)/(R(j)))));
        V(i,j) = V(i,j) * Vg;
    end
end

%% plots

figure;
mesh(R,D,V);

figure;
mesh(R,D,eta);




