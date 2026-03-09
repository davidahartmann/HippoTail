function weightArray = AreaWeightSum(fromAreaList, toAreaList, originalfromAreaList, originaltoAreaList, originalWeights)
    % the fromAreaList and toAreaList should be unique pairs while the original lists have repetitions, will take the average weights across all the repeated entry
    % originalWeights can take multiple columns (== different metrics)
    
    target_pair = strcat(fromAreaList, toAreaList);
    original_pair = strcat(originalfromAreaList, originaltoAreaList);
    N = length(target_pair);
    
    weightArray = nan(N, size(originalWeights,2));
    for n=1:N
        bln = strcmpi(original_pair, target_pair{n});
        weightArray(n,:) = sum(originalWeights(bln,:), 1, 'omitnan');
    end
        