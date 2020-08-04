function y = drawText(txt, wd)
    [wdw, wdh]=Screen('WindowSize', wd);
    Screen('TextSize', wd, 24);
    DrawFormattedText(wd,txt,'center','center',[255,255,255],100,[],[],2.5);
    Screen('TextSize', wd, 15);
    DrawFormattedText(wd,'Weiter mit der Leertaste.','center', wdh*(9.5/10),[255,255,255]);
    Screen('TextSize', wd, 24);
    Screen('Flip',wd);
end