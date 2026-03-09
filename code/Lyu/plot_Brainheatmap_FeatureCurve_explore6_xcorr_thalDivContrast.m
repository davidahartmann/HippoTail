%dl577@stanford.edu; Nov 8 2023
% This code will plot out brainheatmap for xCor/feature curve data
% comparisons between thalamic divisions

clear; close all
home_dir = '/Users/dl577/Seagate-WORK_DL';% getuserdir; %%'/home/dian';

server_root = '/Volumes/neurology_jparvizi$';

addpath(fullfile(home_dir, 'Dropbox/scripts/Stanford/Cohort_Organization'))
addpath(fullfile(home_dir, 'Dropbox/scripts/my_functions'));
addpath(fullfile(home_dir, 'Dropbox/scripts/external'));
addpath(fullfile(home_dir, 'Dropbox/scripts/external/cbrewer2/cbrewer2'))
%addpath(genpath(fullfile(home_dir, 'Dropbox/scripts/external/cbrewer2/cbrewer2')));
addpath(fullfile(home_dir, 'Dropbox/scripts/external/ColorBrewer'));
addpath(fullfile(home_dir, 'Dropbox/scripts/Stanford/lbcn_preproc/visualization'));
addpath(fullfile(home_dir, 'Dropbox/scripts/external/pca_ica'));
addpath(fullfile(home_dir, 'Dropbox/scripts/Stanford/CECS_Pipeline_COPY/CECS_Pipeline/CCEP_pipeline/tools'));
addpath(fullfile(home_dir, 'Dropbox/scripts/JAKE_2/lbcn_preproc/freesurfer'))
addpath(fullfile(home_dir, 'Dropbox/scripts/external/tight_subplot'))
addpath(fullfile(home_dir, 'Dropbox/scripts/Stanford/CECS_Pipeline_COPY/personal_validation'))
addpath(fullfile(home_dir, 'Dropbox/scripts/PlottingTools/pipeline')) % plot_regional_CCEP
addpath(fullfile(home_dir, 'Dropbox/scripts/PlottingTools/Brain_3D')) % plotBrainSurfaceWeight
addpath(genpath(fullfile(home_dir, 'Dropbox/scripts/Stanford/ThalamocoricalLoop-project')))
%  brain surface manipulation tools
toolboxDir = fullfile(home_dir,'Dropbox/scripts/external/surfAnalysis-master');
addpath(genpath(toolboxDir))
addpath(genpath(fullfile(home_dir, 'Dropbox/scripts/external/matlab_GIfTI-master')))
addpath(fullfile(home_dir, 'Dropbox/scripts/external'))
addpath(genpath(fullfile(home_dir, 'Dropbox/scripts/external/brainSurfer-main')))

comp_root = '/data/dian/Working_projects/data';
result_folder = fullfile(home_dir, 'Dropbox/Stanford_Matters/data/THAL/CCEP/results/explore6_xcorr');
prelim_plot_folder = fullfile(home_dir, 'Dropbox/Stanford_Matters/data/THAL/CCEP/Plots/explore6');
%input_folder = fullfile(home_dir, 'Dropbox_backup/Stanford_Matters/data/THAL/CCEP/results/explore5_locked');

fsDir = getenv('SUBJECTS_DIR');
brainDir = fullfile(home_dir, 'Dropbox/scripts/external/brainSurfer-main/brains');
wbDir = fullfile('/Volumes/Lacie', 'workbench');

%% load stimulation metatable

metaT = readtable(fullfile(result_folder, 'table_CCEPnewpipOutput_wholebrain_anatomical_info_activationRedone3.csv'));

%{
sublist = {'S22_178_AF', 'S21_172_KS','S21_166_TM', 'S20_152_HT', 'S21_167_MQ', 'S21_169_BH', 'S21_171_MM',...
    'S19_137_AF', 'S21_165_WN', 'S22_176_LB', 'S22_177_JM', 'S22_182_DH', 'S22_183_CR', ...
    'S22_185_TW', 'S22_188_CB', 'S22_189_LMA', 'S22_190_AS', 'S22_191_KM', 'S22_192_LG', 'S22_193_AM', 'S23_194_PS', 'S23_195_MZ'};%, , 'S22_181_CB'};
%}
sublist = unique(metaT.aSubID)';

%% sort FS_LR standard coordinates (need to be done before)
FSout_coord = nan(size(metaT,1),3);
FSin_coord  = nan(size(metaT,1),3);
m = load(fullfile(wbDir,'affineMsurf2FSLR_group.mat'));

for ss = 1:length(sublist)
    
    asub = sublist(ss);
    sbj = metaT.subject(strcmp(metaT.aSubID, asub));
    sbj = sbj{1}; keys = strsplit(sbj, '_');
    sbj_short = strjoin(keys(1:2),'_');
    
    lepto_cord_out = [metaT.LEPTOout_coord_1(strcmp(metaT.aSubID, asub),:),...
        metaT.LEPTOout_coord_2(strcmp(metaT.aSubID, asub),:),...
        metaT.LEPTOout_coord_3(strcmp(metaT.aSubID, asub),:)];
    
    lepto_cord_in = [metaT.LEPTOin_coord_1(strcmp(metaT.aSubID, asub),:),...
        metaT.LEPTOin_coord_2(strcmp(metaT.aSubID, asub),:),...
        metaT.LEPTOin_coord_3(strcmp(metaT.aSubID, asub),:)];
    % find correct affine matrix to use
    im = find(contains(m.sblist, sbj_short));
    Msurf2space = m.affineMsurf2FSLR_group{im};
    % project to the right hemisphere
    [~,~,sfs_cordsOUT2] = convertLepto2FS_LR0(sbj_short, lepto_cord_out, Msurf2space,  wbDir, brainDir,999); % radius = 999 --> use all surface projectsions
    [~,~,sfs_cordsIN2]  = convertLepto2FS_LR0(sbj_short, lepto_cord_in, Msurf2space,  wbDir, brainDir,999);
    
    FSout_coord(strcmp(metaT.aSubID, asub),:) = sfs_cordsOUT2;
    FSin_coord(strcmp(metaT.aSubID, asub),:) = sfs_cordsIN2;
end
%metaT.FSout_coord = FSout_coord;
%metaT.FSin_coord = FSin_coord;
%writetable(metaT,'table_CCEPnewpipOutput_wholebrain_anatomical_info_activationRedone4.csv');
%%
if ~exist(result_folder, 'dir'); mkdir(result_folder); end
if ~exist(prelim_plot_folder, 'dir'); mkdir(prelim_plot_folder); end
cd(result_folder)


%%   ==================================== PLOT REGION AVERATED CCEP ====================================
tic
%-----------------------------------------
output_folder = fullfile(prelim_plot_folder, 'BrainHeatMap_Feature');
if ~exist(output_folder, 'dir'); mkdir(output_folder); end

%% ==================PREPARE DATA==================
nFs = 1:3;
paths = {'inflow','outflow'};
xHEMIs = {'contralateral','ipsilateral', 'bilateral'};
ROIs = {'antTH', 'midTH', 'pstTH'};

for nF = 1%nFs
    for ip = 1:length(paths)
        pathway = paths{ip};
        for ix = 3%:length(xHEMIs)
            xHEMI = xHEMIs{ix};
            
            if nF < 3
                thr = 0.4;
            else
                thr = 0.5;
            end
            
            featurename = sprintf('peak_maxCor_clst%d',nF);
            % coordinates
            if strcmp(pathway,'outflow') % seed is MNIout
                MNI = [metaT.MNIin_coord_1 metaT.MNIin_coord_2 metaT.MNIin_coord_3]; % target is MNIin
                cords = [metaT.FSin_coord_1 metaT.FSin_coord_2 metaT.FSin_coord_3];%FSin_coord;%
                metaT.seed = metaT.JP_label_out;
                metaT.JP_label = metaT.JP_label_in;
                chantype = 'record_chan';
                CrossBorder = metaT.sCrossBorder;
            elseif strcmp(pathway, 'inflow')
                MNI = [metaT.MNIout_coord_1 metaT.MNIout_coord_2 metaT.MNIout_coord_3];
                cords = [metaT.FSout_coord_1 metaT.FSout_coord_2 metaT.FSout_coord_3];%FSout_coord;%
                metaT.seed = metaT.JP_label_in;
                metaT.JP_label = metaT.JP_label_out;
                chantype = 'stim_chan';
                CrossBorder = metaT.rCrossBorder;
            end
            
            if strcmp(xHEMI, 'ipsilateral')
                boolean_crossHemi = metaT.MNIin_coord_1 .* metaT.MNIout_coord_1 > 0;
            elseif strcmp(xHEMI, 'contralateral')
                boolean_crossHemi = metaT.MNIin_coord_1 .* metaT.MNIout_coord_1 < 0;
            else
                boolean_crossHemi = metaT.MNIin_coord_1 .* metaT.MNIout_coord_1 ~= 0;
            end
            % filter data
            prefilterIdx =  ...
                boolean_crossHemi &... % ipsilateral or contralateral
                metaT.eudDist>5 & ...
                ~isnan(metaT.umapAct) & ...
                ~ismember(metaT.JP_label_in, {'', 'empty', 'NAN', 'NA', 'EXLUCDE'}) & ...
                ~ismember(metaT.JP_label_out, {'', 'empty', 'NAN', 'NA', 'EXCLUDE'}) & ...
                CrossBorder == 0 & ~strcmp(metaT.subject, 'S23_196_HL') ;
            
            boolean_antTH = strcmp(metaT.seed , 'antTH') & prefilterIdx;
            boolean_midTH = strcmp(metaT.seed , 'midTH') & prefilterIdx;
            boolean_pstTH = strcmp(metaT.seed , 'pstTH') & prefilterIdx;
            
            %------------------------------------------------------------
            boolean_ROIs = {boolean_antTH, boolean_midTH, boolean_pstTH};
            AllElec_roi = cellstr(join([string(metaT.aSubID), string(metaT.(chantype))]));
            %------
            weights_cell     = cell(length(boolean_ROIs),1);
            coordinates_cell = cell(length(boolean_ROIs),1);
            jplabel_cell     = cell(length(boolean_ROIs),1);
            %------CustomColormap
            for ir = 1:length(boolean_ROIs)
                idx_throughROI = find(boolean_ROIs{ir});
                % sort out the eleclist to map across the brain
                [eleclist, it] = unique(AllElec_roi(idx_throughROI), 'stable');
                idx = idx_throughROI(it);
                feature_roi = zeros(length(eleclist),1);
                
                for i = 1:length(eleclist)
                    keys = strsplit(eleclist{i}, ' ');
                    asub = keys{1};
                    chan = keys{2};
                    % find the pairs with same stim/rec ROI and rec/stim channels
                    idx_commonROI = intersect(idx_throughROI, find(strcmp(metaT.(chantype), chan) &...
                        strcmp(metaT.aSubID, asub)));
                    feature_vals = metaT.(featurename)(idx_commonROI);
                    % threshold
                    % feature_vals((feature_vals<thr) | (isnan(feature_vals))) = 0;
                    % use max among the elecs of the same ROI
                    feature_roi(i) = (mean(feature_vals,'all', 'omitnan'));
                end
                %threshold
                feature_roi(feature_roi<thr)=0;
                weights_cell{ir} = feature_roi;
                jplabel_cell{ir} = metaT.JP_label(idx);
                coordinates_cell{ir} = cords(idx,:);
            end
            
            % >>>>>>>>> load brain surface data >>>>>>>>>
            % brain surface data
            % prepare surface template of the fs_LR
            fn =  fullfile(brainDir, 'S900.R.midthickness_MSMAll.32k_fs_LR.surf.gii');
            this = gifti(fn);
            cmcortex.vert = this.vertices;
            cmcortex.tri = this.faces;
%             [cmcortex.vert, cmcortex.tri]=read_surf(fullfile(fsDir , 'fsaverage', 'surf',[ 'rh.pial']));
            pers_rule = readtable( fullfile(home_dir, 'Dropbox/Stanford_Matters/data/THAL/COHORT/ELECTRODE_VISUALIZATION_RULE_thal.csv'));
            %clear up workspace to save memory
            
            
            %% plot surface weights
            clear cfg
            
            cfg.brainAlpha         = 0.82;
            cfg.isMNIspace         = 0;
            cfg.suppress_colorbar  = 0;
            cfg.gsp                = 75; % gaussian speading parameter
            %cfg.figPosition        = [201   225   582   610];%[201    85   747   792];
            cfg.maxActRadius       = 200;
            cfg.anotFontSize       = 10;
            cfg.titleFontSize      = 17;
            cfg.titletext          = {[ pathway],''};
            cfg.recElecDotSize     = 20;
            cfg.covgAdj            = 0.5;
            cfg.plotSurfaceCords   = 0; % plot markers at the nearest surface (not original coordinates)
            % cfg.climsPerc          = repmat([0 0.9], 3,1);
            %cfg.climMin            = 0;
            %cfg.explicit_FaceAlpha = 0.7;
            
            switch pathway
                case 'outflow'
                    addshades = [1, 1, 1];
                    %                     cfg.cmaps = cell(3,1);
                    %                     colr = myColors('RdBu'); cfg.cmaps{1} = colr.cm;
                    %                     colr = myColors('RdBr'); cfg.cmaps{2} = colr.cm;
                    %                     colr = myColors('BrBu'); cfg.cmaps{3} = colr.cm;
                    %
                    %                     cfg.MarkerColor = cell(3,1);
                    %                     cfg.MarkerColor{1} =  addshades.*[cfg.cmaps{1}(end,:); cfg.cmaps{1}(1,:)];
                    %                     cfg.MarkerColor{2} =  addshades.*[cfg.cmaps{2}(end,:); cfg.cmaps{2}(1,:)];
                    %                     cfg.MarkerColor{3} =  addshades.*[cfg.cmaps{3}(end,:); cfg.cmaps{3}(1,:)];
                    colr = myColors('redblue2');
                    cfg.cmaps = colr.cm; %flipud(cbrewer2('div','RdBu',128, 'spline'));
                    cfg.MarkerColor = repmat({addshades.*[cfg.cmaps(end-7,:); cfg.cmaps(8,:)]},3,1);
                    anot = {[ROIs{1} ' vs. ' ROIs{3}], [ROIs{1} ' vs. ' ROIs{2}], [ROIs{2} ' vs. ' ROIs{3}]};
                    cmax_scale = 0.85;
                    %litup_colors = [[166,27,41]/256; [255, 203, 1]/256;  [35, 118, 183]/256];% dark red[160, 28, 52],yellow, blue,
                case 'inflow'
                    addshades = [0.8, 0.75, 0.7];
                    
                    %                     cfg.cmaps = cell(3,1);
                    %                     colr = myColors('redblue3'); cfg.cmaps{1} = colr.cm;
                    %                     colr = myColors('redbrown'); cfg.cmaps{2} = colr.cm;
                    %                     colr = myColors('brownblue'); cfg.cmaps{3} = colr.cm;
                    %
                    %                     cfg.MarkerColor = cell(3,1);
                    %                     cfg.MarkerColor{1} =  addshades.*[cfg.cmaps{1}(end,:); cfg.cmaps{1}(1,:)];
                    %                     cfg.MarkerColor{2} =  addshades.*[cfg.cmaps{2}(end,:); cfg.cmaps{2}(1,:)];
                    %                     cfg.MarkerColor{3} =  addshades.*[cfg.cmaps{3}(end,:); cfg.cmaps{3}(1,:)];
                    colr = myColors('redblue3');
                    cfg.cmaps = colr.cm;%flipud(cbrewer2('div','PuOr',128, 'spline'));
                    
                    cfg.MarkerColor = repmat({addshades.*[cfg.cmaps(end,:); cfg.cmaps(1,:)]},3,1);
                    anot = {[ROIs{1} ' vs. ' ROIs{3}], [ROIs{1} ' vs. ' ROIs{2}], [ROIs{2} ' vs. ' ROIs{3}]};
                    cmax_scale = 0.9;
                    %litup_colors = [[207, 72, 19]/256; [255, 203, 1]/256;  [35, 118, 183]/256];% dark red[160, 28, 52],yellow, blue,
            end
            %}
            
            fname = sprintf('BrainHeatmap_thalamusDiv_feature%d_%s_%s_%s_thalDivContrasts_withCbar_RdBuCmap_FSLR2.pdf', nF, pathway, featurename,xHEMI);
            % contast among ant, pst, mid
            c_coordinates_cell = cell(3,1);
            c_weights_cell     = cell(3,1);
            c_jplabel_cell     = cell(3,1);
            for ic = 1:length(anot)
                contrast_btwn = strsplit(anot{ic}, ' vs. ');
                ir1 = find(strcmp(ROIs, contrast_btwn(1)));
                ir2 = find(strcmp(ROIs, contrast_btwn(2)));
                [common_coords, i1,i2] = intersect(coordinates_cell{ir1}, coordinates_cell{ir2}, 'rows');
                c_coordinates_cell{ic} = common_coords;
                c_weights_cell{ic} = weights_cell{ir1}(i1) - weights_cell{ir2}(i2);
                c_jplabel_cell{ic} = jplabel_cell{ir1}(i1);
            end
            
            % decide clims
%             wmax = max([max(c_weights_cell{1}), max(c_weights_cell{2}),max(c_weights_cell{3})]);
%             wmin = min([min(c_weights_cell{1}), min(c_weights_cell{2}),min(c_weights_cell{3})]);
%             smallerlimit = (min(abs([wmin, wmax]))) * cmax_scale;
%             cfg.clims = repmat([-1*smallerlimit  smallerlimit], 3, 1);
            cfg.clims = [-0.7 0.7];
            %--------------------------------------------------------------------------------------------------
            plot_folder = fullfile(output_folder, 'TH_Contrasts');
            if ~exist(plot_folder, 'dir'); mkdir(plot_folder); end
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            plotBrainSurfaceWeight(cmcortex , c_coordinates_cell, c_weights_cell, [], c_jplabel_cell, plot_folder, anot, pers_rule, cfg, fname);
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            print(gcf,fullfile(plot_folder,fname),'-bestfit',"-dpdf", '-r300')
        end
    end
end


