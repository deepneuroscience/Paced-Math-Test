%% Copyright Information
% Copyright (c) 12-March-2017 by Youngjun Cho
% 
% 


%% TASK A: Arithmatic Subtraction (Count Down): Youngjun Cho - 12 March 2017.

prompt = {'TEST TITLE:','Subject:'};
dlg_title = 'Input for data collection';
num_lines = 1; 

def = {'MATH-TASK-EASY','P'};
DataCollect = newid_enter_enabled_yj(prompt,dlg_title,num_lines,def);
    

Totaltime = 300; %Total Task time: 300s
duration = 7.5; % Duration for each segment: 7.5s

count= round(Totaltime/duration);
mInitNum = 5000;
UserData = cell(count+1,2);

[y_1,ft_1]=audioread('timer_10sec.mp3');
[y_2,ft_2]=audioread('Wrong-answer-sound-effect.mp3');
[y_3,ft_3]=audioread('Correct-answer.mp3');      

UserData(1,1)={'Correct Answer'};
UserData(1,2)={'User Answer'};
for yj=1:count
    tic
    sound(y_1(length(y_1)-round(length(y_1)*(duration/(length(y_1)/ft_1))):length(y_1)),ft_1) %% only play the duration
    UserAnswer = timeoutDlg_for_subtraction(@newid_enter_enabled_yj, duration, ...
                                {[int2str(mInitNum-yj+1) ' - ' int2str(1) ' = '],}, ...
                                'Simple Counting ', 1, {''})
    UserData(yj+1,1)= {int2str(mInitNum-yj)};
    UserData(yj+1,2)={UserAnswer};
    
  
   
    b=toc;
    if (duration-b)>0
        pause(duration-b);
    end
    
    if isempty(UserAnswer)
            sound(y_2,ft_2);
            'Wrong'
    else
        if str2num(UserAnswer)~=(mInitNum-yj)
            sound(y_2,ft_2);
            'Wrong'
        else
            sound(y_3,ft_3);      
            'Correct'
        end
    end  
    toc    
end

data = [DataCollect(1) '-' DataCollect(2) '-' date '.mat'];
save(strjoin(data), 'UserData' );


