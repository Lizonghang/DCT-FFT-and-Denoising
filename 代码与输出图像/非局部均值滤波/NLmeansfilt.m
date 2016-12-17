% 原图像
originImage = im2double(rgb2gray(imread('lena.jpg')));
% 带椒盐噪声的图像
imageWithNoise = im2double(imread('lena_noise.jpg'));
% 带高斯噪声的图像
% imageWithNoise = im2double(imread('lena_gaussian_noise.jpg'));
[rows, cols] = size(originImage);
figure(1), imshow(originImage), title('原图像');
figure(2), imshow(imageWithNoise), title('带噪图像');
y = imageWithNoise;

% NL-Means滤波
y = NLmeans(imageWithNoise,2,7,0.1);

figure(3), imshow(y), title('滤波后图');

% 计算滤波后MSE
se2 = (y - originImage).^2;
MSE2 = sum(se2(:)) / (rows * cols);
fprintf('滤波后MSE=%f\n', MSE2);