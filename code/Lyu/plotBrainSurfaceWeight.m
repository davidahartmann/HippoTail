function [cfg, coordinatesSurf_cell] = plotBrainSurfaceWeight(cmcortex , coordinates_cell, weights_cell, timepoints, jplabel_cell, output_folder, anot, pers_rule,cfg, custom_figname)
% This plotting function is inherited from the "plot brain section" for making video
% CCEP of the self project
% It will project the weights of two hemistpheres to one hemisphere.
% It will adjust for electrode coverage
% It can take polarized weight (can be used in contrast map)
% It can take multiple timepoints
% It will use perspective rules to selectively show some anatomical
% region in certain perspectives
% It has the function dependency of ctmr_gauss_plot3.m
%-----------------------------------------------------------------------------
%% inputs:
% 1. cmcortex: surface structure of the brain, should be in the same space
% as the given coordinates
% 2. coordinates: a cell of 3-column vectors, each cell has the data to
% show for each type of weights. For each vector,each row is
% a 3-D coordinates in the euclidean space of a recording channel
% 3. weights_cell: a cell of weights, each cell has a weight matrix for a type
% each weight  a matrix of rows to assign to each coorinates, with the dimension of sites * timepoints *
% type; sites can be recording sites, and type can be different stimulation
% source
% 4. timepoints (optional): a column vector, each entry being the time point (unit in ms)
% 5. jplabel_cell (optional): is a hierarchical cell array with all anatomical labelling, to be used
% for show some electrodes in certain perspectives, need pers_rule to take
% effect, dimension: {{jp_label_in in type1}, {jp_label_in in type2},...}
% 6. output_folder (optional), the folder/directory where the figure can be
% saved.
% 7. anot: annotation, a cell array of texts to display beside each panel
% of the subplots
% 8. pers_rule (optional), should be read as a matlab table format, setting rules for
% what anatomical areas to show in what visual perspectives.
% 9.cfg is a structure with plotting configurations
% -- cfg.cmaps (optional) are the colormaps to use, if there are multiple cmaps given, put
% them in a cell array, each for a weight vector
% -- cfg.clims (optional): the types * [cmin cmax]  vectors to use for constraining the
% minimum and maximum values in the colorbar.
% dimension = type * cMapRangeDim
% -- cfg.suppress_colorbar(optional): 0 or 1
% ===========================================
% output:
% 1. cfg: plotting configuration used in producing this figure;
% 2. coordinatesSurf_cell, a cell containing the electrode coordinates
% projected to the nearest surface, same dimension as the input.
%-----------------------------------------------------------------------------
% dl577@stanford.edu, April 7 2023
%-----------------------------------------------------------------------------
%% set default
if isempty(cmcortex)
    freesurferhome = getenv('FREESURFER_HOME');
    [cmcortex.vert, cmcortex.tri] = read_surf(fullfile(freesurferhome, 'subjects/fsaverage' , 'surf', 'rh.pial'));
end

if nargin < 4 || isempty(timepoints)
    timepoints = 1;
end

if nargin < 5
    warning('No anatomical labelling is given.')
    jplabel_cell = {};
end

if nargin < 6
    warning('No output folder is given, plot will not be saved to the hard disk.')
    output_folder = [];
end

if (nargin < 5 || isempty(jplabel_cell)) && nargin < 8
    warning('No perspective rule is set. Show everything.')
    pers_rule = [];
end

if nargin < 7
    anot = {' ', ' ', ' '};
end


if (nargin < 8 || isempty(pers_rule))  && ~isempty(jplabel_cell)
    % local electrode transparency for each perspective - default file
    pers_rule = readtable( '~/Dropbox/Stanford_Matters/data/cohort_data/ELECTRODE_VISUALIZATION_RULE.csv');
end

if nargin < 9
    cfg = struct();
end

if nargin < 10
    custom_figname = [];
end

%---------plotting configurations -----
cfg_ = struct();
cfg_.pathway      = 'unknown';
cfg_.figPosition = [];
cfg_.suppress_colorbar = 0;
cfg_.cmaps = {};
cfg_.clims = [];
cfg_.climsPerc = repmat([0, 1], length(weights_cell),1); % use percentage of the data
cfg_.climMin = [];
cfg_.covgAdj = 1/2; % ratio of the elec coeverage to be divided off the weights,
% when two hemispheres are projected to one, set to 1/2: because as long as
% one anotomical area from one hemisphere shows positive, the plot should
% show it. Hence, it is not fair to adjust a location twice.
%-------- about activation/weights ------
cfg_.maxActRadius  = 250;
cfg_.ActSize = 'auto'; % change as the weight; cfg_.ActSize = 'constant': average of the weight; cfg_.ActSize = a number
cfg_.MarkerColor = repmat({[166,27,41]/256}, length(weights_cell),1);
% if one subplot is divergent colormap, then the cell has two row vectors,
% the first vector for the positive values, the second negative
% color options: [[166,27,41]/256; [255, 203, 1]/256;  [35, 118, 183]/256];% dark red[160, 28, 52],yellow, blue,
% %[[255, 145, 172]/256; [255, 145, 172]/256]; % pink = [ [188, 9, 45]/256; [188, 9, 45]/256];
cfg_.implicit_FaceAlpha = 0.07;
cfg_.implicit_EdgeAlpha = 0.15;
cfg_.explicit_FaceAlpha = 0.25;
cfg_.explicit_EdgeAlpha = 0.45;
%-------- about elec coverage ------
cfg_.recElecDotSize = 15;
cfg_.recElecFaceColor = [0.65 0.65 0.65];
cfg_.recElecEdgeColor = [0.25 0.25 0.25];
cfg_.recElec_implicit_EdgeAlpha = 0;
cfg_.recElec_implicit_FaceAlpha = 0;
cfg_.recElec_explicit_EdgeAlpha = 0.95; % the last value is alpha/transparency
cfg_.recElec_explicit_FaceAlpha = 0.7;
% ------- about the smooth color projection on the surface ------
cfg_.surfaceAlphaDataDivisor = 0.5; % the higher the value, the fainter the color.
cfg_.gsp = 80; % gaussian speading parameter
cfg_.isMNIspace = 0;
cfg_.plotNearestSurfaceCord = 1;
% -------- about brain surface --------
cfg_.brainAlpha = 0.75;
% -------- about text --------
default_text = 'CCEP';
cfg_.titletext = default_text;
cfg_.anotFontSize  = 14;
cfg_.titleFontSize = 13;

% >>>> rewrite cfg structure >>>>
if isstruct(cfg) && ~isempty(cfg)  % when cfg has values, rewrite the default
    fields = fieldnames(cfg);
    for i = 1:length(fields)
        fd = fields{i};
        cfg_.(fd) = cfg.(fd);
    end
    if isfield(cfg, 'clims') && ~isempty(cfg.clims)
        cfg_ = rmfield(cfg_, 'climsPerc');
    end
    cfg = cfg_;
else
    warning('Plotting configuration input should be a structure variables. Switch to default values.')
    cfg = cfg_;
end

if ~isempty(cfg.clims) && size(cfg.clims,1) == 1
    cfg.clims = repmat(cfg.clims, length(weights_cell),1);
end

if isempty(cfg.figPosition)
    if cfg.suppress_colorbar == 1
        cfg.figPosition = [84   533   720   794];
    else
        cfg.figPosition = [79   117   854   834];
    end
end
%--------------------------------------------------------------------------
% check input dimension
% if size(timepoints, 1) ~= size(weights_cubic,2 ) ||...
%         (size(coordinates,1)~=size(weights_cubic,1) && ~isempty(pers_rule))
%     error('There is some error in the inputs'' dimensions.')
% end

if isnumeric(cfg.cmaps) && ~isempty(cfg.cmaps)
    cfg.cmaps = repmat({cfg.cmaps}, length(weights_cell), 1);
end

if length(cfg.cmaps) ~= length(weights_cell)
    if ~isempty(cfg.cmaps) || length(cfg.cmaps) == 1
        error('The colormap input does not match data.')
    end
end

if isempty(cfg.cmaps) || isempty(cfg.clims)
    % set default cmaps
    cmaps_default = cell(length(weights_cell),1);
    clims_default = zeros(length(weights_cell),2);
    
    for iv = 1:length(weights_cell)
        
        vals = weights_cell{iv};
        
        if isempty(cfg.cmaps)
            if max(vals,[], 'all', 'omitnan') > 0 && min(vals,[],'all', 'omitnan') < 0 % divergent cmap
                cmaps_default{iv} = flipud(cbrewer2('div','RdBu', 64, 'spline'));
            else
                if strcmpi(cfg.pathway, 'outflow')
                    cmaps_default{iv} = cbrewer2('seq','RdPu', 64, 'spline');
                else
                    cmaps_default{iv} = cbrewer2('seq','OrRd', 64, 'spline');
                end
            end
            cfg.cmaps = cmaps_default; clear cmaps_default
        end
        
        if isempty(cfg.clims)
            if max(vals,[], 'all', 'omitnan') > 0 && min(vals,[],'all', 'omitnan') < 0 % divergent cmap
                % clim will consider all timepoints all rec chans
                val_max = max(quantile(abs(vals(vals<0)), cfg.climsPerc(iv,2), 'all'),...
                    quantile(vals(vals>=0), cfg.climsPerc(iv,2), 'all'));
                clims_default(iv,:) = [-1.*val_max, val_max];
            else
                clims_default(iv,:) = [quantile(vals(vals>=0), cfg.climsPerc(iv,1), 'all'), ...
                    quantile(vals(vals>=0), cfg.climsPerc(iv,2), 'all')];
            end
            cfg.clims = clims_default; clear clims_default
        end
    end
end

%% ======================== PLOTTING ========================
tic
disp ('Project all electrodes to the right hemisphere...')

if length(timepoints) > 1
    disp('Plotting weights across brain surface in time....')
end
%============================================================

for it = 1:length(timepoints) % in ms
    timepoint = timepoints(it);
    if isempty(custom_figname)
        figname = sprintf('BrainHeatMap_%s_%dms.jpg', default_text, timepoint);
    else
        figname = custom_figname;
    end
    %     if exist(fullfile(output_folder, figname),'file') == 2 && ~isempty(output_folder)
    %         disp('Plot is already written, will not overwrite.')
    %         continue;
    %     end
    
    hemi = {'right'}; %hemi = {'left', 'right'};
    pers = {'lateral', 'medial', 'ventral'};
    nRow  = length(weights_cell);
    nCol  = length(hemi).*length(pers); % nCol for visual contents
    nColP = 5;%*4-2; % nCol for subplots to iterate through
    % sort display order
    desired_order = {...
        'right-medial1', 'right-lateral1', 'right-ventral1';...
        'right-medial2', 'right-lateral2', 'right-ventral2';...
        'right-medial3', 'right-lateral3', 'right-ventral3'};
    % iter_order = cell(nRow, nCol);
    plot_order = [ ...
        {[1 2]},          { [3 4]},         {[5]};...
        {[1 2]+nColP},    { [3 4]+nColP},   {[5]+nColP};...
        {[1 2]+2*nColP},  { [3 4]+2*nColP}, {[5]+2*nColP}...
        ];
    in = 0;
    N = cell(numel(plot_order),1);
    for iv = 1:3
        for h = 1:length(hemi)
            for ps = 1:length(pers)
                in = in+1;
                [ir,ic] = find(strcmp([hemi{h} '-' pers{ps} num2str(iv)], desired_order));
                N{in} = plot_order{ir,ic};
            end
        end
    end
    
    % ---------------------------------------------------
    
    close; 
    figure('Position', cfg.figPosition);
    
    %figure;
    %[ha, pos] = tight_subplot(nRow,nColP);
    
    n=0;
    for iv = 1:length(weights_cell)
        
        vals = weights_cell{iv}; % sites * timepoints for the ivth type
        cmap_ = cfg.cmaps{iv};
        clim_ = cfg.clims(iv,:);
        
        val = vals(:,it);
        coordinates = coordinates_cell{iv};
        if cfg.isMNIspace == 1
            coordinates(:,1) = abs(coordinates(:,1));
        end
        jplabel_in = jplabel_cell{iv};
        % n=0;figure;
        % save output variables
        coordinatesSurf_cell = cell(size(coordinates_cell));
        coordinatesSurf = nan(size(coordinates));
        
        for h = 1:length(hemi)
            
            hem = hemi{h};
            hemiIdx = 1:size(coordinates,1); % select all
            
            if cfg.isMNIspace == 1
                % this chunk may not be applicable for non-MNI coordinates
                if strcmp(hemi, 'left')
                    hemiIdx = find(coordinates(:,1) < 0);
                    %cmcortex = cmcortexL;
                elseif strcmp(hemi, 'right')
                    hemiIdx = find(coordinates(:,1) >= 0);
                    %cmcortex = cmcortexR;
                end
            end
            %}
            
            electrodes = coordinates(hemiIdx,:);
            if ~isempty(pers_rule)
                JP_list = jplabel_in(hemiIdx,:);
            end
            
            weight     = val(hemiIdx,:);
            weight(isnan(weight) ) = 0;
            %weight = ones(size(weight));
            
            for ps = 1:length(pers)
                
                per = pers{ps};
                %figure('Position', [562   667   711   540])
                n = n + 1;
                subplot(nRow,nColP,N{n})
                % axes(ha(N{n}));
                % figure;
                %
                if cfg.suppress_colorbar == 0 % to show colorbar at then end of each row
                    if ismember([hem '-' per num2str(iv)], desired_order(:,end))
                        show_colorbar = 1;
                    else
                        show_colorbar = 0;
                    end
                else
                    show_colorbar = 0;
                end
                %                    show_colorbar = 0;
                %figure;
                if ~isempty(cfg.climMin) % will overwrite the other clim input
                    if min(clim_) >= 0
                        clim_(1) = cfg.climMin;
                    else
                        warning('Clim minimum bound does not apply for divergent colormap.')
                    end
                end
                
                % sort the explicit electrodes for this perspective
                jpSHOW    = pers_rule.JP_label_std(strcmpi(pers_rule.perspective, per));
                mask = ones(size(weight));
                if ~isempty(pers_rule)
                    mask(~ismember(JP_list, jpSHOW),:) = 0;
                end
                weight_masked  = weight.*mask;
                
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                [elec_surf] = ctmr_gauss_plot3(cmcortex, electrodes, weight_masked, cmap_, hem, per, 1, cfg.gsp, clim_, 1, show_colorbar, cfg.covgAdj);
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
                % save output variable: coorinates projected to the nearest
                % surface
                if cfg.plotNearestSurfaceCord == 0
                    elec_surf = electrodes; % use original coordinates as given by the input
                end
                coordinatesSurf(hemiIdx,:) = elec_surf;
                %======================================================
                if strcmp([hem '-' per num2str(iv)], desired_order{1,1})
                    text(0,100, 70, anot{1}, 'FontSize',cfg.anotFontSize)
                elseif strcmp([hem '-' per num2str(iv)], desired_order{2,1})
                    text(0,100, 70, anot{2}, 'FontSize',cfg.anotFontSize)
                elseif strcmp([hem '-' per num2str(iv)], desired_order{3,1})
                    text(0,100, 70, anot{3}, 'FontSize',cfg.anotFontSize)
                end
                alpha(cfg.brainAlpha)
                
                % sort the explicit electrodes for this perspective
                if ~isempty(pers_rule)
                    elec_surfSHOW  = elec_surf(ismember(JP_list, jpSHOW),:);
                else
                    elec_surfSHOW  = elec_surf;
                end
                
                %% plot individual electrodes
                hold on
                
                % ========================== elec coverage =================
                %p0 = scatter3(electrodes(:,1), electrodes(:,2), electrodes(:,3),  5, ...
                p0 = scatter3(elec_surf(:,1),elec_surf(:,2), elec_surf(:,3),  cfg.recElecDotSize, ...
                    'MarkerEdgeColor', cfg.recElecEdgeColor, 'MarkerFaceColor',cfg.recElecFaceColor);
                %'MarkerEdgeColor', [0.25 0.25 0.25], 'MarkerFaceColor', [0.65 0.65 0.65]);
                p0.MarkerFaceAlpha = cfg.recElec_implicit_FaceAlpha; %.5;
                p0.MarkerEdgeAlpha = cfg.recElec_implicit_EdgeAlpha; %.85;
                %---- make the local electrodes on the correct perspective more
                %transparent ----
                p0_1 = scatter3(elec_surfSHOW(:,1),elec_surfSHOW(:,2), elec_surfSHOW(:,3),  cfg.recElecDotSize, ...
                    'MarkerEdgeColor', cfg.recElecEdgeColor, 'MarkerFaceColor', cfg.recElecFaceColor);
                % 'MarkerEdgeColor', [0.25 0.25 0.25], 'MarkerFaceColor', [0.65 0.65 0.65]);
                p0_1.MarkerFaceAlpha = cfg.recElec_explicit_FaceAlpha;%.7; %.5;
                p0_1.MarkerEdgeAlpha = cfg.recElec_explicit_EdgeAlpha;%.95; %.85;
                
                %=========================== activated elec ===================================
                
                %---> if the ccep_data is ccep_icItp
                % reweights = weights; reweights(reweights<0.0001) = 0;
                % % ---> if the ccep_data is zccep
                
                weightSHOW = weight(ismember(JP_list, jpSHOW),:);
                
                if min(clim_,[],'omitnan') >= 0
                    scp = (max(clim_)- min(clim_)) ./cfg.maxActRadius ;
                    reweight = (weight - min(clim_))/scp + 0.01;
                    act = reweight > 0;
                    reweightSHOW = reweight(ismember(JP_list, jpSHOW),:);
                    actS = reweightSHOW > 0;
                    MarkerColor = cfg.MarkerColor{iv};
                    markercolor = MarkerColor;
                    
                    if ~isempty(find(act, 1))
                        if size(MarkerColor,1) > 1 % colormap
                            markercolor = LinearColorMapping(reweight(act), MarkerColor);
                            %  markercolor = markercolor/256;
                        end
                        if isequal(cfg.ActSize, 'auto')
                            markersize = reweight(act);
                        elseif isequal(cfg.ActSize, 'constant')
                            markersize = mean(reweightSHOW(actS), 'omitnan');
                        elseif isnumeric(cfg.ActSize)
                            markersize = cfg.ActSize;
                        end
                        %'MarkerEdgeColor', markercolor, ...%repmat(litup_color, size(weights,1),1) weights(:,1)] ,...
                        %    'MarkerFaceColor', markercolor, ...
                        p1 = scatter3(elec_surf(act,1), elec_surf(act,2), elec_surf(act,3), markersize,  ...
                            markercolor,'filled',...
                            'AlphaData', reweight(act)/cfg.surfaceAlphaDataDivisor);%[repmat(litup_color, size(weights,1),1) weights(:,1)] );
                        p1.MarkerFaceAlpha = cfg.implicit_FaceAlpha;
                        p1.MarkerEdgeAlpha = cfg.implicit_EdgeAlpha;
                    end
                    %-------
                    if ~isempty(find(actS, 1))
                        if size(MarkerColor,1) > 1 % colormap
                            markercolor = LinearColorMapping(reweightSHOW(actS), MarkerColor);
                            %markercolor = markercolor/256;
                        end
                        if isequal(cfg.ActSize, 'auto')
                            markersize = reweightSHOW(actS);
                        elseif isequal(cfg.ActSize, 'constant')
                            markersize = mean(reweightSHOW(actS), 'omitnan');
                        elseif isnumeric(cfg.ActSize)
                            markersize = cfg.ActSize;
                        end
                        % 'MarkerEdgeColor', markercolor, ...%repmat(litup_color, size(weights,1),1) weights(:,1)] ,...
                        % 'MarkerFaceColor', markercolor, ...
                        p1_1 = scatter3(elec_surfSHOW(actS,1), elec_surfSHOW(actS,2), elec_surfSHOW(actS,3), markersize,  ...
                            markercolor,'filled',...
                            'AlphaData', reweightSHOW(actS)/cfg.surfaceAlphaDataDivisor);%[repmat(litup_color, size(weights,1),1) weights(:,1)] );
                        p1_1.MarkerFaceAlpha = cfg.explicit_FaceAlpha;
                        p1_1.MarkerEdgeAlpha = cfg.explicit_EdgeAlpha;
                    end
                else % divergent colormap
                    
                    scp = clim_(2) ./cfg.maxActRadius ;
                    reweight = abs(weight)/scp + 0.01;
                    reweightSHOW = reweight(ismember(JP_list, jpSHOW),:);
                    MarkerColor = cfg.MarkerColor{iv};
                    
                    MarkerColor_pos = MarkerColor(1,:);
                    MarkerColor_neg = MarkerColor(2,:);
                    
                    p1 = scatter3(elec_surf(weight>=0, 1), elec_surf(weight>=0, 2), elec_surf(weight>=0, 3), reweight(weight>=0),  ...
                        'MarkerEdgeColor', MarkerColor_pos, ...%repmat(litup_color, size(weights,1),1) weights(:,1)] ,...
                        'MarkerFaceColor', MarkerColor_pos);%, ...
                     %   'AlphaData', reweight/cfg.surfaceAlphaDataDivisor);%[repmat(litup_color, size(weights,1),1) weights(:,1)] );
                    p1.MarkerFaceAlpha = cfg.implicit_FaceAlpha;
                    p1.MarkerEdgeAlpha = cfg.implicit_EdgeAlpha;
                    %-----------------------
                    p1_1 = scatter3(elec_surfSHOW(weightSHOW>=0, 1), elec_surfSHOW(weightSHOW>=0, 2), elec_surfSHOW(weightSHOW>=0, 3), reweightSHOW(weightSHOW>=0),  ...
                        'MarkerEdgeColor', MarkerColor_pos, ...%repmat(litup_color, size(weights,1),1) weights(:,1)] ,...
                        'MarkerFaceColor', MarkerColor_pos);%, ...
                       % 'AlphaData', reweightSHOW/cfg.surfaceAlphaDataDivisor);%[repmat(litup_color, size(weights,1),1) weights(:,1)] );
                    p1_1.MarkerFaceAlpha = cfg.explicit_FaceAlpha;
                    p1_1.MarkerEdgeAlpha = cfg.explicit_EdgeAlpha;
                    %=========================================================
                    p2 = scatter3(elec_surf(weight<0, 1), elec_surf(weight<0, 2), elec_surf(weight<0, 3), reweight(weight<0),  ...
                        'MarkerEdgeColor', MarkerColor_neg, ...%repmat(litup_color, size(weights,1),1) weights(:,1)] ,...
                        'MarkerFaceColor', MarkerColor_neg);%, ...
                      %  'AlphaData', reweight/cfg.surfaceAlphaDataDivisor);%[repmat(litup_color, size(weights,1),1) weights(:,1)] );
                    p2.MarkerFaceAlpha = cfg.implicit_FaceAlpha;
                    p2.MarkerEdgeAlpha = cfg.implicit_EdgeAlpha;
                    %-----------------------
                    p2_1 = scatter3(elec_surfSHOW(weightSHOW<0, 1), elec_surfSHOW(weightSHOW<0, 2), elec_surfSHOW(weightSHOW<0, 3), reweightSHOW(weightSHOW<0),  ...
                        'MarkerEdgeColor', MarkerColor_neg, ...%repmat(litup_color, size(weights,1),1) weights(:,1)] ,...
                        'MarkerFaceColor', MarkerColor_neg);%, ...
                        %'AlphaData', reweightSHOW/cfg.surfaceAlphaDataDivisor);%[repmat(litup_color, size(weights,1),1) weights(:,1)] );
                    p2_1.MarkerFaceAlpha = cfg.explicit_FaceAlpha;
                    p2_1.MarkerEdgeAlpha = cfg.explicit_EdgeAlpha;
                    
                end
                %                    reweights(reweights<5) = 0;
                %reweights(reweights>5) = log(reweights(reweights>5));
                if isequal(cfg.titletext, default_text) %|| isempty(cfg.titletext)
                    sgtitle(sprintf('       %s pathway (%d ms)\n   ',cfg.pathway,  timepoint), 'FontSize', cfg.titleFontSize)
                else
                    sgtitle(cfg.titletext, 'FontSize', cfg.titleFontSize)
                end
                hold off
            end
        end
        % save output variable
        coordinatesSurf_cell{iv} = coordinatesSurf;
    end
    
    % save file
   % exportgraphics(gcf,fullfile(output_folder, figname),'Resolution',320)
end
end % for time point

