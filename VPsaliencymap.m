%  Vanishing point saliency map. We used Hui Kong's model to get the
%  vanishing point of each traffic image. You can refer to their work and
%  code.
%  H. Kong, J.-Y. Audibert, and J. Ponce, ¡°Vanishing point detection for
%  road detection,¡± in Proc. IEEE Conf. Comp. Vis. Pattern Rec., 2009,pp. 96¨C103.
%
%  This algorithm is described in the following paper:
%  "Where Does the Driver Look? Top-Down Based Saliency Detection in a Traffic Driving Environment. ",
%   by Tao Deng, Kaifu Yang, Yongjie Li, Hongmei Yan.
%   IEEE Transactions on Intelligent Transportation Systems (TITS), 17 (7): 2051-2062, 2016.
%  
%  Coding by  Tao Deng, 2015
% 
%  License: Code may be copied & used for any purposes as long as the use is acknowledged and cited.
%
clear;clc;
tic

sigma=60; % It can be adjusted.
% fy=800;

outputPath=strcat(['E:\model_data\OurModeldata\',num2str(sigma),'\']);
if ~exist(outputPath, 'dir')
    mkdir(outputPath);
end

load('F:\vanishingpointdetection\vpData.mat');

tmp=zeros(180,240);
% tm=zeros(768,1024);

for i=1:100
    tmp=zeros(180,240);
    i

    I=double(imread(['E:\traffic_map\',num2str(i),'.bmp']))./255;

    [lenx,leny,vv]=size(I);
    tm=zeros(lenx,leny);
    vpx=vpData(i,1);
    vpy=vpData(i,2);
    tmp(vpx,vpy)=1;
    I1=imresize(I,[180 240]);
    I1(vpx,vpy,1)=1;
    tmp1=imresize(tmp,[lenx leny]);
    [x y]=find(tmp1==max(max(tmp1)));
    
    I3=rgb2gray(I);
    tm(x,y)=1;
    
%     g=fspecial('gaussian',[fy fy],sigma);%60  800
    g=gaus(sigma);
    tm = conv2(tm, g,'same');
    
    tt=tm./max(tm(:));
    yy=tt;
    
%     tt(yy<0.1)=0.2;
%     tt(yy>=0.1)= tt(yy>=0.1)+0.1;
    
rt=zeros(size(I));

    rt(:,:,1)=double(tt.*I(:,:,1));
    rt(:,:,2)=double(tt.*I(:,:,2));
    rt(:,:,3)=double(tt.*I(:,:,3));
    
    rt=rt./max(rt(:));

%     I2=imresize(I1,[lenx leny],'bilinear');
%     figure,imshow(I2,[]);
%     figure,imshow(I1,[]);
%     figure,imshow(I,[]);  %%
%     figure,imshow(tmp,[]);
%     figure,imshow(tmp1,[]);

% imwrite(I3,[outputPath, num2str(i),'.jpg'], 'jpg');
% imwrite(tt,[outputPath,'tt' ,num2str(i),'.bmp'], 'bmp');
imwrite(rt,[outputPath,'rt', num2str(i),'.bmp'], 'bmp');
save([outputPath,num2str(i),'.mat'],'tt');
end
toc