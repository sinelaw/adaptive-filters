function [ y, w ] = ls( U, d )

Psi = U';

w = (Psi'*Psi) \ (Psi' * d.');
y = w' * U;

end

