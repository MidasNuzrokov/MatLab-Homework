%Пропишем функцию Якоби для численного метода нахождения производной
function [J] = jacobi(fun, r, p_n, P_0)
N = length(r(1, :))
J = zeros(N, p_n)
h = 1e-6

for i = [1 : 1 : N]
    for j = [1 : 1 : p_n]
        d = zeros(1, p_n)
            d(j) = h * abs(P_0(j))
            J(i, j) = (fun(r(:, i),P_0 + d) - fun(r(:, i),P_0 - d))/(2*h)
    end   
end

end

%Пусть P_0 имеет сведения о начальных значениях параметров

function [P, sgP] = NonLinApproximator (y,r,fun, P_0)

N = size(y, 2);
p_n = length(P_0)

for q = [1 : 1 : 1000]

F = zeros(1, N);
for i = [1 1 : 1 : N]
    F(i) = fun(r(:, i), P_0)
end
 
J = jacobi(fun, r, p_n, P_0)

%По анологии с линейным случаем
Y = J'*(y' - F')
G = J'*J
P = P_0' + G\Y

if isnan(P)
    break
end

if q > 1
    if abs(P_0 - P_back) < 1e-10
        break
    end
end

P_back = P
P_0 = P'
end

sgP = 'boom'
end


