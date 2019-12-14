function [ x, y ] = getCross( l0, l1 )
%getCross (x0,y0,th0,r0), (x1,y1,th1,r1)‚ÌŒğ“_‚ğ‹‚ß‚Ü‚·
%  ‚±‚ÌŠÖ”‚ÌŠT—ª
%  Œğ“_‚ğ‹‚ß‚Ü‚·

    th0=l0(3);
    th1=l1(3);
    x0=l0(1)+l0(4)*cos(th0);
    y0=l0(2)+l0(4)*sin(th0);
    x1=l1(1);%+l1(4)*cos(th1);
    y1=l1(2);%+l1(4)*sin(th1);

    d=sin(th1-th0);
    dx=-(x0*sin(th0)-y0*cos(th0))*cos(th1)...
       +cos(th0)*(x1*sin(th1)-y1*cos(th1));
    dy=+sin(th0)*(x1*sin(th1)-y1*cos(th1))...
       -(x0*sin(th0)-y0*cos(th0))*sin(th1);
    x=dx/d;
    y=dy/d;
end