function [P,sgP] = LinApproximator(y,r,funcs)
N = size(y, 2)
M  = size(funcs, 1)
%Зададим матрицу приблежающих функций
g = zeros(N, M)
for i = [1 : 1 : N]
    for j = [1 : 1 : M]
        f = cell2mat(funcs(j))
        v = num2cell(r(:, i))
        g(i, j) =  f(v{:})
    end
end

Y = y*g
Y = Y'

G = g'*g

a = G\Y
P = a

%Оценим ошибку
Er_0 = summa_1(y - g*a)/N

TG = trace(G)
Delta_a = sqrt(Er_0/(2*TG))
sgP = Delta_a

end

function[summa] = summa_1(x)
    summa = 0
    for i = [1 : 1 : length(x)]
        summa = summa + x(i)^2
    end
end
