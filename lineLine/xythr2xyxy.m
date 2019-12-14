function [ xyxy ] = xythr2xyxy( xythr )
%xythr2xyxy (x,y,th,r)‚Å‚ ‚ç‚í‚³‚ê‚é’¼ü‚ğ(x0,y0,x1,y2)‚ÌÀ•W‚É•ÏŠ·‚µ‚Ü‚·
%  ‚±‚ÌŠÖ”‚ÌŠT—ª
    xyxy=[ xythr(1)                       , xythr(2)                         ;
           xythr(1)+xythr(4)*cos(xythr(3)), xythr(2)+xythr(4)*sin(xythr(3)) ];
   
end