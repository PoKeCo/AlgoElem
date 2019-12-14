l1=[  0,0,pi/4+pi/4*rand(),3;
     0,0,0,0;     
     0,0,0,0;
    20,5,-pi/3+0*pi/8*rand(),5];
[ l1(2,:), l1(3,:) ] = getDivPoint( l1(1,1:4), l1(4,1:4) );
 
l2=[ l1(1,:); 
     0,0,0,0;
     0,0,0,0;
     0,0,0,0;
     0,0,0,0;
     l1(4,:)];
[ l2(2,:), l2(3,:) ] = getDivPoint( l1(1,1:4), l1(3,1:4) ); 
[ l2(4,:), l2(5,:) ] = getDivPoint( l1(2,1:4), l1(4,1:4) ); 

o=3;
l3=zeros(1+2^o+1,4);
l3(  1,:)=l2(  1,:);
l3(end,:)=l2(end,:);
for i=1:2^(o-1)
    [ l3(i*2,:), l3(i*2+1,:) ] = getDivPoint( l2(i,:), l2(i+2,:) );    
end

o=4;
l4=zeros(1+2^o+1,4);
l4(  1,:)=l3(  1,:);
l4(end,:)=l3(end,:);
for i=1:2^(o-1)
    [ l4(i*2,:), l4(i*2+1,:) ] = getDivPoint( l3(i,:), l3(i+2,:) );    
end

l=l4;
p_size=size(l,1)+1;%1+2^3+1+1;
p=zeros(p_size,2);
for i=1:(p_size-1)
    tmp_p=xythr2xyxy( l(i,:) );
    p(i,1)=tmp_p(1,1);
    p(i,2)=tmp_p(1,2);
end
p(p_size,1)=tmp_p(2,1);
p(p_size,2)=tmp_p(2,2);

plot( p(:,1), p(:,2), '.-' );
axis equal;


 