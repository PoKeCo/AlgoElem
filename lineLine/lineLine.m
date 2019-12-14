l0=[  0,0,pi/4+0.2*rand(),5];
l3=[20,5,-pi/4+0.2*rand(),5];
pl0=xythr2xyxy( l0 );
pl3=xythr2xyxy( l3 );

th0=l0(3)
th3=l3(3)
dth=th3-th0
if( dth > pi )
    dth = dth-pi*2;
elseif( dth < -pi )
    dth = dth+pi*2;    
end
th1d=th0+dth/3;
th2d=th3-dth/3;

l1d=[pl0(2,1), pl0(2,2), th1d   , l0(3) ];
l2d=[pl3(1,1), pl3(1,2), th2d+pi, l3(3) ];


%[x, y] = getCross(l0, l3);
[x, y] = getCross(l1d, l2d);

pl1=[pl0(2,1), pl0(2,2) ;
     x       , y       ];
pl2=[x       , y        ; 
     pl3(1,1), pl3(1,2)];
 
l1=xyxy2xythr( pl1 );
l2=xyxy2xythr( pl2 );


pl1=xythr2xyxy( l1 );
pl2=xythr2xyxy( l2 );

plot( pl0(:,1), pl0(:,2), 'c.-', ...
      pl1(:,1), pl1(:,2), 'm.-', ...
      pl2(:,1), pl2(:,2), 'r.-', ...
      pl3(:,1), pl3(:,2), 'c.-', ...
      x, y, 'ro'); 


  
axis equal;
