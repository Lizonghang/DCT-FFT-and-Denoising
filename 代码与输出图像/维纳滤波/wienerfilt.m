% 原图像
originImage = im2double(rgb2gray(imread('lena.jpg')));
% 带椒盐噪声的图像
% imageWithNoise = im2double(imread('lena_noise.jpg'));
% 带高斯噪声的图像
imageWithNoise = im2double(imread('lena_gaussian_noise.jpg'));
[rows, cols] = size(originImage);
figure(1), imshow(originImage), title('原图像');
figure(2), imshow(imageWithNoise), title('带噪图像');
y = imageWithNoise;

% 维纳滤波实现
% 指定模板尺寸
boxSize = [7 7];
g = imageWithNoise;
% 估计均值
localMean = filter2(ones(boxSize), g) / prod(boxSize);
% 估计方差
localVar = filter2(ones(boxSize), g.^2) / prod(boxSize) - localMean.^2;
% 估计噪声
noise = mean2(localVar);
% 维纳法估计
y = localMean + (max(0, localVar - noise) ./ max(localVar, noise)) .* (g - localMean);

figure(3), imshow(y), title('滤波后图');

% 计算滤波后MSE
se2 = (y - originImage).^2;
MSE2 = sum(se2(:)) / (rows * cols);
fprintf('滤波后MSE=%f\n', MSE2);