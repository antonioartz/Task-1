function l = l_parameter(s)

q1 = @(x) (0.85 - (0.15*cos(2*pi*x./s.L1)));
q2 = @(x) (s.L^2 - 4*(x.^2))/(s.L^2 - s.L1^2);

q_1 = integral(q1, 0, s.L1/2);
q_2 = integral(q2, s.L1/2, s.L/2);
q_t = q_1 + q_2;

k_1 = (27/5)*(s.M/s.L)*s.L1;
k_2 = (9/20)*(s.M/s.L)*(s.L - s.L1);
k_t = k_1 + k_2;

l = s.g*(k_t + 2*s.Me)/(2*q_t);

end