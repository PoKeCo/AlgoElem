%%%%%%%%%%%%%%%%%%%%%%%%%%
G=9.81;
MPS2KPH=3.6;
KPH2MPS=1/MPS2KPH;
DeltaT=0.1;
SIGNAL_NONE  = 0;
SIGNAL_GREEN = 3;
SIGNAL_YELLOW= 2;
SIGNAL_RED   = 1;
SIGNAL_UNKOWN= 4;
ACTION_GO   = 1;
ACTION_STOP = 0;
%%%%%%%%%%%%%%%%%%%%%%%%%%


DULATION_GREEN =8;
DULATION_RED   =10;

DULATION_YELLOW= 4;
YELLOW_TIME    = 4;

ACC_GO      =  0.1*G;
ACC_STOP    = -0.3*G;


%trigger_pos  = -48.02923 ;
%trigger_pos  = -60*KPH2MPS*YELLOW_TIME+10;
trigger_pos  = -60;
signal_pos   = 0;

V_DEST  = 60*KPH2MPS;

car.x=-100;
car.v=60/3.6;
car.a=0;
car.j=0;
car.action=ACTION_GO;
car.signal=SIGNAL_GREEN;
car.dist  =-1;
car.prev_signal=car.signal;
car.prev_action=car.action;
car.prev_dist  =car.dist;

hist_size=1000;
hist=zeros(hist_size,8);

signal_change_time=inf;
once=1;

disp '-----------------'
for i=1:hist_size
    
    % Set time
    t=(i-1)*DeltaT;
    
    % Store History
    hist(i,1)=t;
    hist(i,2)=car.x;
    hist(i,3)=car.v;
    hist(i,4)=car.a;
    hist(i,5)=car.j;    
    hist(i,6)=car.action;
    hist(i,7)=car.signal;
    hist(i,8)=car.dist;
    
    % Change Signal        
    switch ( car.signal )
        case SIGNAL_GREEN
            if( (once&&(car.x>trigger_pos)) || (t >= signal_change_time + DULATION_GREEN) )
                car.signal = SIGNAL_YELLOW;
                signal_change_time = t;
                once = 0;
            end
        case SIGNAL_YELLOW
            if( t >= signal_change_time + DULATION_YELLOW )
                car.signal = SIGNAL_RED;
                signal_change_time = t;
            end
        case SIGNAL_RED
            if( t >= signal_change_time + DULATION_RED )
                car.signal = SIGNAL_GREEN;
                signal_change_time = t;                
            end
    end
    
    % Decide Action
    car.dist = signal_pos - car.x ;
    if( car.dist < 0 && car.prev_dist >= 0 )
        stop_line_pass=1;
    else
        stop_line_pass=0;
    end
    
    req_acc       = (0^2-car.v^2)/(2*car.dist);
    yellow_length = YELLOW_TIME * car.v;
    
    is_stoppable = (req_acc < ACC_STOP);
    is_passable  = (yellow_length > car.dist);
    switch ( car.signal )
        case SIGNAL_GREEN
            switch( car.prev_signal )
                case SIGNAL_GREEN  %(G->G)
                    car.action = ACTION_GO;
                case SIGNAL_YELLOW %(Y->G) don't care
                    car.action = ACTION_GO;
                case SIGNAL_RED    %(R->G)
                    car.action = ACTION_GO;
            end                    
        case SIGNAL_YELLOW
            switch( car.prev_signal )
                case SIGNAL_RED     %(R->Y) don't care 
                    % This case previous signal may be detected.
                    % G->Y Algorithm must be applied.
                case SIGNAL_GREEN   %(G->Y)
                    if( is_stoppable ) 
                        disp 'Msg: I CANNOT stop.'
                        if( is_passable )
                            disp 'Msg: I can pass'
                            car.action = ACTION_GO;  
                            disp '   : ACTION_GO'
                        else
                            disp 'Msg: I CANNOT pass'
                            disp 'War: I CANNOT stop or pass'
                            car.action = ACTION_STOP;                    
                            disp '   : ACTION_STOP'
                        end
                    else
                        disp 'Msg: I can stop.'
                        if( is_passable )
                            disp 'Msg: I can pass'
                            car.action = ACTION_GO;
                            disp '   : ACTION_GO'
                            %car.action = ACTION_STOP;
                        else
                            disp 'Msg: I CANNOT pass'
                            car.action = ACTION_STOP;
                            disp '   : ACTION_STOP'
                        end                       
                    end
                case SIGNAL_YELLOW  %(Y->Y)
                    if( stop_line_pass == 1 )
                        car.action = ACTION_GO;
                        disp '   : ACTION_GO'
                    else
                        car.action = car.prev_action;
                    end
                
            end                    
        case SIGNAL_RED
            switch( car.prev_signal )
                case SIGNAL_GREEN   %(G->R) don't care
                    car.action = ACTION_STOP;
                    disp '   : ACTION_STOP'
                case SIGNAL_YELLOW  %(Y->R)
                    car.action = car.prev_action;                     
                    if( ( car.dist <= 0 && car.action == ACTION_GO   ) || ...
                        ( car.dist >  0 && car.action == ACTION_STOP )        )
                        disp 'OK : Y->R'
                    else
                        disp 'NG : Y->R '
                    end                    
                case SIGNAL_RED     %(R->R)
                    %car.action = car.prev_action;
                    if( car.dist < 0 && car.action == ACTION_STOP ) 
                        car.action = ACTION_GO;
                        disp 'NG : OVER RUN'
                        disp '   : ACTION_GO'
                    else                        
                        car.action = car.prev_action; 
                    end                    
            end                    
    end
    
    % Action and Acc
    if( car.action == ACTION_STOP )
        if( car.dist > 0 )
           req_acc_stop = req_acc;
        else
           req_acc_stop = ACC_STOP;
        end
        if( car.v+req_acc_stop*DeltaT>0 )            
            car.a = req_acc_stop;
        else
            car.a = -car.v/DeltaT;
        end 
   else
        if( car.v+ACC_GO*DeltaT<=V_DEST )
            car.a = min( ACC_GO, (V_DEST-car.v)/DeltaT );
        else
            car.a = 0;
        end
    end

    %Limittter
    car.a = max( ACC_STOP, min( ACC_GO, car.a ));
    
    % Update Car State
    car.a = car.a + car.j * DeltaT ;
    car.v = car.v + car.a * DeltaT ;
    car.x = car.x + car.v * DeltaT ;    
    car.prev_signal = car.signal;
    car.prev_action = car.action;
    car.prev_dist   = car.dist;
    
    % Simulation Stop
    if( car.v <= 0.1*KPH2MPS || car.x >= 80 )
        break;
    end
    
end
brk_idx=i;

hist(i+1:end,:)=repmat(hist(i,:),hist_size-i,1);
%hist(1:hist_size,2)=-hist(1:hist_size,2)+repmat(hist(i,2),hist_size,1);
%hist(1:hist_size,2)=hist(1:hist_size,2)-0*repmat(hist(i,2),hist_size,1);

clf;
x_idx=1;
subplot(5,1,2);
plot( hist(1:hist_size,x_idx), hist(1:hist_size,2) ,'-',...
      [0;t], [signal_pos ,signal_pos]              ,'-',...
      [0;t], [trigger_pos,trigger_pos]             ,'-'     );
subplot(5,1,3);
plot( hist(1:hist_size,x_idx), hist(1:hist_size,3)*MPS2KPH, '-');
subplot(5,1,4);
plot( hist(1:hist_size,x_idx), hist(1:hist_size,4)/G      , '-');
subplot(5,1,1);

ptx=zeros(hist_size+2,1);
ptr=zeros(hist_size+2,1);
ptg=zeros(hist_size+2,1);
pty=zeros(hist_size+2,1);
ptu=zeros(hist_size+2,1);
for i=1:brk_idx
    j=i+1;    
    ptx(j)=hist(i,x_idx);
    ptr(j)=(hist(i,7)==SIGNAL_RED)*2;
    ptg(j)=(hist(i,7)==SIGNAL_GREEN)*2;
    pty(j)=(hist(i,7)==SIGNAL_YELLOW)*2;    
    ptu(j)=(hist(i,7)==0            )*2;    
end
i=brk_idx;
j=i+1;
ptx(j)=hist(brk_idx,x_idx);
ptr(j)=0;
ptg(j)=0;
pty(j)=0;
ptu(j)=0;

hold on;
patch( ptx, ptg, [0 1 0]);
patch( ptx, pty, [1 1 0]);
patch( ptx, ptr, [1 0 0]);
patch( ptx, ptu, [.5 .5 .5]);
plot( hist(1:hist_size,x_idx), hist(1:hist_size,6)+0.5    , '-');
hold off;  

subplot(5,1,5);
plot( hist(1:hist_size,x_idx), hist(1:hist_size,8)        , '-');


