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

% 自适应中值滤波器实现
wmin = 3;   % 最小窗口尺寸
wmax = 9;   % 最大窗口尺寸
% 扩充图像，处理图像边界点
expandImage = [zeros((wmax-1)/2,cols+(wmax-1)); zeros(rows,(wmax-1)/2),imageWithNoise,zeros(rows,(wmax-1)/2);zeros((wmax-1)/2,cols+(wmax-1))];
% 自适应滤波
for i = 1:rows
    for j = 1:cols
        for n = wmin:2:wmax
            % 提取未扩展图像中某点(i,j)的领域,(x,y)对应扩展后图的(i+(wmax-1)/2,j+(wmax-1)/2)
            S = expandImage(i+(wmax-1)/2-(n-1)/2:i+(wmax-1)/2+(n-1)/2,j+(wmax-1)/2-(n-1)/2:j+(wmax-1)/2+(n-1)/2);
            Pmax = max(S(:));   % 窗口内像素最大值
            Pmin = min(S(:));   % 窗口内像素最小值
            Pmed = median(S(:));% 窗口内像素中间值
            if Pmed>Pmin && Pmed < Pmax
                % 判断中值是否为噪点,是则增大窗口尺寸再判断
                if y(i,j)<=Pmin || y(i,j)>=Pmax
                    % 判断原图像的该像素点是否为噪点,若不是噪点不作处理,若是则以中值替换
                    y(i,j) = Pmed;
                end
                break
            end
        end
        y(i,j)=Pmed; % 模板最大时中值仍不满足，使用中值替换
    end
end

figure(3), imshow(y), title('滤波后图');

% 计算滤波后MSE
se2 = (y - originImage).^2;
MSE2 = sum(se2(:)) / (rows * cols);
fprintf('滤波后MSE=%f\n', MSE2);