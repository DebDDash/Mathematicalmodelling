clc; clear; close all;

dt_list=[0.1,0.05,0.01];


for k = 1:length(dt_list)
    dt = dt_list(k);
    t = 0:dt:1;
    N = length(t) - 1;
    exp_T = zeros(size(t));
    imp_T = zeros(size(t));
    CN_T  = zeros(size(t));

    exp_T(1) = 1;
    imp_T(1) = 1;
    CN_T(1)  = 1;

    for n = 1:N
        exp_T(n+1)= exp_T(n)*(1-dt);
        imp_T(n+1)= imp_T(n)/(1+dt);
        CN_T(n+1)= CN_T(n)*(2-dt)/(2+dt);

    end

    
    exact_T = exp(-t);
    
    exp_RMSE = sqrt(mean((exp_T - exact_T).^2));
    imp_RMSE = sqrt(mean((imp_T - exact_T).^2));
    CN_RMSE  = sqrt(mean((CN_T  - exact_T).^2));
    
    fprintf('Δt = %.2f\n', dt);
    fprintf('Explicit RMSE = %.6e\n', exp_RMSE);
    fprintf('Implicit RMSE = %.6e\n', imp_RMSE);
    fprintf('CN RMSE = %.6e\n\n', CN_RMSE);

end
