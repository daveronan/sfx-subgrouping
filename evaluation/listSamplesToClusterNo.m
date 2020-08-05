for i = 1:size(ucl,1)
    if(mod(i-1,2))
        endLine =' \\';
    else
        endLine = ' & ';
    end
        
    disp([ucl{i} ' & ' num2str(ucl_count(i)) endLine])

end

%%
diary('ClassEvaluation.txt');

for i = 1:length(p)
   i
   for ii = 1:length(p(i).toPlot)
       disp([p(i).led{ii} ' & ' num2str(p(i).toPlot(ii))])
   end
    
end
diary off