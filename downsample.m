function endimg = downsample(Usedimg)

d0= [-0.013 -0.017 0.074 0.804 0.185 -0.045 0.011];
d1= [-0.005 0.032 -0.129 0.753 0.421 -0.09 0.017];
d2= [0.017 -0.09 0.421 0.753 -0.129 0.032 -0.005];
d3= [0.011 -0.045 0.185 0.804 0.074 -0.017 -0.013];

% image=double(imread('ourcan.png','png'))./255;
% image1=image(:,:,1);
% [h w d] = size(image1);
% h1 = h - rem(h,4);
% w1 = w - rem(w,4);
% Usedimg = image1(1:h1,1:w1);
% newh1=floor(0.8*h1);
% neww1=floor(0.8*w1);

[h1 w1] = size(Usedimg);
newh1=floor(0.8*h1);
neww1=floor(0.8*w1);

convimg0=conv2(Usedimg,d0,'same');
convimg1=conv2(Usedimg,d1,'same');
convimg2=conv2(Usedimg,d2,'same');
convimg3=conv2(Usedimg,d3,'same');

tmpup=zeros(h1,neww1);
tmpup(:,1:4:end)=convimg0(:,1:5:end);
tmpup(:,2:4:end)=convimg1(:,2:5:end);
tmpup(:,3:4:end)=convimg2(:,3:5:end);
tmpup(:,4:4:end)=convimg3(:,4:5:end);

endconvimg0=conv2(tmpup,d0','same');
endconvimg1=conv2(tmpup,d1','same');
endconvimg2=conv2(tmpup,d2','same');
endconvimg3=conv2(tmpup,d3','same');

endimg=zeros(newh1,neww1);
endimg(1:4:end,:)=endconvimg0(1:5:end,:);
endimg(2:4:end,:)=endconvimg1(2:5:end,:);
endimg(3:4:end,:)=endconvimg2(3:5:end,:);
endimg(4:4:end,:)=endconvimg3(4:5:end,:);

%figure(1);imshow(Usedimg);
%figure(2);imshow(tmpup);%imshow(endimg/max(endimg(:)));
