function wd = init_screen(bool_debug, bool_mac)
    txtsize = 24;
    AssertOpenGL;
    imagingmode=kPsychNeedFastBackingStore;	% flip takes ages without this
    
    screenNr = max(Screen('screens'));


    %% debug: SkipSyncTests
    if (1 == bool_debug && 0 == bool_mac)
        Screen('Preference','SkipSyncTests',2);
        wd = Screen('OpenWindow',0,[127 127 127],[0 0 1300 780],[],[],[],[],imagingmode);
    elseif (1 == bool_debug && 1 == bool_mac)
        Screen('Preference','SkipSyncTests',2);
        wd = Screen('OpenWindow', 0, [127 127 127], [0 0 1300 780]);
        
    %% no debug --> no SkipSyncTests
    elseif (0 == bool_debug && 1 == bool_mac)
        wd = Screen('OpenWindow', 0, [127 127 127], [0 0 1300 780]);
    elseif (0 == bool_debug && 0 == bool_mac)
        wd = Screen('OpenWindow',screenNr,[127 127 127],[],[],[],[],[], imagingmode);
        Screen('TextSize', wd, txtsize);
    end
    Screen('TextSize', wd, txtsize);
    Screen('Preference','TextRenderer',0);

end