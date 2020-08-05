function data = normData(data)

for i = 1:size(data,1)
   rn = max(data(i,:)) -  min(data(i,:));
   data(i,:) = (data(i,:) - min(data(i,:))) / rn;
end

end