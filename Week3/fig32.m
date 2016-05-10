clear
clf;
hold on;
title('Figure 3.2');
xlabel('X');
ylabel('Y');
% Function with local minimum in f(3) = -1, as requested.
fh = @(z) (z^2-6*z + 8)

fplot(fh,[-8,8])
low_x = 999;
high_x = 0;
gradient = @(z) 2*(z-3);
% THIS IS THE FUN VALUE!
steplength = 0.9 % must be stickly less than 1.

% Initial guess, if we guess 3 we dont even do the loop.
guess = 0;
% Gradient, used to determine direction.
g = gradient(guess)
% Number of iterations, stops after 200.
it = 0;
while g ~= 0 && it < 200
    % The next guess is simply result of old guess affected by the
    % steplength and gradient.
    % Note - Steplength is fixed, better version of algorithm should adjust
    % steplength.
    g = guess - steplength * gradient(guess);
    % Draw a line from current guess to next iteration
    line([guess, g],[fh(guess), fh(g)],'Color','b','LineWidth',2);
    % Prepare next iteration.
    guess = g;
    it = it + 1
end

% HARDCODED VERSION; IGNORE! Other one is much more fun.
%first = @(v) v(1);
%for i=0:steplength:3
%    N = 3 - i
%    q = 3 + i
%    y = fh(N);
%    if first(factor(l)) - 2
%        line([N-steplength, q],[fh(N-steplength), fh(q)],'Color','b','LineWidth',2);
%    else
%        line([N, q+steplength],[fh(N), fh(q+steplength)],'Color','k','LineWidth',2);
%    end
%    l = l +1 ;
%end
