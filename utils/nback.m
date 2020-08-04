function [target_block, choice_block, correct_block, RT_choice_block] = nback(n, block, wd, feedback)
    % returns: 
        % target: list with 1 if it is a hit at this point and 0 otherwise
        % choice_block: list with actual responses of the subject
        % correct_block: list indicating where the response was correct
         % Note: True negatives are not counted as correct
        % RT_choice_block: list of same length with reaction times
        

    [wdw, wdh]=Screen('WindowSize', wd);
    
    % Define output variables
    RT_choice_block(1:length(block)) = NaN;
    choice_block(1:length(block)) = 0;
    correct_block(1:length(block)) = NaN;
    
    % Define targets by shifting block and compare
    shifted = block;
    shifted(n+1:end) = block(1:end-n);
    target_block = shifted==block;
    target_block(1:n)=0;

    txtsize = 32;
    [wdw, wdh]=Screen('WindowSize', wd);
    for j = 1:length(block) % number of letters
        pressed=0;
        Screen('TextSize', wd, txtsize);
        Screen('Flip',wd);
        DrawFormattedText(wd,[num2str(n), '-back \n \n \n \n' block(j) '\n \n \n \n'],'center','center',[255,255,255],wdw/15,[],[],1.5);
        Screen('TextSize', wd, txtsize);
        Screen('Flip',wd);
        KbQueueCreate;
        startTime=GetSecs; % measuring reaction time from here onwards
        KbQueueStart;
        WaitSecs(1.5);
        DrawFormattedText(wd,[num2str(n), '-back \n \n \n \n' '+ \n \n \n \n'],'center','center',[255,255,255],wdw/15,[],[],1.5);
        Screen('TextSize', wd, txtsize);
        Screen('Flip',wd);
        WaitSecs(1); 
        [buttonpressed, firstPress] = KbQueueCheck;
        if buttonpressed
            pressedCodes = find(firstPress);
            for i=1:size(pressedCodes,2)
                if (1 == strcmp(KbName(pressedCodes(i)),'space'))
                    reactionTime = firstPress(pressedCodes(i)) - startTime;
                    pressed=1;
                end
            end
        end
        KbQueueStop ;
        
        if pressed
            choice_block(j)=1;
        end

        % DISPLAY FEEDBACK (if argument set to True)
        % choice: 1 = hit, 0 = miss
        if pressed == 0  && target_block(j) == 0 % correctly not pressed --> NaN
            RT_choice_block(j) = NaN; 
            correct_block(j) = NaN;
        elseif pressed > 0 && target_block(j) == 1 % hits
            RT_choice_block(j) = reactionTime;
            correct_block(j) = 1;
            if feedback
                DrawFormattedText(wd,[num2str(n), '-back \n \n \n \n' '+ \n \n \n \n'],'center','center',[255,255,255],wdw/15,[],[],1.5);
                DrawFormattedText(wd,'Correct answer!','center',wdh*(3/4),[0,255,0],wdw/15,[],[],1.5);
                Screen('TextSize', wd, txtsize);
                Screen('Flip',wd);
                WaitSecs(1); 
            end
        elseif pressed == 0 && target_block(j) == 1 % misses
            RT_choice_block(j) = NaN;
            correct_block(j) = 0;
            if feedback
                DrawFormattedText(wd,[num2str(n), '-back \n \n \n \n' '+ \n \n \n \n'],'center','center',[255,255,255],wdw/15,[],[],1.5);
                DrawFormattedText(wd,'Wrong answer. You should have pressed space.','center',wdh*(3/4),[172,63,63],wdw/15,[],[],1.5);
                Screen('TextSize', wd, txtsize);
                Screen('Flip',wd);
                WaitSecs(1.25);
            end
        elseif pressed > 0 && target_block(j) == 0 % false alarms
            RT_choice_block(j) = reactionTime;
            correct_block(j) = 0;
            if feedback
                DrawFormattedText(wd,[num2str(n), '-back \n \n \n \n' '+ \n \n \n \n'],'center','center',[255,255,255],wdw/15,[],[],1.5);
                DrawFormattedText(wd,'Wrong answer. You were not supposed to press space.','center',wdh*(3/4),[172,63,63],wdw/15,[],[],1.5);
                Screen('TextSize', wd, txtsize);
                Screen('Flip',wd);
                WaitSecs(1.25);
            end
        end
    end
end