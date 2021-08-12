clc;clear all;close all;
Files = dir(strcat('.\data\','*.png')); 
LengthFiles =length(Files); 

for ii = 1:LengthFiles
    Files(ii).name
    image=double(imread(strcat('.\data\',Files(ii).name)));
    image1=image(:,:,1);
    image2=image(:,:,2);
    image3=image(:,:,3);

    tmpup1=image1;
    tmpup2=image2;
    tmpup3=image3;
    for i=1:3
    tic
    tmpup1=robustupspixel1(tmpup1);
    tmpup2=robustupspixel1(tmpup2);
    tmpup3=robustupspixel1(tmpup3);
    toc
    end
    endimg(:,:,1)=tmpup1;
    endimg(:,:,2)=tmpup2;
    endimg(:,:,3)=tmpup3;
    imwrite(uint8(endimg),strcat('.\results\',Files(ii).name(1:end-4),'_LSE.png'));
    clear endimg;
end

