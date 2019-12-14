
G=9.81;

%%%%%%%%%%%%%%%%%%%%%%%%%%
MPS2KPH=3.6;
KPH2MPS=1/MPS2KPH;
DeltaT=0.1;
ACTION_GO   = 1;
ACTION_STOP = 0;
SIGNAL_GREEN = 3;
SIGNAL_YELLOW= 2;
SIGNAL_RED   = 1;
%%%%%%%%%%%%%%%%%%%%%%%%%%

DULATION_GREEN =8;
DULATION_YELLOW=1;
DULATION_RED   =8;

ACC_GO      =  0.1*G;
ACC_STOP    = -0.3*G;
YELLOW_TIME = 4;

trigger_pos  = -48.02923 ;%-48.0
signal_pos   = 0;

V_DEST  = 60*KPH2MPS;

car.x=-100;
car.v=60/3.6;
car.a=0;
car.j=0;
car.action=ACTION_GO;
car.signal=SIGNAL_GREEN;
car.prev_signal=car.signal;
car.prev_action=car.action;

hist_size=1000;
hist=zeros(hist_size,7);

signal_change_time=inf;
once=1;
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
%    if( car.signal ~= SIGNAL_GREEN )
%        car.action = ACTION_STOP;
%    else
%        car.action = ACTION_GO;
%    end
    signal_dist = signal_pos - car.x ;
    req_acc =(0^2-car.v^2)/(2*signal_dist);
    switch ( car.signal )
        case SIGNAL_GREEN
            switch( car.prev_signal )
                case SIGNAL_GREEN  %(G->G)
                    car.action = ACTION_GO;
                case SIGNAL_YELLOW %(Y->G) don't care
                    
                case SIGNAL_RED    %(R->G)
                    car.action = ACTION_GO;
            end                    
        case SIGNAL_YELLOW
            switch( car.prev_signal )
                case SIGNAL_GREEN   %(G->Y)
                    if( req_acc < ACC_STOP ) 
                        if( YELLOW_TIME * car.v > signal_dist )
                            disp 'Msg: I can go thru'
                            car.action = ACTION_GO;          
                        else
                            disp 'War: Illegal over run will be caused. I will try to stop'
                            car.action = ACTION_STOP;                    
                        end
                    else
                        disp 'Msg: I can stop.'
                        car.action = ACTION_STOP;
                    end
                case SIGNAL_YELLOW  %(Y->Y)
                    car.action = car.prev_action;
                case SIGNAL_RED     %(R->Y) don't care                    
            end                    
        case SIGNAL_RED
            switch( car.prev_signal )
                case SIGNAL_GREEN   %(G->R) don't care
                case SIGNAL_YELLOW  %(Y->R)
                    car.action = car.prev_action;
                    if( ( signal_dist <= 0 && car.action == ACTION_GO   ) || ...
                        ( signal_dist >  0 && car.action == ACTION_STOP )        )
                        disp 'OK'
                    else
                        disp 'NG : Illegal action Stop Line thru under SIGNAL_RED'
                    end                    
                case SIGNAL_RED     %(R->R)
                    car.action = car.prev_action;
                    if( signal_dist < 0 && car.action == ACTION_STOP ) 
                        disp 'NG : OVER RUN'
                    end
            end                    
    end
    
    % Action and Acc
    if( car.action == ACTION_STOP )        
        if( car.v+req_acc*DeltaT>0 )            
            car.a = req_acc;
        else
            car.a = -car.v/DeltaT;
        end 
    else
        if( car.v+ACC_GO*DeltaT<=V_DEST )
            %car.a = min( 0.1*G, (V_DEST-car.v)*4.95 );
            car.a = min( ACC_GO, (V_DEST-car.v)/DeltaT );
        else
            car.a = 0;
        end
    end    
    % Update Car State
    car.a = car.a + car.j * DeltaT ;
    car.v = car.v + car.a * DeltaT ;
    car.x = car.x + car.v * DeltaT ;    
    car.prev_signal = car.signal;
    car.prev_action = car.action;
    
    % Simulation Stop
    if( car.v <= 0.1*KPH2MPS || car.x >= 80 )
        break;
    end
    
end

hist(i+1:end,:)=repmat(hist(i,:),hist_size-i,1);
%hist(1:hist_size,2)=-hist(1:hist_size,2)+repmat(hist(i,2),hist_size,1);
%hist(1:hist_size,2)=hist(1:hist_size,2)-0*repmat(hist(i,2),hist_size,1);

x_idx=1;
subplot(4,1,2);
plot( hist(1:hist_size,x_idx), hist(1:hist_size,2) ,'-',...
      [0;t], [signal_pos ,signal_pos]              ,'-',...
      [0;t], [trigger_pos,trigger_pos]             ,'-'     );
subplot(4,1,3);
plot( hist(1:hist_size,x_idx), hist(1:hist_size,3)*MPS2KPH, '-');
subplot(4,1,4);
plot( hist(1:hist_size,x_idx), hist(1:hist_size,4)/G      , '-');
subplot(4,1,1);
plot( hist(1:hist_size,x_idx), hist(1:hist_size,6)        , '-',...
      hist(1:hist_size,x_idx), hist(1:hist_size,7)        , '-'     );
axis([0,t,-0.1,3.1]);

