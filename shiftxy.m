
function rgb = shiftxy(img,x,y)
rgb=img;
shiftabsx=abs(x);
shiftabsy=abs(y);
if x<0
    rgb(:,1:end-shiftabsx)=img(:,shiftabsx+1:end);
else if x>0
        rgb(:,shiftabsx+1:end)=img(:,1:end-shiftabsx);
    end
end

if y<0
    rgb(1:end-shiftabsy,:)=img(shiftabsy+1:end,:);
else if y>0
        rgb(shiftabsy+1:end,:)=img(1:end-shiftabsy,:);
    end
end

end