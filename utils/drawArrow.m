function drawArrow(wd, x,y, left_neg_right_pos, arrow_size)
    % arrow_size determines the general size (width and length)
    % x,y are the head coordinates
    % if left_pos_right_neg<0, then pointing to the left, else to the right
    head   = [ x, y ]; % coordinates of head
    width  = 20*left_neg_right_pos * arrow_size;  % width of arrow head
    length = 40*left_neg_right_pos * arrow_size * (-1);
    points = [ head-[0,width]         % left corner
               head+[width,0]         % right corner
               head+[0,width] ];      % vertex
    Screen('FillPoly', wd,[255,255,255], points);
    points_rect = [ head-[0,width/2]
                    head+[0,width/2] 
                    head+[length, width/2]
                    head+[length, -width/2] ];
    Screen('FillPoly', wd,[255,255,255], points_rect);  
end