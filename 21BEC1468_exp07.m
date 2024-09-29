clc;
close all;
clear all;
d = 10;  % Cutoff frequency
d2 = d^2;  % Square of cutoff frequency
I=imread("CRFSeve.jpg");
f1 = double(rgb2gray(I));
b(:,:,3)=I(:,:,3)+200;
b(:,:,2)=I(:,:,2)+200;
b(:,:,1)=I(:,:,1)+200;
f=double(rgb2gray(b));
l = log(1 + f);  % Logrithmic transformation
z = fft2(l);
[m, n] = size(f);
b = zeros(m, n);
h = zeros(m, n);
for i = 1:m
    for j = 1:n
        b(i, j) = sqrt((i - m / 2)^2 + (j - n / 2)^2);%eucledian distance
        h(i, j) = exp(-b(i, j)^2 / (2 * d2));  % Gaussian filter
    end
end
L = 0.5;  % Gamma low value
H = 1.5;  % Gamma high value
filter = L + (H - L) * h;
s = z .* filter;
g = abs(ifft2(s));%inverse fourier transformation
e = exp(g) - 1;%inverse the logarithmic transformation
subplot(1,3,1)
imshow(f1, [])
title("original image")
subplot(1, 3, 2);
imshow(f, []);
title('brightened image(+200 to each pixel)');
subplot(1, 3, 3);
imshow(e, []);
title('Homomorphic Filtered Image');
