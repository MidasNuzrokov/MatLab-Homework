clc
step = 0.05
[x, y, z] = meshgrid(-6 : step : 6, -6 : step : 6, -6 : step : 6)
F = ((-(x.^2).*(z.^3)-(9/80).*(y.^2).*(z.^3)) + ((x.^2) +(9/4).*(y.^2) + (z.^2)-1).^3)
p = patch(isosurface(x, y, z, F, 0))
set(p, 'facecolor', 'w', 'EdgeColor', 'r')
daspect ([1 1 1]), view(3), axis tight, axis equal, grid on
title('Red Heart')