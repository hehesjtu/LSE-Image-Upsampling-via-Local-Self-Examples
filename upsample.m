function endimg = upsample(Usedimg)

u0=[-0.028 -0.053 0.061 0.925 0.304 0.007 0.014];
u1=[0 0.038 -0.086 0.862 0.52 -0.128 0.062];
u2=[0.062 -0.128 0.52 0.862 -0.086 0.038 0];
u3=[0.014 0.007 0.304 0.925 0.061 -0.053 -0.028];
% flipu0=fliplr(u0);
% flipu1=fliplr(u1);
% flipu2=fliplr(u2);
% flipu3=fliplr(u3);

% image=double(imread('input.png','png'))./255;
% image1=image(:,:,1);
% [h w d] = size(image1);
% h1 = h - rem(h,4);
% w1 = w - rem(w,4);
% Usedimg = image1(1:h1,1:w1);
% newh1=floor(1.25*h1);
% neww1=floor(1.25*w1);

[h1 w1] = size(Usedimg);
newh1=floor(1.25*h1);
neww1=floor(1.25*w1);

tmpup1=zeros(h1,neww1);
tmpup2=zeros(h1,neww1);
tmpup3=zeros(h1,neww1);
tmpup4=zeros(h1,neww1);

tmpup1(:,1:5:end)=Usedimg(:,1:4:end);
tmpup2(:,2:5:end)=Usedimg(:,2:4:end);
tmpup3(:,4:5:end)=Usedimg(:,3:4:end);
tmpup4(:,5:5:end)=Usedimg(:,4:4:end);

convimg0=conv2(tmpup1,u0,'same');
convimg1=conv2(tmpup2,u1,'same');
convimg2=conv2(tmpup3,u2,'same');
convimg3=conv2(tmpup4,u3,'same');

tmpendimg=(convimg0+convimg1+convimg2+convimg3);

upimg1=zeros(newh1,neww1);
upimg2=zeros(newh1,neww1);
upimg3=zeros(newh1,neww1);
upimg4=zeros(newh1,neww1);

upimg1(1:5:end,:)=tmpendimg(1:4:end,:);
upimg2(2:5:end,:)=tmpendimg(2:4:end,:);
upimg3(4:5:end,:)=tmpendimg(3:4:end,:);
upimg4(5:5:end,:)=tmpendimg(4:4:end,:);

endconvimg0=conv2(upimg1,u0','same');
endconvimg1=conv2(upimg2,u1','same');
endconvimg2=conv2(upimg3,u2','same');
endconvimg3=conv2(upimg4,u3','same');

endimg=(endconvimg0+endconvimg1+endconvimg2+endconvimg3);


% bicubicimg=imresize(Usedimg,[newh1,neww1],'bicubic');
% figure(3);imshow(bicubicimg);
% figure(1);imshow(Usedimg);
% figure(2);imshow(endimg);%imshow(endimg/max(endimg(:)));
% return;

