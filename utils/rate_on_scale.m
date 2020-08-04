function current_rating = rate_on_scale(wd, scale, current_rating, txt, left_txt, right_txt)
    [wdw, wdh]=Screen('WindowSize', wd);
    start = wdw/10;
    ende = wdw*9/10;
    ypos = wdh/2;
    
    % draw header
    Screen('TextSize', wd, 20);
    DrawFormattedText(wd,txt,'center',wdh/5,[255,255,255],60,[],[],1.5);
    
    % draw the bar itself with all ticks |
    for i =1:scale
        xpos = start+(i-1)*(ende-start)/(scale-1);
        Screen('DrawText', wd, '|', xpos ,ypos,[255,255,255]);
    end
    
    % Mark the current position
    red_pos = start+(current_rating-1)*(ende-start)/(scale-1);
    Screen('DrawText', wd, '|', red_pos ,ypos,[255,0,0]);
    Screen('TextSize', wd, 15);
    
    % Write the left and right texts
    Screen('DrawText', wd, left_txt, start-wdw/20, ypos+wdh/10,[255,255,255]);
    Screen('DrawText', wd, right_txt, ende-wdw/10, ypos+wdh/10,[255,255,255]);
    Screen('TextSize', wd, 20);
    Screen('Flip', wd, [], 1);

    % Go left and right dependent on input
    rate_scale = 0.1;
    while 1
        [keyIsDown, ~, keyCode, ~] = KbCheck;
        if keyIsDown
            key = KbName(keyCode);
            if isequal(key,'RightArrow')&& current_rating~=scale
                draw_scale(wd, current_rating, current_rating+1, scale);
                current_rating = current_rating+1;
                WaitSecs(rate_scale);
            elseif isequal(key,'LeftArrow') && current_rating~=1
                draw_scale(wd, current_rating, current_rating-1, scale);
                current_rating = current_rating-1;
                WaitSecs(rate_scale);
            elseif isequal(key,'space')
                Screen('FillRect',wd,[127 127 127]);
                Screen('Flip', wd);
                WaitSecs(0.5);
                break;
            elseif isequal(key,'ESCAPE')
                sca;
                error('Pressed ESC --- aborting experiment');
            end
        end
    end    

    % Function to switch from one position to each other and re-colour
    function new_pos = draw_scale(wd, prev_red, new_red, scale)
        [wdw, wdh]=Screen('WindowSize', wd);
        start = wdw/10;
        ende = wdw*9/10;
        ypos = wdh/2;
        startpos = start+(new_red-1)*(ende-start)/(scale-1);
        Screen('DrawText', wd, '|', startpos ,ypos,[255,0,0]);
        startpos = start+(prev_red-1)*(ende-start)/(scale-1);
        Screen('DrawText', wd, '|', startpos ,ypos,[255,255,255]);
        Screen('Flip', wd, [], 1);
    end
end