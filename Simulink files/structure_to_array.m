function result = structure_to_array(input)

content = input.signals.values;

dimension = size(content);

result = zeros(dimension(3), max(dimension(1:2))); 

for i = 1 : dimension(3)
    if dimension(1)>dimension(2)
        result(i,:) = content(:,:,i);
    else
        result(i,:) = content(:,:,i)';
    end
    
end

end

