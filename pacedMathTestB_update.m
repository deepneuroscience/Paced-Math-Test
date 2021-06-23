
%% TASK B: Arithmatic Subtraction (Main - updated: task ) - 7 May 2018
%% Author: Youngjun Cho





clear all;
prompt = {'TEST TITLE:','Subject:'};
dlg_title = 'Input for data collection';
num_lines = 1;
def = {'MATH-TASK-DIFFICULT','P'};
DataCollect = newid_enter_enabled_yj(prompt,dlg_title,num_lines,def);

    

Totaltime = 180; % 5Min -> 3Min
duration = 7.5;


subtracter_group = {2,3,5,7,11,13,17,19,23,29,31,37,41,43,47,53,59,61,67,71,73,79,83,89,97};%
% subtracter_group = {127,131,137,149};%u

subtracter_index = 6; %-- 7May2018. 
% subtracter = subtracter_group{subtracter_index}; % insert your own subtracter

count= round(Totaltime/duration);
mPreviousNum = 5000; 
UserData = cell(count+1,2);

[y_1,ft_1]=audioread('timer_10sec.mp3');
[y_2,ft_2]=audioread('Wrong-answer-sound-effect.mp3');
[y_3,ft_3]=audioread('Correct-answer.mp3');      

UserData(1,1)={'Correct Answer'};
UserData(1,2)={'User Answer'};
UserData(1,3)={'Response Time'};  %-- 24Dec2017. Response time
HowManyAnswers = 3; %-- 7May2018. Comparing a user's performance from the three sequential questions with expected rates 
ExpectedAnswerRange={1,2};
UserData(1,4)={'Correct_or_not'};  %-- 7May2018. Comparing a user's performance from the three sequential questions with expected rates 
UserData(1,5)={'InstantCorrectRate'};  %-- 7May2018. Comparing a user's performance from the three sequential questions with expected rates 

for yj=1:count
    subtracter = subtracter_group{subtracter_index};
    tic
    mPreviousNum-subtracter
    sound(y_1(length(y_1)-round(length(y_1)*(7.5/(length(y_1)/ft_1))):length(y_1)),ft_1)
    UserAnswer = timeoutDlg_for_subtraction(@newid_enter_enabled_yj, duration, ...
                                {[int2str(mPreviousNum) ' - ' int2str(subtracter) ' = '],}, ...
                                'DIFFICULT TASK', 1, {''})
    b=toc;
    mPreviousNum=mPreviousNum-subtracter;
    UserData(yj+1,1)= {int2str(mPreviousNum)};
    UserData(yj+1,2)={UserAnswer};
    UserData(yj+1,3)={b};
    
    

    if (duration-b)>0
        pause(duration-b);
    end
    if isempty(UserAnswer)
        sound(y_2,ft_2);      
        'Wrong'
        UserData(yj+1,4)={0};
    else
        if str2num(UserAnswer)~=mPreviousNum
            sound(y_2,ft_2);      
            'Wrong'
            UserData(yj+1,4)={0};
        else
            sound(y_3,ft_3);                        
            'Correct'
            UserData(yj+1,4)={1};
        end
    end      
    
    toc
    if yj>=HowManyAnswers+1 % To ignore the first question.
        CorrectN=sum([UserData{2+yj-HowManyAnswers:1+yj,4}]);
        UserData(yj+1,5)={CorrectN/HowManyAnswers};
        if CorrectN>ExpectedAnswerRange{2}
            subtracter_index=subtracter_index+1;
            if subtracter_index>length(subtracter_group)
                subtracter_index=length(subtracter_group);
            end
        elseif CorrectN<ExpectedAnswerRange{1}
            subtracter_index=subtracter_index-1;
            if subtracter_index<1
                subtracter_index=1;
            end
        end
    end
end

data = ['./PacedMath/' DataCollect(1) '-' DataCollect(2) '-' date '.mat'];
save(strjoin(data), 'UserData' );

