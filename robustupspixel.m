
function rgb = robustupspixel(image)

[h w d] = size(image);

remh1=20-rem(h,20);
remw1=20-rem(w,20);
h1 = h + remh1;
w1 = w + remw1;
Usedimg = image([1:end,end*ones(1,remh1)],[1:end,end*ones(1,remw1)]);

I0=Usedimg;
L1=upsample(I0);
[newh1 neww1]=size(L1);
L0=upsample(downsample(I0));
H0=I0-L0;

largenewh1=floor(1.25*h);
largeneww1=floor(1.25*w);


abh0=abs(H0);
threh0=zeros(size(H0));
threh0(abh0<0.02*max(abh0(:)))=1;%less than 0.05
sum(threh0(:))/(h1*w1);

hfs_y1=10;
largethr0=threh0([ones(1,hfs_y1),1:end,end*ones(1,hfs_y1)],[ones(1,hfs_y1),1:end,end*ones(1,hfs_y1)]);
largeL0=L0([ones(1,hfs_y1),1:end,end*ones(1,hfs_y1)],[ones(1,hfs_y1),1:end,end*ones(1,hfs_y1)]);
largeL1=L1([ones(1,hfs_y1),1:end,end*ones(1,hfs_y1)],[ones(1,hfs_y1),1:end,end*ones(1,hfs_y1)]);
largeH0=H0([ones(1,hfs_y1),1:end,end*ones(1,hfs_y1)],[ones(1,hfs_y1),1:end,end*ones(1,hfs_y1)]);

sumh0=zeros(size(largeL1));
counth0=zeros(size(largeL1));

for iteri=1:1:newh1
    for iterj=1:1:neww1
        centerx=iteri;
        centery=iterj;
        p_L1=largeL1(hfs_y1+centerx-2:hfs_y1+centerx+2,hfs_y1+centery-2:hfs_y1+centery+2);
        newx=floor(centerx*4/5);
        newy=floor(centery*4/5);
        
        booleanh0=largethr0(hfs_y1+newx,hfs_y1+newy);
        if booleanh0>5%0.5
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
rgbtmp=endupimg(hfs_y1+1:end-hfs_y1,hfs_y1+1:end-hfs_y1);

rgb=rgbtmp(1:largenewh1,1:largeneww1);
%toc;




