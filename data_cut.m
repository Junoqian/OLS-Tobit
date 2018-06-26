function outputy = data_cut(inputy,level)
outputy = zeros(size(inputy,1),size(inputy,2));
cut_nums = ceil(level * length(inputy));
display(cut_nums);
for i = 1: size(inputy,2)
    data_labeled = [(1:length(inputy(:,i)))',inputy(:,i)];
    data_sorted = sortrows(data_labeled,2);
    data_sorted(end - cut_nums+1:end,2) = data_sorted(end-cut_nums+1,2);
    data_c = sortrows(data_sorted,1);
 %   display(data_c);
    outputy(:,i) = data_c(:,2);
end