function [right, time] = rightleftarrow(timeout)
    switch nargin
        case 0
            timeout = 100000; % wait very very long
    end
    
    right = NaN;
    timedout = false;
    
    start=GetSecs;
    while ~timedout
        [keyIsDown, secs, keyCode] = KbCheck();
        key = KbName(keyCode);
        if strcmpi(key,'b')|strcmpi(key,'right')|strcmpi(key,'RightArrow'); right=1; time = secs-start;  break;
        elseif strcmpi(key,'g')|strcmpi(key,'left')| strcmpi(key,'LeftArrow'); right=0; time = secs-start; break;
        elseif strcmpi(key,'ESCAPE')|strcmpi(key,'escape'); % |keyCode(KbName('escape'))
            sca;
            error('Pressed ESC --- aborting experiment')
        end
        
        if( (secs - start) > timeout)
            disp('timeout');
            timedout = true; 
            time = -1;
        end
    end
    
end