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

% 高斯滤波实现算法
% 指定模板尺寸
boxSize = 5;
box = [boxSize boxSize];
% 指定噪声标准差
sigma = 1;
siz = (box-1)/2;
% 生成权重矩阵
[x1,x2] = meshgrid(-siz(2):siz(2),-siz(1):siz(1));
h = exp(-(x1.^2 + x2.^2)/(2*sigma^2));
h(h<eps*max(h(:))) = 0;
sumh = sum(h(:));
if sumh ~= 0,
    h = h / sumh;
end;
template = zeros(boxSize);
for i = 1:rows-boxSize+1
    for j = 1:cols-boxSize+1
        % 取模板内像素
        template = imageWithNoise(i:i+(boxSize-1),j:j+(boxSize-1));
        % 将模板内像素与权重矩阵对应相乘
        ws = sum(sum(template.*h));
        y(i+(boxSize-1)/2,j+(boxSize-1)/2) = ws;
    end
end

figure(3), imshow(y), title('滤波后图');

% 计算滤波后MSE
se2 = (y - originImage).^2;
MSE2 = sum(se2(:)) / (rows * cols);
fprintf('滤波后MSE=%f\n', MSE2);