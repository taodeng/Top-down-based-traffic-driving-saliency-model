function g = gaus(sgm)
% 2-D gauss function

nr = 15*sgm;
nc = 15*sgm;
[x,y] = meshgrid(linspace(-nc/2, nc/2, nc), linspace(nr/2, -nr/2, nr));
g = exp(-(x.^2+y.^2)/(2*(sgm)^2));
g = g/sum(g(:));


