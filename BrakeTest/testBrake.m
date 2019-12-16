clf;
G=9.81;
DELTA_T=0.001;
MPS2KPH=3.6;
KPH2MPS=1/3.6;
a_max = 0.1*G;
a_min =-0.35*G;
j_max = 0.1*G;
j_min =-0.1*G;
v0    =90*KPH2MPS;
hist_size=1000000;
hist=zeros(hist_size,6);

Ts=(a_min-a_max)/j_min;
Te=(0-a_min)/j_max;
ve=-a_min*Te-1/2*j_max*Te^2;


car.t=0;
car.x=0;
car.v=v0;
car.a=a_max;
car.j=j_min;


for i=1:hist_size
    
    %Save Previous car state
    prv_car=car;
    
    %SetTime
    car.t=(i-1)*DELTA_T;
    
    %Set History
    hist(i,1)=car.t;
    hist(i,2)=car.x;
    hist(i,3)=car.v;
    hist(i,4)=car.a;
    hist(i,5)=car.j;
        
    %
    if( car.t<Ts )
        car.j=j_min;
    elseif( car.v<ve )
        car.j=j_max;
        if( prv_car.j==0 )
            xe=xs+(vs^2-ve^2)/(-2*a_min)
            fprintf('xse=%f, car.x=%f\n',xe,car.x);    
        end
    else
        car.j=0;
        if( prv_car.j==j_min)
            disp car.x            
            Ts=(a_min-a_max)/j_min;            
            vs=v0+a_max*Ts+1/2*j_min*Ts^2;            
            xs=v0*Ts+1/2*a_max*Ts^2+1/6*j_min*Ts^3;
            fprintf('vs=%f, car.v=%f\n',vs,car.v);
            fprintf('xs=%f, car.x=%f\n',xs,car.x);
        end
    end    
    
    car.a=car.a+car.j*DELTA_T;
    car.v=car.v+car.a*DELTA_T;
    car.x=car.x+car.v*DELTA_T; 
    if( car.a>=0 && prv_car.a<0 )
        %xd=xe-1/2*a_min*Te^2-1/6*j_max*Te^3;
        xd=xe + ve*Te+1/2*a_min*Te^2+1/6*j_max*Te^3;
        fprintf('xd=%f, car.x=%f\n',xd,car.x);
        break;
    end
end
t_idx=i;
x_idx=1;
figure(1);
subplot(4,1,1);
plot( hist(1:t_idx,x_idx), hist(1:t_idx,2), '-' );
subplot(4,1,2);
plot( hist(1:t_idx,x_idx), hist(1:t_idx,3)*MPS2KPH, '-' );
subplot(4,1,3);
plot( hist(1:t_idx,x_idx), hist(1:t_idx,4)/G, '-' );
subplot(4,1,4);
plot( hist(1:t_idx,x_idx), hist(1:t_idx,5)/G, '-' );
car.x;

vd_size=101;
vd=zeros(vd_size,3);
YELLOW_TIME=3;
for i=1:vd_size
    v =(i-1);
    v0=v*KPH2MPS;
    Ts=(a_min-a_max)/j_min;
    Te=(0-a_min)/j_max;
    ve=-a_min*Te-1/2*j_max*Te^2;
    vs=v0+a_max*Ts+1/2*j_min*Ts^2;   
    d=v0*Ts+1/2*a_max*Ts^2+1/6*j_min*Ts^3+...
        +(vs^2-ve^2)/(-2*a_min)...
        +ve*Te+1/2*a_min*Te^2+1/6*j_max*Te^3;
    vd(i,1)=-d;
    vd(i,2)=v;
    vd(i,3)=-v0*YELLOW_TIME;
end
figure(2);
plot( vd(:,1), vd(:,2), '-' ,...
      vd(:,3), vd(:,2), '-' );