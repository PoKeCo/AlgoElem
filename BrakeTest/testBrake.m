clf;

for vkph=50:-1:0
    G=9.81;
    DELTA_T=0.1;
    MPS2KPH=3.6;
    KPH2MPS=1/3.6;
    a_max = 0.00*G;
    a_min =-0.35*G;
    j_max = 0.3*G;
    j_min =-0.3*G;
    YELLOW_TIME=2.3;

    %v0    =90*KPH2MPS;
    v0    =vkph*KPH2MPS;
    hist_size=1000000;
    hist=zeros(hist_size,6);

    Ts=(a_min-a_max)/j_min;
    Te=(0-a_min)/j_max;
    ve=-a_min*Te-1/2*j_max*Te^2;
    vs=v0+a_max*Ts+1/2*j_min*Ts^2;
    
    as=-sqrt( (2*j_max*j_min*v0-a_max^2*j_max)/(j_min-j_max) );
            
    
    if( vs-ve < 0 )
        Ts=(as-a_max)/j_min;
        Te=(0-as)/j_max;
        ve=-a_min*Te-1/2*j_max*Te^2;
        vs=v0+a_max*Ts+1/2*j_min*Ts^2;    
       
    end
    [as, a_min]
    

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
                xe=xs+(vs^2-ve^2)/(-2*a_min);
                %fprintf('xse=%f, car.x=%f\n',xe,car.x);    
            end
        else
            car.j=0;
            if( prv_car.j==j_min)
                Ts=(a_min-a_max)/j_min;            
                vs=v0+a_max*Ts+1/2*j_min*Ts^2;            
                xs=v0*Ts+1/2*a_max*Ts^2+1/6*j_min*Ts^3;
                %fprintf('vs=%f, car.v=%f\n',vs,car.v);
                %fprintf('xs=%f, car.x=%f\n',xs,car.x);
            end
        end    

        car.a=car.a+car.j*DELTA_T;
        car.v=car.v+car.a*DELTA_T;
        car.x=car.x+car.v*DELTA_T; 
        if( car.a>=0 && prv_car.a<0 )
            %%%%%xd=xe-1/2*a_min*Te^2-1/6*j_max*Te^3;
            xd=xe + ve*Te+1/2*a_min*Te^2+1/6*j_max*Te^3;
            %fprintf('xd=%f, car.x=%f\n',xd,car.x);
            break;
        end
    end

    t_idx=i;
    x_idx=1;
    figure(1);
    subplot(4,1,1);    
    plot( hist(1:t_idx,x_idx), hist(1:t_idx,2), '-' );
    axis([0,7,0,30]);
    subplot(4,1,2);
    plot( hist(1:t_idx,x_idx), hist(1:t_idx,3)*MPS2KPH, '-' );
    axis([0,7,0,50]);
    subplot(4,1,3);
    plot( hist(1:t_idx,x_idx), hist(1:t_idx,4)/G, '-' );
    axis([0,7,-0.5,+0.5]);
    subplot(4,1,4);
    plot( hist(1:t_idx,x_idx), hist(1:t_idx,5)/G, '-' );
    axis([0,7,-0.5,+0.5]);
    
    pause(0.001);
end

vd_size=101;
vd=zeros(vd_size,3);
once=1;
for i=1:vd_size
    v =(i-1);
    v0=v*KPH2MPS;
    %Ts=(a_min-a_max)/j_min;
    %Te=(0-a_min)/j_max;
    %ve=-a_min*Te-1/2*j_max*Te^2;
    %vs=v0+a_max*Ts+1/2*j_min*Ts^2;  
    
    as=-sqrt( (2*j_max*j_min*v0-a_max^2*j_max)/(j_min-j_max) );
    a=max(as,a_min);
    %if( vs-ve < 0 )    
    Ts=(a-a_max)/j_min;
    Te=(0-a)/j_max;
    ve=-a_min*Te-1/2*j_max*Te^2;
    vs=v0+a_max*Ts+1/2*j_min*Ts^2;        
    %end
    
    db=-(v0*Ts+1/2*a_max*Ts^2+1/6*j_min*Ts^3+...
         +(vs^2-ve^2)/(-2*a_min)...
         +ve*Te+1/2*a_min*Te^2+1/6*j_max*Te^3);
    dy=-v0*YELLOW_TIME;
    vd(i,1)=db;
    vd(i,2)=v;
    vd(i,3)=dy;    
    if( once && v>5 && db < dy )
        once = 0;
    end
end
ttl=sprintf('v_{max}=%3.1f[kph],G=-%3.2f:%3.2f[G], J=%3.2f:%3.2f[G/s], Y=%2.1f[sec]',v,-a_min/G,a_max/G,-j_min/G,j_max/G,YELLOW_TIME)
fname=sprintf('Gm%3.2f_%3.2f_Jm%3.2f_%3.2f_Y%2.1f',-a_min/G,a_max/G,-j_min/G,j_max/G,YELLOW_TIME)
figure(2);
plot( vd(:,1), vd(:,2), '-' ,...
      vd(:,3), vd(:,2), '-' );
title(ttl);
saveas(2,[fname,'.eps'],'eps');
saveas(2,[fname,'.jpg'],'jpg');
  
  
  