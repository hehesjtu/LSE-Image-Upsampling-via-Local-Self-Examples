
function rgb = upsampleblack(image)


[h1 w1] = size(image);
Usedimg1 = image(1:h1,1:w1);
I0=Usedimg1;
L1=upsample(I0);
[newh1 neww1]=size(L1);
L0=upsample(downsample(I0));
H0=I0-L0;

hfs_y1=10;
largeL0=L0([ones(1,hfs_y1),1:end,end*ones(1,hfs_y1)],[ones(1,hfs_y1),1:end,end*ones(1,hfs_y1)]);
largeH0=H0([ones(1,hfs_y1),1:end,end*ones(1,hfs_y1)],[ones(1,hfs_y1),1:end,end*ones(1,hfs_y1)]);

endupimg=L1;
numberi=floor(newh1/5);
numberj=floor(neww1/5);
%tic;
for iteri=1:numberi
    for iterj=1:numberj
        centerx=(iteri-1)*5+3;
        centery=(iterj-1)*5+3;
        p_L1=L1(centerx-2:centerx+2,centery-2:centery+2);
        newx=(iteri-1)*4+3;
        newy=(iterj-1)*4+3;
        maxsum=100000;
        retrievex=newx;retrievey=newy;
        for iterin1=-5:4
            for iterin2=-5:4
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
        endupimg(centerx-2:centerx+2,centery-2:centery+2)=endupimg(centerx-2:centerx+2,centery-2:centery+2)+q_p_H0;
    end
end
rgb=endupimg;
%toc;




