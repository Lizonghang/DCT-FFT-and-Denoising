% 图像读取与灰度化
gray = rgb2gray(imread('lena.jpg'));

% 将图像数据uint8类型转换为double类型并进行归一化
doubleGray = im2double(gray);

% 定义DCT变换矩阵
t = dctmtx(8);

% 将原图的每个8x8块进行DCT变换
y = blkproc(doubleGray, [8 8], 'P1*x*P2', t, t');

figure(2), imshow(log(abs(y)), []), title('DCT系数');

 
% 定义量化矩阵
mask1 = [1 0 0 0 0 0 0 0;
         0 0 0 0 0 0 0 0;
         0 0 0 0 0 0 0 0;
         0 0 0 0 0 0 0 0;
         0 0 0 0 0 0 0 0;
         0 0 0 0 0 0 0 0;
         0 0 0 0 0 0 0 0;
         0 0 0 0 0 0 0 0];
mask2 = [1 1 0 0 0 0 0 0;
         1 0 0 0 0 0 0 0;
         0 0 0 0 0 0 0 0;
         0 0 0 0 0 0 0 0;
         0 0 0 0 0 0 0 0;
         0 0 0 0 0 0 0 0;
         0 0 0 0 0 0 0 0;
         0 0 0 0 0 0 0 0];
mask3 = [1 1 1 0 0 0 0 0;
         1 1 0 0 0 0 0 0;
         1 0 0 0 0 0 0 0;
         0 0 0 0 0 0 0 0;
         0 0 0 0 0 0 0 0;
         0 0 0 0 0 0 0 0;
         0 0 0 0 0 0 0 0;
         0 0 0 0 0 0 0 0];
mask4 = [1 1 1 1 0 0 0 0;
         1 1 1 0 0 0 0 0;
         1 1 0 0 0 0 0 0;
         1 0 0 0 0 0 0 0;
         0 0 0 0 0 0 0 0;
         0 0 0 0 0 0 0 0;
         0 0 0 0 0 0 0 0;
         0 0 0 0 0 0 0 0];
mask5 = [1 1 1 1 1 0 0 0;
         1 1 1 1 0 0 0 0;
         1 1 1 0 0 0 0 0;
         1 1 0 0 0 0 0 0;
         1 0 0 0 0 0 0 0;
         0 0 0 0 0 0 0 0;
         0 0 0 0 0 0 0 0;
         0 0 0 0 0 0 0 0];
mask6 = [1 1 1 1 1 1 0 0;
         1 1 1 1 1 0 0 0;
         1 1 1 1 0 0 0 0;
         1 1 1 0 0 0 0 0;
         1 1 0 0 0 0 0 0;
         1 0 0 0 0 0 0 0;
         0 0 0 0 0 0 0 0;
         0 0 0 0 0 0 0 0];
mask7 = [1 1 1 1 1 1 1 0;
         1 1 1 1 1 1 0 0;
         1 1 1 1 1 0 0 0;
         1 1 1 1 0 0 0 0;
         1 1 1 0 0 0 0 0;
         1 1 0 0 0 0 0 0;
         1 0 0 0 0 0 0 0;
         0 0 0 0 0 0 0 0];
mask8 = [1 1 1 1 1 1 1 1;
         1 1 1 1 1 1 1 0;
         1 1 1 1 1 1 0 0;
         1 1 1 1 1 0 0 0;
         1 1 1 1 0 0 0 0;
         1 1 1 0 0 0 0 0;
         1 1 0 0 0 0 0 0;
         1 0 0 0 0 0 0 0];
mask9 = [0 0 1 1 1 1 1 1;
         0 1 1 1 1 1 1 1;
         1 1 1 1 1 1 1 1;
         1 1 1 1 1 1 1 1;
         1 1 1 1 1 1 1 1;
         1 1 1 1 1 1 1 1;
         1 1 1 1 1 1 1 1;
         1 1 1 1 1 1 1 1];
mask10= [0 0 0 0 1 1 1 1;
         0 0 0 1 1 1 1 1;
         0 0 1 1 1 1 1 1;
         0 1 1 1 1 1 1 1;
         1 1 1 1 1 1 1 1;
         1 1 1 1 1 1 1 1;
         1 1 1 1 1 1 1 1;
         1 1 1 1 1 1 1 1];
mask11= [0 0 0 0 0 0 0 0;
         0 0 0 0 0 0 0 1;
         0 0 0 0 0 0 1 1;
         0 0 0 0 0 1 1 1;
         0 0 0 0 1 1 1 1;
         0 0 0 1 1 1 1 1;
         0 0 1 1 1 1 1 1;
         0 1 1 1 1 1 1 1];
maskall=[1 1 1 1 1 1 1 1;
         1 1 1 1 1 1 1 1;
         1 1 1 1 1 1 1 1;
         1 1 1 1 1 1 1 1;
         1 1 1 1 1 1 1 1;
         1 1 1 1 1 1 1 1;
         1 1 1 1 1 1 1 1;
         1 1 1 1 1 1 1 1];
 
% 对DCT系数矩阵进行量化
my1 = blkproc(y, [8 8], 'P1.*x', mask1);
my2 = blkproc(y, [8 8], 'P1.*x', mask2);
my3 = blkproc(y, [8 8], 'P1.*x', mask3);
my4 = blkproc(y, [8 8], 'P1.*x', mask4);
my5 = blkproc(y, [8 8], 'P1.*x', mask5);
my6 = blkproc(y, [8 8], 'P1.*x', mask6);
my7 = blkproc(y, [8 8], 'P1.*x', mask7);
my8 = blkproc(y, [8 8], 'P1.*x', mask8);
my9 = blkproc(y, [8 8], 'P1.*x', mask9);
my10= blkproc(y, [8 8], 'P1.*x', mask10);
my11= blkproc(y, [8 8], 'P1.*x', mask11);
myall=blkproc(y, [8 8], 'P1.*x', maskall);

% 对每个8x8块进行IDCT变换，恢复图像
y1 = blkproc(my1, [8 8], 'P1*x*P2', t', t);
y2 = blkproc(my2, [8 8], 'P1*x*P2', t', t);
y3 = blkproc(my3, [8 8], 'P1*x*P2', t', t);
y4 = blkproc(my4, [8 8], 'P1*x*P2', t', t);
y5 = blkproc(my5, [8 8], 'P1*x*P2', t', t);
y6 = blkproc(my6, [8 8], 'P1*x*P2', t', t);
y7 = blkproc(my7, [8 8], 'P1*x*P2', t', t);
y8 = blkproc(my8, [8 8], 'P1*x*P2', t', t);
y9 = blkproc(my9, [8 8], 'P1*x*P2', t', t);
y10= blkproc(my10,[8 8], 'P1*x*P2', t', t);
y11= blkproc(my11,[8 8], 'P1*x*P2', t', t);
yall=blkproc(myall,[8 8],'P1*x*P2', t', t);
 
% 显示被压缩的图像与解压缩的图像
figure(3), imshow(doubleGray), title('原图');
figure(4), imshow(y1), title('量化系数为1的压缩图像');
figure(5), imshow(y2), title('量化系数为2的压缩图像');
figure(6), imshow(y3), title('量化系数为3的压缩图像');
figure(7), imshow(y4), title('量化系数为4的压缩图像');
figure(8), imshow(y5), title('量化系数为5的压缩图像');
figure(9), imshow(y6), title('量化系数为6的压缩图像');
figure(10),imshow(y7), title('量化系数为7的压缩图像');
figure(11),imshow(y8), title('量化系数为8的压缩图像');
figure(12),imshow(y9), title('舍弃低频2位的压缩图像');
figure(13),imshow(y10),title('舍弃低频4位的压缩图像');
figure(14),imshow(y11),title('舍弃低频8位的压缩图像');
figure(15),imshow(yall),title('保留所有');
 
% 输出对应MSE值
shape = size(doubleGray);
disp('量化系数为1的压缩图像MSE: ');
se = (doubleGray-y1).^2;
sum(se(:)) / (shape(1)*shape(2))
disp('量化系数为2的压缩图像MSE: ');
se = (doubleGray-y2).^2;
sum(se(:)) / (shape(1)*shape(2))
disp('量化系数为3的压缩图像MSE: ');
se = (doubleGray-y3).^2;
sum(se(:)) / (shape(1)*shape(2))
disp('量化系数为4的压缩图像MSE: ');
se = (doubleGray-y4).^2;
sum(se(:)) / (shape(1)*shape(2))
disp('量化系数为5的压缩图像MSE: ');
se = (doubleGray-y5).^2;
sum(se(:)) / (shape(1)*shape(2))
disp('量化系数为6的压缩图像MSE: ');
se = (doubleGray-y6).^2;
sum(se(:)) / (shape(1)*shape(2))
disp('量化系数为7的压缩图像MSE: ');
se = (doubleGray-y7).^2;
sum(se(:)) / (shape(1)*shape(2))
disp('量化系数为8的压缩图像MSE: ');
se = (doubleGray-y8).^2;
sum(se(:)) / (shape(1)*shape(2))
disp('舍弃低频2位的压缩图像MSE: ');
se = (doubleGray-y9).^2;
sum(se(:)) / (shape(1)*shape(2))
disp('舍弃低频4位的压缩图像MSE: ');
se = (doubleGray-y10).^2;
sum(se(:)) / (shape(1)*shape(2))
disp('舍弃低频8位的压缩图像MSE: ');
se = (doubleGray-y11).^2;
sum(se(:)) / (shape(1)*shape(2))
disp('保留全部MSE: ');
se = (doubleGray-yall).^2;
sum(se(:)) / (shape(1)*shape(2))