ratio = input('radio=');
grayImage = rgb2gray(imread('lena.jpg'));
doubleData = im2double(grayImage);
% 将图像进行FFT变换得到FFT系数矩阵
dctSeries = fft2(doubleData);
figure(1), imshow(log(abs(dctSeries)), []), title('原FFT系数矩阵');

[rows, cols] = size(grayImage);
% 以FFT系数矩阵中心为圆心，分别以不同的半径将圆内系数置为零
for i = 1:rows
    for j = 1:cols
        if sqrt((i-rows/2)^2+(j-cols/2)^2)/sqrt((rows/2)^2+(cols/2)^2) < 1-ratio
            dctSeries(i,j) = 0;
        end
    end
end
figure(2), imshow(log(abs(dctSeries)),[]), title('量化后FFT系数矩阵');

% 将量化后的FFT系数矩阵进行IFFT变换还原图像
y = ifft2(dctSeries);
figure(4), imshow(y), title('还原图像');

fprintf('压缩比例为%f时, MSE=\n', ratio)
se = abs((y - doubleData).^2);
sum(se(:)) / (rows * cols)