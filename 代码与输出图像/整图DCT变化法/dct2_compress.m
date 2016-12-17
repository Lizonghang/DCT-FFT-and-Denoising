ratio = input('radio=');
grayImage = rgb2gray(imread('lena.jpg'));
doubleData = im2double(grayImage);
% 对整幅图像进行DCT变换
dctSeries = dct2(doubleData);
figure(1), imshow(log(abs(dctSeries)), []), title('DCT系数矩阵');
[rows, cols] = size(grayImage);
% 对系数矩阵作不同比例的量化
for i = 1:rows
    for j = 1:cols
        if (i+j>(rows+cols)*ratio)
            dctSeries(i,j) = 0;
        end
    end
end
figure(2), imshow(log(abs(dctSeries)),[]), title('量化后DCT系数矩阵');
% 对DCT系数矩阵作IDCT变换,恢复图像
y = idct2(dctSeries);
figure(3), imshow(y), title('还原图像');

fprintf('压缩比例为%f时, MSE=\n', ratio)
se = (y - doubleData).^2;
sum(se(:)) / (rows * cols)