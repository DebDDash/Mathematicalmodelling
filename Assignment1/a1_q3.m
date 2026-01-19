
%% Question b
% Parameters
H = 2;              % Initial height
dt = 0.01;          % Time step (chosen << sqrt(H)) explained in report
t_end = 2*sqrt(H);     % Final time
N = ceil(t_end/dt);    % Number of steps

t = (0:N)*dt; 

% Analytical solution done in report
h_exact = (sqrt(H) - t/2).^2;
h_exact(h_exact < 0) = 0;

% Explicit method
h_exp = zeros(size(t));
h_exp(1) = H;

for n = 1:N
    h_exp(n+1) = h_exp(n) - dt*sqrt(h_exp(n));
    if h_exp(n+1) < 0
        h_exp(n+1) = 0;
    end
end

% Implicit method
h_imp = zeros(size(t));
h_imp(1) = H;

for n = 1:N
    y = (-dt + sqrt(dt^2 + 4*h_imp(n)))/2;
    h_imp(n+1) = y^2;
end

% Find time when h < H/2
idx_exact = find(h_exact < H/2, 1);
idx_exp   = find(h_exp   < H/2, 1);
idx_imp   = find(h_imp   < H/2, 1);

t_exact = t(idx_exact);
t_exp   = t(idx_exp);
t_imp   = t(idx_imp);

fprintf('Time when h < H/2:\n');
fprintf('Analytical : %.4f\n', t_exact);
fprintf('Explicit   : %.4f\n', t_exp);
fprintf('Implicit   : %.4f\n', t_imp);

figure
plot(t, h_exact, 'k-', 'LineWidth', 2); hold on
plot(t, h_exp, 'r--', 'LineWidth', 1.5)
plot(t, h_imp, 'b-.', 'LineWidth', 1.5)
grid on
xlabel('Time')
ylabel('Water height h(t)')
legend('Analytical', 'Explicit', 'Implicit')
title('Tank Emptying: Analytical vs Time-Marching')