function varargout = timeoutDlg_for_subtraction(dlg, delay, varargin)
% Dialog function with timeout property
% dlg is a handle to the dialog function to be called
% delay is the length of the delay in seconds
% other input arguments as required by the dialog
% EXAMPLE FUNCTION-CALL
% To display an input dialog box (REFER MATLAB HELP DOC) with a 
% timeout = 6 second say, the function call would be:
%
% [matrix_size_value, colormap_string] = timeoutDlg_for_subtraction(@inputdlg, 6, ...
%                                {'Enter matrix size:','Enter colormap name:'}, ...
%                                'Input for peaks function', 1, {'20','hsv'})
% Setup a timer to close the dialog in a moment
f1 = findall(0, 'Type', 'figures');
t = timer('TimerFcn', {@closeit f1}, 'StartDelay', delay);
start(t);
% Call the dialog
retvals = dlg(varargin{:});
if numel(retvals) == nargout
      varargout = retvals(:);
else
      varargout = cell(1, nargout);
end
% Delete the timer
if strcmp(t.Running, 'on')
       stop(t);
end
delete(t);