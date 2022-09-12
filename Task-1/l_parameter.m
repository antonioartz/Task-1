function l = l_parameter(L,L1,M,Me,g)

q1 = @(x) (0.85 - (0.15*cos(2*pi*x./L1)));
q2 = @(x) (L^2 - 4*(x.^2))/(L^2 - L1^2);

q_1 = integral(q1, 0, L1/2);
q_2 = integral(q2, L1/2, L/2);
q_t = q_1 + q_2;

k_1 = (27/5)*(M/L)*L1;
k_2 = (9/20)*(M/L)*(L - L1);
k_t = k_1 + k_2;

l = g*(k_t + 2*Me)/(2*q_t);

end