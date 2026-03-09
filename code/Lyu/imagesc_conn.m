function imagesc_conn(dat, Areas, ttltext, binaryMask, cmap, lims, backgroundCol )
if nargin<4 || isempty(binaryMask)
    nThre=10;
    binaryMask = cov>nThre;
end
if nargin<5 || isempty(cmap)
    cmap = myColors('dawn') ;
    cmap = cmap.cm;
end
if nargin < 6 || isempty(lims)
    lims = [0,1];
end
if nargin<7 || isempty(backgroundCol)
    backgroundCol = [0.7 0.7 0.7];
end
   
nA = length(Areas);
close();
figure('Position', [508   656   850   750]);
hold on
fill([0.5 nA+0.5 nA+0.5 0.5],[0.5 0.5 nA+0.5 nA+0.5], ...
    backgroundCol , 'EdgeColor', 'none'); 
set(gca, 'XTickLabel',[],'XTick',[],'YTickLabel',[],'YTick',[])
xlim([0.5, nA+0.5])
ylim([0.5, nA+0.5])

% dark grey blocks for <10 pair insitances 
%[nr, nc] = find(cov<nThre );
%for i = 1:length(nr)
%    rectangle('Position',[nr(i)-0.5,nc(i)-0.5,1.,1.],'FaceColor',[.7 .7 .7],'EdgeColor',[.7 .7 .7])
%end

% plot heatmap
imagesc(dat,'AlphaData', binaryMask); 
cbar = colorbar; 
ylabel(cbar,'pearson correlation','FontSize',11,'Rotation',270)
cbar.Label.VerticalAlignment = "bottom";
%cbar.Position = cbar.Position .* [1.01 1 1 0.9];

colormap(cmap)
%colormap(brewermap([],"YlOrRd"))
%colormap
caxis(lims)
xlabel('To'); ylabel('From')
title(ttltext)
set(gca, ...
    'XTick', 1:nA, 'XTickLabel', Areas,...
    'YTick', 1:nA, 'YTickLabel', Areas,...
    'YDir','reverse')
    
% add xline and yline
yline(nA/2 + 0.5, 'w', 'LineWidth',1.8)
xline(nA/2 + 0.5, 'w', 'LineWidth',1.8)
hold off

