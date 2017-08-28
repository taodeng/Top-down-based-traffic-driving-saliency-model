%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Vanishing Poiont Detection for Road Detection
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%% Please refer to the following two papers if you use our code for any purposes, thank you.

%%%% Hui Kong, Jean-Yves Audibert and Jean Ponce, 
%%%% "Vanishing Point Detection for Road Detection",  IEEE Int. Conf. on
%%%% Computer Vision and Pattern Recognition (CVPR'09), 2009.

%%%% Hui Kong, Jean-Yves Audibert and Jean Ponce,  
%%%% "General road detection from a single image",  
%%%% IEEE Transactions on Image Processing, Vol.19, No.8, pp.2211-2220, 2010 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %  
% clear all;
% close all;
% 
% inputPath = 'C:\Users\hkong\myWork2011\TMI_blob\TestImages\Road Images\'; %%% input image path
% outputPath_final = 'C:\Users\hkong\myWork2011\TMI_blob\TestImages\gaborVP1\'; %%% result path
% 
% vpCoord = [];
% 
% for i= 1:272   
%     i
%     ii = i
%     
%     if i<10
%         imgName = [inputPath, 'image','000', int2str(i), '.jpg'];
%     elseif i<100
%         imgName = [inputPath, 'image','00', int2str(i), '.jpg'];
%     elseif i<1000
%         imgName = [inputPath, 'image','0', int2str(i), '.jpg'];
%     else
%         imgName = [inputPath, 'image',int2str(i), '.jpg'];
%     end
%     
% 
% if exist(imgName,'file')>0
%     colorImg = imread(imgName);
%     if size(colorImg,3)>1
%        img = rgb2gray(colorImg);
%     else
%         img = colorImg;
%     end
% 
% %     [imH,imW] = size(img);
% %     if max(imH,imW)>1200
% %         img = imresize(img,0.3);
% %         colorImg = imresize(colorImg,0.3);
% %     elseif max(imH,imW)>800
% %         img = imresize(img,0.5);
% %         colorImg = imresize(colorImg,0.5);
% %     elseif max(imH,imW)<320
% %         img = imresize(img,2);
% %         colorImg = imresize(colorImg,2);
% %     end
%     
%     img = imresize(img, [180, 240]); 
%     colorImg = imresize(colorImg, [180, 240]); %%[180, 240]
% %     [vpY, vpX, vpY1, vpX1, vpX_dual, vpY_dual] = vpeDOIm_gLoG(img, colorImg, 12, outputPath_final, i); 
% %     vpCoord = [vpCoord; vpY, vpX, vpY1, vpX1, vpX_dual, vpY_dual];
%     [vpY, vpX] = vpeDOIm_gabor(img, colorImg, 36, outputPath_final, ii); 
%     
% 
% end
% end
% save('C:\Users\hkong\myWork2011\TMI_blob\TestImages\gaborVP1.mat', 'vpCoord', '-mat');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


clear all;
close all;

tic
% inputPath = 'C:\Users\hkong\myWork2011\TMI_blob\TestImages\Road Images\'; %%% input image path
outputPath_final = 'C:\Users\Administrator\Desktop\vp_code_gLoG\resultgLoG\'; %%% result path

vpCoord = [];

for i=1:1;
   i
I=double(imread(['E:\traffic_img\',num2str(i),'.bmp']))./255;
colorImg = imresize(I, [180, 240]); %%[180, 240]
I1=rgb2gray(I);
img = imresize(I1, [180, 240]);
% colorImg = imresize(colorImg, [180, 240]); %%[180, 240]
    
    %%%%% vanishing point detection based on gLoG filter
%     [vpY, vpX, vpY1, vpX1, vpX_dual, vpY_dual, vpX_all, vpY_all] = vpeDOIm_gLoG(img, colorImg, 12, outputPath_final, i); 
%     vpCoord = [vpCoord; vpY, vpX, vpY1, vpX1, vpY_dual, vpX_dual, vpY_all, vpX_all];
    
    %%%%% vanishing point detection based on Gabor filter
    % [vpY, vpX] = vpeDOIm_gabor(img, colorImg, 36, outputPath_final, i); 
    [vpY, vpX] = vpeDOIm_gLoG(img,colorImg, 12, outputPath_final, i)
    vpCoord = [vpCoord; vpY, vpX];
    
% end
end

% save('C:\Users\Administrator\Desktop\vanishingpointdetection\vp2_new.mat', 'vpCoord', '-mat');
toc


