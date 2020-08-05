function [LU,occ] = countElementOccurences(L)

LU = unique(L);
occ = zeros(length(LU),1);

for i = 1:length(L)
    for ii = 1:length(LU)
        if(strcmp(L{i}, LU{ii}))
%             fprintf('L= %s, LU= %s \n',L{i},LU{ii});
            occ(ii) = occ(ii) + 1;
        end
    end
end

end