function [weightCol, note] = resolve_weight_column(tbl, requestedCol)
%RESOLVE_WEIGHT_COLUMN Resolve feature column with deterministic fallback.

vars = tbl.Properties.VariableNames;
lv = lower(vars);
note = '';

if ismember(requestedCol, vars)
    weightCol = requestedCol;
    return;
end

if any(strcmpi(vars, requestedCol))
    idx = find(strcmpi(vars, requestedCol), 1, 'first');
    weightCol = vars{idx};
    note = sprintf('Requested weight column "%s" not found; using case-insensitive match "%s".', requestedCol, weightCol);
    return;
end

pref = {'peak_maxCor_clst1','peak_maxCor_clst2','peak_maxCor_clst3'};
for i = 1:numel(pref)
    idx = find(strcmpi(vars, pref{i}), 1, 'first');
    if ~isempty(idx)
        weightCol = vars{idx};
        note = sprintf('Requested weight column "%s" missing; using "%s".', requestedCol, weightCol);
        return;
    end
end

idx = find(contains(lv, 'peak_maxcor'), 1, 'first');
if ~isempty(idx)
    weightCol = vars{idx};
    note = sprintf('Requested weight column "%s" missing; using closest column "%s".', requestedCol, weightCol);
    return;
end

error('No compatible peak_maxCor column found in metaTable.');
end

