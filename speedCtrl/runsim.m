
endT=10;
deltaT=0.1;
G=9.81;
KPH2MPS=1/3.6;
MPS2KPH=3.6;
x = 0;
a = 0;
v = 0*KPH2MPS;
j = 0;
hist_size=endT/deltaT+1;
hist_idx =0;
hist     =zeros(hist_size,5);
for t=0:deltaT:endT;
    if( t < 1 )
        j=+0.1*G;
    elseif( t < 2 )
        j=+0.0*G;
    elseif( t < 3 )
        j=-0.1*G; 
    elseif( t < 7 )
        j=0.0*G;       
    elseif( t <  8 )        
        j=-0.1*G; 
    elseif( t <  9 )
        j= 0.0*G; 
    elseif( t <  10 )
        j=+0.1*G; 
    elseif( t < 11 )
        j= 0.0*G; 
    else
        j= 0.0*G; 
    end
        
    a=a+deltaT*j;
    v=v+deltaT*a;
    x=x+deltaT*v;
    
    hist_idx=hist_idx+1;
    hist(hist_idx,1)=t;
    hist(hist_idx,2)=j;
    hist(hist_idx,3)=a;
    hist(hist_idx,4)=v;
    hist(hist_idx,5)=x;
    
end
plot( hist(:,1), hist(:,2), '.-', ... 
      hist(:,1), hist(:,3), '.-', ... 
      hist(:,1), hist(:,4), '.-'       );
  
      