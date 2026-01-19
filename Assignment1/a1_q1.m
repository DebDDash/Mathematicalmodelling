% Parameters given in Question
A = 0.3;
B = 2.5;
DeltaP = 15;


%% Question a

Q = linspace(0.1, 10, 500); % 500 is variable value (to get a smooth curve we chose this)

% Function G(Q)
G = DeltaP./Q - A*log(Q) - B; % the dot is used in cases of element wise division, w/o dot it is matrix division

% Plot
figure
plot(Q, G, 'LineWidth', 2)
grid on
xlabel('Flow rate Q (mL/s)')
ylabel('G(Q)')
title('G(Q) = \DeltaP/Q - A log(Q) - B')



%% Question b

% Since the plot shows that it is a monotonic function we can use fzero
% fzero cannot find a root of a function when there is a sign change
% f(0.1)*f(10) < 0

Gfun = @(Q) DeltaP./Q - A*log(Q) - B;
x0 =[0.1,10];
x = fzero (Gfun,x0);
fprintf('Root = %.4f mL/s\n', x);

%% Question c

% Fixed-point iteration

N = 6;
Q = zeros(1, N+1); % creates a vector of all values from Q(1) to Q(N+1)
Q(1) = 1;   

for n = 1:N
    Q(n+1) = DeltaP / (A * log(Q(n)) + B);
end

disp('Iteration values:')
for n = 1:N+1
    fprintf('Q(%d) = %.6f\n', n, Q(n));
end

%% Question d

Q_star = x;       
n = 1:length(Q)-1;      

error = abs(Q(1:end-1) - Q_star);

% Plot
figure
semilogy(n, error, 'o-', 'LineWidth', 1.5)
grid on
xlabel('Iteration n')
ylabel('|Q_n - Q^*|')
title('Convergence of Fixed-Point Iteration')

%% Question e

% We experimented with various positive initial guesses outside range such
% as 200,1000 we observe a convergence this maybe as denominator is log due
% to which values remain bounded
Q(1) = 1000;    
for n = 1:N
    Q(n+1) = DeltaP / (A * log(Q(n)) + B);
end
disp('Iteration for Q0 = 1000:')
disp(Q)

% With values very close to 0 or negative we observe huge jumps and imaginary values
% making it non convergent in the real plane 
Q(1) = 2e-4;    
for n = 1:N
    Q(n+1) = DeltaP / (A * log(Q(n)) + B);
end

disp('Iteration for Q0 = 2e-4:')
disp(Q)


%% Question f
% Report contains proof
Fprime = @(Q) -DeltaP*A ./ (Q .* (A*log(Q) + B).^2);
Fp_star = abs(Fprime(x));
fprintf('|F''(Q*)| = %.4f\n', Fp_star);
% Since the value obtained is less than 1 we do see convergence 
