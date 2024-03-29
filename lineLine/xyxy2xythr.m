function [ xythr ] = xyxy2xythr( xyxy )
%xyxy2xythr (x0,y0;x1,y1)の形式から(x,y,th,r)の形式に変換します。
%  この関数の概略
    xythr=zeros(1,4);
    xythr(1)=xyxy(1,1);
    xythr(2)=xyxy(1,2);
    dx=xyxy(2,1)-xyxy(1,1);
    dy=xyxy(2,2)-xyxy(1,2);
    xythr(3)=atan2( dy, dx );
    xythr(4)=sqrt(dx*dx+dy*dy);
end
