    function y = wait_for_key(keyName)
        while 1
            [~,keyCode]=KbStrokeWait;
            key = KbName(keyCode);

            if     strcmpi(key,keyName); break;
            elseif strcmpi(key,'ESCAPE'); 
                sca;
                error('Pressed ESC --- aborting experiment')
            end
        end
    end

