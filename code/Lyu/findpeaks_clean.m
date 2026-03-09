function [pk, tm] = findpeaks_clean(dat, peakRange, time)
    [pk,loc] = findpeaks(dat);
     preselect = find(time(loc)>=peakRange(1) & time(loc)<peakRange(2));
    if ~isempty(preselect)
        pk = pk(preselect);
        loc = loc(preselect);
    end
    if ~isnan(pk)
        pk = pk(pk == max(pk));
        loc = loc(pk == max(pk));
        tm = time(loc);
    else
        pk = nan;
        tm = nan;
    end
        
end