% Page 618
x = 0:pi/100:2*pi;
x_k = sin(x);
figure('Name', 'Sin(k)')
plot(x_k)

x_k = 1 + (1/2).^x;
figure('Name', 'x_k = 1 + (1/2)^x')
plot(x_k)


x_k = 1+ (1/2).^(2.^x);
figure('Name', '1+ (1/2)^{2^k}')
plot(x_k)

x_k = 1+ (k).^(-x);
figure('Name', '1+ (k)^{-k}')
plot(x_k)