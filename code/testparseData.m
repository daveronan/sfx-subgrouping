% An attempt to make sense of the treeLinkFeatures output data in a
% meaningful way, and to understand why so man 

tl = [];
for i = 1:length(featureList)
    t = zeros(5,1);
    for ii = 1:5
        t(ii) = (featureList{i}(ii) == ii);
    end
    tl = [tl; (sum(t)==5)];
end

%%
compareList = linkList(find(tl),1:2);

for i = 1:length(compareList)
    try
        t1 = T(mod(compareList(i,1),length(featureList)+1));
        t2 = T(mod(compareList(i,2),length(featureList)+1));
        if(t1 == t2)
            fprintf('Line %d matches\n',i);
        else
            fprintf('Line %d FAILS\n', i);
        end
    catch
       %TO CATCH- Attempted to access T(0); index must be a positive integer or logical.
    	fprintf('Line %d CRASH **************\n',i);

    end    
    %%% THIS DOESNT WORK - Attempted to access T(0); index must be a positive integer or logical.


end