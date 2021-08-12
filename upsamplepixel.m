
function rgb = upsamplepixel(image)

% image=double(imread('input.png','png'))./255;
% image1=image(:,:,1);
% image2=image(:,:,2);
% image3=image(:,:,3);
% [h w d] = size(image);
% h1 = h - rem(h,20);
% w1 = w - rem(w,20);
%newh1=floor(1.25*h1);
%neww1=floor(1.25*w1);
[h1 w1 d] = size(image);
Usedimg1 = image(1:h1,1:w1);

I0=Usedimg1;
L1=upsample(I0);
[newh1 neww1]=size(L1);
L0=upsample(downsample(I0));
H0=I0-L0;

abh0=abs(H0);
threh0=zeros(size(H0));
threh0(abh0<0.02*max(abh0(:)))=1;%less than 0.05
sum(threh0(:))/(h1*w1)

hfs_y1=10;
largethr0=threh0([ones(1,hfs_y1),1:end,end*ones(1,hfs_y1)],[ones(1,hfs_y1),1:end,end*ones(1,hfs_y1)]);
largeL0=L0([ones(1,hfs_y1),1:end,end*ones(1,hfs_y1)],[ones(1,hfs_y1),1:end,end*ones(1,hfs_y1)]);
largeL1=L1([ones(1,hfs_y1),1:end,end*ones(1,hfs_y1)],[ones(1,hfs_y1),1:end,end*ones(1,hfs_y1)]);
largeH0=H0([ones(1,hfs_y1),1:end,end*ones(1,hfs_y1)],[ones(1,hfs_y1),1:end,end*ones(1,hfs_y1)]);

sumh0=zeros(size(largeL1));
counth0=zeros(size(largeL1));
%numberi=floor(newh1/5);
%numberj=floor(neww1/5);
%tic;
for iteri=1:2:newh1
    for iterj=1:2:neww1
        centerx=iteri;
        centery=iterj;
        p_L1=largeL1(hfs_y1+centerx-2:hfs_y1+centerx+2,hfs_y1+centery-2:hfs_y1+centery+2);
        newx=floor(centerx*4/5);
        newy=floor(centery*4/5);
        
        booleanh0=largethr0(hfs_y1+newx,hfs_y1+newy);
        if booleanh0>0.5
            continue;
        end
        maxsum=100000;
        retrievex=newx;
        retrievey=newy;
        for iterin1=-2:3
            for iterin2=-2:3
                p_L0=largeL0(hfs_y1+newx-2+iterin1:hfs_y1+newx+2+iterin1,hfs_y1+newy-2+iterin2:hfs_y1+newy+2+iterin2);
                subtmp=abs(p_L1-p_L0);
                subtmp=sum(subtmp(:));
                if subtmp<maxsum
                    maxsum=subtmp;
                    retrievex=newx+iterin1;
                    retrievey=newy+iterin2;
                end
            end
        end

        q_p_H0=largeH0(hfs_y1+retrievex-2:hfs_y1+retrievex+2,hfs_y1+retrievey-2:hfs_y1+retrievey+2);
        sumh0(hfs_y1+centerx-2:hfs_y1+centerx+2,hfs_y1+centery-2:hfs_y1+centery+2)=sumh0(hfs_y1+centerx-2:hfs_y1+centerx+2,hfs_y1+centery-2:hfs_y1+centery+2)+q_p_H0;
        counth0(hfs_y1+centerx-2:hfs_y1+centerx+2,hfs_y1+centery-2:hfs_y1+centery+2)=counth0(hfs_y1+centerx-2:hfs_y1+centerx+2,hfs_y1+centery-2:hfs_y1+centery+2)+1;
    end
end
counth0(counth0<1)=1;
averageh0=sumh0./counth0;
endupimg=largeL1+averageh0;
rgb=endupimg(hfs_y1+1:end-hfs_y1,hfs_y1+1:end-hfs_y1);

%toc;




