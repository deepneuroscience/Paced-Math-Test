function closeit(src, event, f1)
disp('Time out!');
f2 = findall(0, 'Type', 'figure');
fnew = setdiff(f2, f1);
if ishandle(fnew);
      close(fnew);
end