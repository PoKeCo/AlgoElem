function [ xyxy ] = xythr2xyxy( xythr )
%xythr2xyxy (x,y,th,r)であらわされる直線を(x0,y0,x1,y2)の座標に変換します
%  この関数の概略
    xyxy=[ xythr(1)                       , xythr(2)                         ;
           xythr(1)+xythr(4)*cos(xythr(3)), xythr(2)+xythr(4)*sin(xythr(3)) ];
   
end