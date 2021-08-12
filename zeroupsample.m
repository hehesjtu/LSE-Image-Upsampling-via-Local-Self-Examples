

function rgb = zeroupsample(Usedimg,xratio,yratio)
rgb=Usedimg;
[lines,columns]=size(Usedimg);
newlines=floor(lines*yratio);
newcolumns=floor(columns*xratio);

if xratio>1
    clear('rgb');
    rgb=zeros(lines,newcolumns);
    rgb(:,1:5:end)=Usedimg(:,1:4:end);
    rgb(:,2:5:end)=Usedimg(:,2:4:end);
    rgb(:,3:5:end)=Usedimg(:,3:4:end);
    rgb(:,4:5:end)=Usedimg(:,4:4:end);
end

if yratio>1
    rgbtmp=rgb;
    clear('rgb');
    rgb=zeros(newlines,newcolumns);
    rgb(1:5:end,:)=rgbtmp(1:4:end,:);
    rgb(2:5:end,:)=rgbtmp(2:4:end,:);
    rgb(3:5:end,:)=rgbtmp(3:4:end,:);
    rgb(4:5:end,:)=rgbtmp(4:4:end,:);
    
end