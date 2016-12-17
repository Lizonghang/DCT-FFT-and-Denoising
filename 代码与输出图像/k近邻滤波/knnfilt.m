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

% kNN近邻滤波
% 指定k与模板尺寸
k=3;boxSize=3;
for i = 1:rows-boxSize+1
    for j = 1:cols-boxSize+1
        % 取模板内元素
        template = imageWithNoise(i:i+(boxSize-1),j:j+(boxSize-1));
        % 将模板内元素按照与中心点像素值的差的绝对值按升序排列
        center = template((boxSize+1)/2,(boxSize+1)/2);
        dist = reshape(abs(template-center), 1,boxSize*boxSize);
        [sortDist, sortIndex] = sort(dist);
        % 求除了中心点本身的前k个像素值的均值
        kmean = mean(template(sortIndex(2:k+1)));
        % 用均值替换中心点像素值
        y(i+(boxSize-1)/2,j+(boxSize-1)/2) = kmean;
    end
end

figure(3), imshow(y), title('滤波后图');

% 计算滤波后MSE
se2 = (y - originImage).^2;
MSE2 = sum(se2(:)) / (rows * cols);
fprintf('滤波后MSE=%f\n', MSE2);