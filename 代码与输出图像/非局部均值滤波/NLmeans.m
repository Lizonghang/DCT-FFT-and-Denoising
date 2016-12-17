function DenoisedImg=NLmeans(I,ds,Ds,h)
%I:含噪声图像
%ds:邻域窗口半径
%Ds:搜索窗口半径
%h:高斯函数平滑参数
%DenoisedImg：去噪图像
[m,n]=size(I);
DenoisedImg=zeros(m,n);
% 扩展图像边界
PaddedImg = padarray(I,[ds,ds],'symmetric','both');
% 定义d值
kernel=ones(2*ds+1,2*ds+1);
kernel=kernel./((2*ds+1)*(2*ds+1));
% 定义噪声功率
h2=h*h;
for i=1:m
    for j=1:n
        % 原图像对应扩展图像的偏移量
        i1=i+ds;
        j1=j+ds;
        % 在扩展图像中以(i1,j1)为中心的邻域窗口1
        W1=PaddedImg(i1-ds:i1+ds,j1-ds:j1+ds);
        average=0; % 加权和
        sweight=0; % 归一化系数
        % 搜索窗口
        rmin = max(i1-Ds,ds+1); % 搜索窗口上边界最低限制到原图像上边界
        rmax = min(i1+Ds,m+ds); % 搜索窗口下边界最高限制到原图像下边界
        smin = max(j1-Ds,ds+1); % 搜索窗口左边界最低限制到原图像左边界
        smax = min(j1+Ds,n+ds); % 搜索窗口右边界最高限制到原图像右边界
        % r与s为搜索窗口内像素点的坐标,对搜索窗口内的每个像素点求相似度
        for r=rmin:rmax
            for s=smin:smax
                % 不能与自己比较相似度
                if(r==i1&&s==j1) 
                    continue;
                end
                % 以搜索窗口内的像素点为中心的邻域窗口2
                W2=PaddedImg(r-ds:r+ds,s-ds:s+ds);
                % 计算邻域间距离
                Dist2=sum(sum(kernel.*(W1-W2).*(W1-W2)));
                % 计算权值w(x,y)
                w=exp(-Dist2/h2);
                sweight=sweight+w;
                average=average+w*PaddedImg(r,s);
            end
        end
        % 将加权和归一化并替换原像素点
        DenoisedImg(i,j)=average/sweight;
    end
end