% bottom-up and top-down combine model 
% The bottom-up and top-down saliency map should be computed in advance.

%  This algorithm is described in the following paper:
%  "Where Does the Driver Look? Top-Down Based Saliency Detection in a Traffic Driving Environment. ", by Tao Deng, Kaifu Yang, Yongjie Li, Hongmei Yan.
%   IEEE Transactions on Intelligent Transportation Systems (TITS), 17 (7): 2051-2062, 2016.
%  
%  Coding by  Tao Deng, 2015
% 
%  License: Code may be copied & used for any purposes as long as the use is acknowledged and cited.
%
clear;clc;
weight=0.8;

savePath = ['E:\model_data\gbvs_plus_OurModel\' num2str(weight)  '\'];
if ~exist(savePath, 'dir')
    mkdir(savePath);
end

for i=1:100
    i
    s1=load(strcat('E:\model_data\gbvsdata\',num2str(i),'.mat'));  % bottom-up saliency map: GBVS, AIM, SR, SUN, ITTI
    s2=load(strcat('E:\model_data\OurModeldata\',num2str(i),'.mat')); % top-down saliency map: Vanishing point map
    s_itti=s1.Iout;
    s_m=s2.tt;
    [mx my]=size(s_m);
    s_itti=imresize(s_itti,[mx my],'bilinear');
    
    k = mygausskernel( max(size(s_itti)) * 0.02 , 2 );
    s_itti = myconv2(myconv2( s_itti , k ),k');
    s_itti=(s_itti-min(s_itti(:)))./(max(s_itti(:))-min(s_itti(:)));
    
    tt=(s_itti*(1-weight))+(s_m*weight);  % S = wSv + (1-w)Sb

    tt=(tt-min(tt(:)))./(max(tt(:))-min(tt(:)));  %normalization   
    
    save([savePath,num2str(i),'.mat'],'tt');
           
end