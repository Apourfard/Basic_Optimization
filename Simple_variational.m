% MTH 8408 - Lab 8 - The Simplest Variational Calculus Problem

function [x_opt, fval] = minimal_length
    % Parameters ---------------------------------------------------------
    N = 100;  h = 1/N;
    a = 1;    b = 3;
    nv = N + 1;

    % Initial guess (straight line) --------------------------------------
    x0 = linspace(a,b,nv).';

    % Bounds -------------------------------------------------------------
    lb = -inf(nv,1);  ub =  inf(nv,1);
    lb([1 end]) = [a; b];   ub([1 end]) = [a; b];

    % Optimisation -------------------------------------------------------
    opts = optimoptions('fmincon','Algorithm','interior-point', ...
                        'SpecifyObjectiveGradient',true,'Display','iter');
    
    tic; % Start timer here, right before optimization
    [x_opt,fval] = fmincon(@objgrad,x0,[],[],[],[],lb,ub,[],opts);
    elapsed = toc; % Stop timer here, right after optimization

    % Plot ---------------------------------------------------------------
    t = linspace(0,1,nv);
    figure
    plot(t,x_opt,'LineWidth',2), grid on
    xlabel('t'), ylabel('x(t)')
    legend('x(t)','Location','southwest')
    yl = ylim;
    text(t(1)+0.02*range(t), yl(2)-0.05*range(yl), ...
        sprintf('Optimal Point = %.6f',fval), 'FontWeight','bold')

    text(t(1)+0.02*range(t), yl(2)-0.12*range(yl), ...   
     sprintf('Elapsed = %.3f s', elapsed), ...
     'FontAngle','italic');     

    % --------------------------------------------------------------------
    if nargout==0, clear x_opt fval, end

    % Objective + gradient ----------------------------------------------
    function [f,g] = objgrad(x)
        n  = numel(x)-1;   h = 1/n;
        dx = (x(2:end)-x(1:end-1))/h;
        r  = sqrt(1+dx.^2);
        f  = h*sum(r);

        t  = (dx./r)/h;
        g  = zeros(size(x));
        g(1) = -t(1);  g(end) = t(end);
        g(2:end-1) = t(1:end-1)-t(2:end);
    end
end
