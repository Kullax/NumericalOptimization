function [x] = projection(x, l, u)
    x = min(u, max(x,l));
end