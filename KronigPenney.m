function [matrix] = KronigPenney(k,m,a,b,U0,Emax)


h=1.054571817*10.^(-27)/((1.602176634*10.^(-12)*1*10.^(-14)).^0.5)
f=@F

length_m = 0
M =[]

for i = [1 : 1 : length(k)]
    k_i = k(i)
    x =[]
    for j = [U0+0.0001 : 0.1  : Emax]
        x1 = fzero(f, j)
        y = true
        for m = [1 : 1 : length(x)]
            if abs(x(m) - x1) < 0.0001
                y = false
            end
        end
        if (y) && (x1 < Emax)
            x = [x ; x1]
        end
    end
    x = sort(x)
    if i == 1
        M = x
        length_m = length(x)
    else 
        if length_m < length(x)
            M = [M; NaN.*zeros(length(x)-length_m, i-1)] 
            length_m = length(x)
        else
            x = [x; NaN.*zeros(length_m - length(x), 1)]
        end
        
        M = [M, x]
    end
end

matrix = M
end

function cos1 = F(E)
mu = (2*m.*E/h.^2).^0.5
lambda = (2*m.*(E-U0)/h.^2).^0.5
cos1 = cos(mu.*a).*cos(lambda.*b)-(mu.^2+lambda.^2)./(2*mu.*lambda).*sin(mu.*a).*sin(lambda.*b)-cos(k.*(a+b))
end