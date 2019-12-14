function [ l1, l2 ] = getDivPoint( l0, l3 )
%getDivPoint l0‚Æl3‚Ì‹æ•ªü‚©‚çA‚»‚ê‚ð•âŠ®‚·‚él1,l2‚Ì‹æ•ªü‚ð‹‚ß‚Ü‚·
%  ‚±‚ÌŠÖ”‚ÌŠT—ª
pl0=xythr2xyxy( l0 );
pl3=xythr2xyxy( l3 );

th0=l0(3);
th3=l3(3);
dth=th3-th0;
%if( dth > pi )
%    dth = dth-pi*2;
%elseif( dth < -pi )
%    dth = dth+pi*2;    
%end
th1d=th0+dth/3*1.1;
th2d=th3-dth/3*1.1;

l1d=[pl0(2,1), pl0(2,2), th1d   , l0(3) ];
l2d=[pl3(1,1), pl3(1,2), th2d+pi, l3(3) ];

[x, y] = getCross(l1d, l2d);

pl1=[pl0(2,1), pl0(2,2) ;
     x       , y       ];
pl2=[x       , y        ; 
     pl3(1,1), pl3(1,2)];
 
l1=xyxy2xythr( pl1 );
l2=xyxy2xythr( pl2 );
