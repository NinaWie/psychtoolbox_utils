% TEST SCRIPT FOR ALL PROVIDED FUNCTIONS
addpath('utils');


% simple comment the other things if you only want to test a single function
% it is not dependent on each other, except for the window wd that is
% necessary for everything else
wd = init_screen(1,1);
[wdw, wdh]=Screen('WindowSize', wd);

% Simple text display 
drawText('Welcome to this repo of Psychtoolbox snippets', wd);

% Continue with space
wait_for_key('space');  
 
% D   raw two arrows, one to the left, one to the right 
drawArrow(wd, 3*wdw/4, wdh/2, 1, 2); % right
drawArrow(wd, wdw/4, wdh/2, -1, 2); % left
Screen('Flip', wd);

% wait for keyboard input (either left or right)
rightleftarrow;

% Questionaire: Rate something on a scale
txt = 'How do you like this tutorial?';  
left_txt = 'completely useless';
right_txt = 'very nice!';
scale = 15;
current_rating=8;
response = rate_on_scale(wd, scale, current_rating, txt, left_txt, right_txt);
disp(['You like this tutorial by ' num2str(response) ' %']);

% N-back
drawText('Start n-back task', wd);
wait_for_key('space' );
% 1 if feedback is shown, 0 else
nback(3, 'bddwtdbcd', wd, 1); 
      
% Close screen
sca;