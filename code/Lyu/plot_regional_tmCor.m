function  plot_regional_tmCor(timeseries, metaT, ROIs, filterIdx, plot_folder, cfg)
% dl577@stanford.edu, March 31 2023
% 1. the plotting function requires timexCorr matrix, 
% the size(timseries, 1) should be in the same length as the filterIdx
% and size(timeseries,2) should be in the same length as the cfg.time 
% the figure has two subplots, the subplot(1,2,1) has the inflow pathway,
% and the subplot(1,2,2) has the outflow pathway
% number (pair number) same as the meta table (metaT)
% 2. metaT needs to have metaT.JP_label_in = JP_label_in;
%metaT.JP_label_out colmns sorted.
% 3. dimension of zccep_clean : pairsID * timepoints
% 4.The ROIs can be a cell or characters, it will be the region of interest to
% examine their inflow and outflow pathway among all the JP_labelled
% regions given in metaT.
% 5. cfg is a structure with some parameters to manipulate the data
% cfg.thr is the threshold used to detect ROI-CCEP peaks
% 6. dependencies:
%{
addpath(fullfile(home_dir, 'Dropbox/scripts/external/cbrewer2/cbrewer2'));
addpath(fullfile(home_dir, 'Dropbox/scripts/Stanford/lbcn_preproc/vizualization'));
addpath(fullfile(home_dir, 'Dropbox/scripts/Stanford/CECS_Pipeline_COPY/CECS_Pipeline/CCEP_pipeline/tools'));
addpath(fullfile(home_dir, 'Dropbox/scripts/external/tight_subplot'))
addpath(fullfile(home_dir, 'Dropbox/scripts/Stanford/CECS_Pipeline_COPY/personal_validation'))
%}
%% define default
if ischar(ROIs)
    ROIs = strcell(ROIs);
end

pairTypes = cell(length(ROIs),2);
for ir = 1:length(ROIs)
    pairTypes(ir,:) = {ROIs{ir}, 'brain'};
end

if nargin<4 || isempty(filterIdx)
    vars = metaT.Properties.VariableNames;
    ttpIdx = contains(vars, 'pks_time');
    artpeakearlytime = 10; % assumption
    % filter data: use activated ccep, Euclidean distance>5, ipsilateral pairs
    disp('Use activated CCEP (with time-to-peaks>10 ms), Euclidean distance>5mm, ipsilateral pairs...')
    filterIdx = find(...
        metaT.MNIout_coord_1 .* metaT.MNIin_coord_1 > 0 &... % ipsilateral
        metaT.eudDist>5 & ...
        (sum(table2array(metaT(:, ttpIdx)), 2, 'omitnan') ) > artpeakearlytime   &... % exclude case when the only peak happens ealier than 10 ms
        ~ismember(metaT.JP_label_in, {'', 'empty', 'NAN', 'EXCLUDE', 'NA'}) & ...
        ~ismember(metaT.JP_label_out, {'', 'empty', 'NAN', 'EXCLUDE', 'NA'}) & ...
        (ismember(metaT.JP_label_in, {'antTH', 'midTH', 'pstTH'}) | ...
        ismember(metaT.JP_label_out, {'antTH', 'midTH', 'pstTH'}) ...
        ));
end

if nargin<5
    warning('No output directory is given, using the current directory')
    plot_folder = '.';
end

default_peakThr = 1.2;
default_promThr = 0.5;
default_jp_labels = unique(metaT.JP_label_in);

if nargin<6
    cfg.lift_par = 1;
    cfg.markerAddY = 0.23;
    cfg.peakThr = default_peakThr;
    cfg.promThr = default_promThr;
    cfg.time = -199:500;
    cfg.art_win = [-200:artpeakearlytime, 800:2000]; % default: not counting peaks before 10 ms and after 800 ms
    cfg.Areas = default_jp_labels;
    cfg.timeLim2disp = [];
    cfg.figposition = [543.0000   50.1429  950.0000  969.7143];
    fprintf('\n>>> Using roi-ccep peak detect thresholds: peak > %.2f, prominance > %.2f\n',cfg.peakThr,cfg.promThr )
else
    if ~isfield(cfg, 'time')
        cfg.time = -199:500;
    end
    if ~isfield(cfg, 'lift_par')
        cfg.lift_par = 1;
    end
    if ~isfield(cfg, 'markerAddY')
        cfg.markerAddY = 0.1;
    end
    if ~isfield(cfg, 'peakThr')
        cfg.peakThr = default_peakThr;
    end
    if ~isfield(cfg, 'promThr')
        cfg.promThr = default_promThr;
    end
    if ~isfield(cfg, 'Areas')
        cfg.Areas = default_jp_labels;
    end
    if ~isfield(cfg, 'timeLim2disp')
        cfg.timeLim2disp = [];
    end
     if ~isfield(cfg, 'figposition')
        cfg.figposition = [543.0000   50.1429  950.0000  969.7143];
    end
end

%% main function

time = cfg.time;

T = metaT(filterIdx,:);
jp_labels0 = cfg.Areas;


%% divide thamalus divisions
%   pairTypes = {'antTH', 'brain'; 'midTH', 'brain'; 'pstTH','brain'};

for p = 1:size(pairTypes,1)
    pair1 = pairTypes{p,1};
    pair2 = pairTypes{p,2};
    %% manually select partial data to present
    %  jp_labels = jp_labels(ismember(jp_labels, jp_include));
    ttls = {['outflow pathways of ' pair1], ['inflow pathways of ' pair1]};

    cmap0 = cbrewer2('Set2', length(jp_labels0));
    %% plot
   
    figure('Position',cfg.figposition);
    for pathway_id = 1:2
        %% group based on JP labels

        jp_IDX      = cell(size(jp_labels0));
        jp_labels   = {};
        meanDat_JP = []; seDat_JP = [];
        min_ttp_JP  = [];
        %
        for i = 1:length(jp_IDX)

            if pathway_id == 1 % outflow
                stimchan = pair1; 
                recordchan = pair2;
                pair_type = strjoin({stimchan, recordchan, '-'});
                jp_IDX{i} = find(strcmp(T.JP_label_in, jp_labels0{i}) & ...
                    strcmp(T.JP_label_out, stimchan) ...
                    );
            elseif pathway_id == 2 % inflow
                stimchan = pair2; 
                recordchan = pair1;
                pair_type = strjoin({stimchan, recordchan, '-'});
                jp_IDX{i} = find(strcmp(T.JP_label_out, jp_labels0{i}) & ...
                    strcmp(T.JP_label_in, recordchan) ...
                    );
            end
            if isempty(jp_IDX{i} )||length(jp_IDX{i})<3 || ...
              strcmp(jp_labels0{i}, pair1)   % does not allow self connection 
                continue; 
            end

            jp_labels{end+1,1} = jp_labels0{i};
            area_timeseries = timeseries(jp_IDX{i}, :);
            % pass threshold
            peakCors = max(area_timeseries,[],2);
            if length(find(peakCors>cfg.peakThr)) >= 5 % ensure at least 5 datapoints to average
                area_timeseries(peakCors<cfg.peakThr,:)=nan;
            else
                area_timeseries = nan(size(area_timeseries));
            end
            % ==============================

            mn = mean(area_timeseries, 1,  'omitnan');
            meanDat_JP = [meanDat_JP; mn];
            se = std(area_timeseries,1,  'omitnan')./sqrt(sum(~isnan(area_timeseries))); % standard error
            seDat_JP = [seDat_JP; se];

        end
        %}
        %% order by the time of the first peak
        pktime = [];  peakThr = cfg.peakThr; promThr = cfg.promThr;
        artwin = find(ismember(cfg.time, cfg.art_win));
        artwin = unique([artwin, find(cfg.time <= cfg.timeLim2disp(1) | cfg.time > cfg.timeLim2disp(2))]);
        for i = 1:size(meanDat_JP,1)
            % when not flip
            mn = meanDat_JP(i,:);
            [pks, locs] = findpeaks_clean(mn, cfg.timeLim2disp, time); %,'MinPeakHeight',peakThr, 'MinPeakProminence',promThr);
            locs(ismember(locs, artwin)) = []; pks(ismember(locs, artwin)) = []; %disregard the peaks happening in the first 15ms
            quickest = find(locs == min(locs, [], 'omitnan'));
            if isempty(quickest)
                pkloc_tmp = [nan, nan];
            else
                pkloc_tmp = [pks(quickest), locs(quickest)];
            end
           
            pktime(i,:) = pkloc_tmp; % default;
           
        end
        % sort labels by time to first peak
        [~,id_ordered]=sort(pktime(:,2));
        jp_fast = jp_labels(id_ordered);
        pktime   = pktime(id_ordered,:);
        meanDat_JP = meanDat_JP(id_ordered,:);
        seDat_JP = seDat_JP(id_ordered,:);
        % sort colors
        [~,~,cid_ordered] = intersect(jp_fast, jp_labels0, 'stable');
        cmap    = cmap0(cid_ordered,:);

        %% replot

        subplot(1,2, (-1.*pathway_id)+3)
        lift_par= cfg.lift_par;
        for i = 1:size(jp_fast,1)

            mn = meanDat_JP(i,:)+lift_par.*(i-1);
            se = seDat_JP(i,:);

            hold on
            % for i = 1:size(jp_ccep,1)
            % plot(time, jp_ccep(i,:), 'Color', [cmap(ij,:), 0.2]);
            shadedErrorBar(time, mn, se,...
                'lineProps',{'Color',cmap(i,:),'LineWidth', 1.35});
            % ====== decorations ==============
            set(gca,'ytick',[])
            if isempty(cfg.timeLim2disp)
                xlims = get(gca, 'xlim');
            else
                xlims = cfg.timeLim2disp;
            end
            hold on

            % add annotation
            if ~isnan(pktime(i,1))
                % if rely on the zccep data itself
                x = pktime(i,2);
                y = pktime(i,1) + lift_par.*(i-1) + cfg.markerAddY ;
                % if rely on the meta table
                %  x = min_ttp(ij);
                %  y = mn(round(x - min(time))) - 0.5;
                % add marker
                plot(x,y,'v','MarkerFaceColor',cmap(i,:)/1.1,'MarkerEdgeColor','none');
            else
                x = 500;
                y = mean(mn);

            end
            % add anatomical labeling
            text(x+3,y, jp_fast{i}, 'Color', cmap(i,:)/1.2, 'Fontsize', 12)
            %add yline
            plot([xlims(1) xlims(2)], [lift_par.*(i-1),lift_par.*(i-1)], ':','Color','k')
            title(ttls{pathway_id})
            %end
            %plot(time, mean(jp_ccep,1, 'omitnan'), 'Color', cmap(ij,:));
            % add onset

        end % for jp label
        % ====== decorations ==============
        set(gca,'ytick',[])
        ylims = get(gca, 'ylim');
        xlim(xlims)
        ylim([-3 ylims(2)])
        % add xline
        plot([0 0],[ylims(1) ylims(2)],'Color','k')
        % add ruler
        plot([5 5],[-1 -1.6],'Color',[0.2 0.2 0.2], 'LineWidth', 1.1)
        %plot([20 20],[ylims(1)-10.6 ylims(1)-10.6],':','Color',[0.2 0.2 0.2])
        text(6.5,-1.6,'r = 0.6', 'Color',[ 0.2 0.2 0.2],'fontsize',10)
        hold off
        xlabel('Time (ms)')
        ylabel('Z score')
        fname = sprintf('%s_time2peaks', pair_type);

    end
    saveas(gcf, fullfile(plot_folder, [fname '.fig']))
    saveas(gcf, fullfile(plot_folder, [fname '.png']))
end