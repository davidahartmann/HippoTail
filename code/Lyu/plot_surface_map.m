function plot_surface_map(cfg, coords, weights, titleStr, outStem)
%PLOT_SURFACE_MAP Density-adjusted Gaussian projection + coverage dots.

if ~isfolder(cfg.outDir)
    mkdir(cfg.outDir);
end

[coords, weights] = sanitize_inputs(coords, weights);
if isempty(coords)
    for i = 1:numel(cfg.views)
        save_placeholder(cfg, [outStem '_' cfg.views{i}], [titleStr ' (' cfg.views{i} ')'], 'No valid electrodes for this contrast');
    end
    save_placeholder(cfg, [outStem '_montage'], titleStr, 'No valid electrodes for this contrast');
    return;
end

if cfg.foldToOneHemisphere
    coords(:,1) = abs(coords(:,1));
end

cortex = load_surface(cfg.surfRPath, cfg.displayMeshFraction);
coordsSurf = project_to_surface(cortex.vert, coords);
[surfMap, coverage] = build_density_adjusted_map(cortex.vert, coordsSurf, weights, cfg.gaussSigma, cfg.coverageNormPower, cfg.coverageCovgAdj);
cmap = redblue_cmap(256);

if ~isfield(cfg, 'onlyMontagePNG') || ~cfg.onlyMontagePNG
    for i = 1:numel(cfg.views)
        fig = figure('Visible', 'off', 'Color', 'w', 'Position', [120, 120, 920, 840]);
        render_single(gca, cortex, surfMap, coverage, coordsSurf, cfg, cmap, cfg.views{i});
        title(sprintf('%s | %s | n=%d', titleStr, cfg.views{i}, numel(weights)), 'Interpreter', 'none');
        save_figure_pair(fig, [outStem '_' cfg.views{i}], cfg.figDPI, false);
        close(fig);
    end
end

fig = figure('Visible', 'off', 'Color', 'w', 'Position', [80, 80, 1900, 760]);
for i = 1:numel(cfg.views)
    ax = subplot(1, numel(cfg.views), i);
    render_single(ax, cortex, surfMap, coverage, coordsSurf, cfg, cmap, cfg.views{i});
    title(cfg.views{i}, 'Interpreter', 'none');
end
suptitle_safe(sprintf('%s | n=%d', titleStr, numel(weights)));
save_figure_pair(fig, [outStem '_montage'], cfg.figDPI, true);
close(fig);
end

function render_single(ax, cortex, surfMap, coverage, coordsSurf, cfg, cmap, viewName)
axes(ax);
hold(ax, 'on');

patch(ax, 'Faces', cortex.tri, 'Vertices', cortex.vert, ...
    'FaceColor', [0.92 0.92 0.92], 'EdgeColor', 'none', ...
    'FaceAlpha', 0.10, 'SpecularStrength', 0.0);

covN = coverage;
if any(covN > 0)
    covN = covN ./ max(covN);
end
magN = min(1, abs(surfMap) ./ max(abs(cfg.colLim)));
alphaV = min(0.98, 0.08 + 0.90 .* (magN.^0.55) .* (0.35 + 0.65 .* covN.^0.5));

patch(ax, 'Faces', cortex.tri, 'Vertices', cortex.vert, ...
    'FaceVertexCData', surfMap, 'FaceColor', 'interp', 'EdgeColor', 'none', ...
    'FaceVertexAlphaData', alphaV, 'FaceAlpha', 'interp');

if ~isempty(coordsSurf)
    s = scatter3(ax, coordsSurf(:,1), coordsSurf(:,2), coordsSurf(:,3), ...
        cfg.coverageDotSize, repmat(cfg.coverageDotColor, size(coordsSurf,1),1), ...
        'filled', 'MarkerEdgeColor', [0.35 0.35 0.35], 'LineWidth', 0.2);
    try
        s.MarkerFaceAlpha = cfg.coverageDotAlpha;
        s.MarkerEdgeAlpha = cfg.coverageDotAlpha * 0.8;
    catch
    end
end

colormap(ax, cmap);
caxis(ax, cfg.colLim);
cb = colorbar(ax);
cb.Color = [0.2 0.2 0.2];
cb.FontSize = 9;
cb.Ticks = [-0.70 -0.35 0 0.35 0.70];

axis(ax, 'equal');
axis(ax, 'off');
material(ax, 'dull');
camlight(ax, 'headlight');
lighting(ax, 'gouraud');
camzoom(ax, 1.3);

set_view(ax, viewName, cfg);
hold(ax, 'off');
end

function set_view(ax, viewName, cfg)
switch lower(viewName)
    case 'medial'
        if isfield(cfg, 'viewMedial')
            view(ax, cfg.viewMedial(1), cfg.viewMedial(2));
        else
            view(ax, 270, 0);
        end
        camup(ax, [0 0 1]);
    case 'lateral'
        if isfield(cfg, 'viewLateral')
            view(ax, cfg.viewLateral(1), cfg.viewLateral(2));
        else
            view(ax, 90, 25);
        end
        camup(ax, [0 0 1]);
    case 'ventral'
        if isfield(cfg, 'viewVentral')
            view(ax, cfg.viewVentral(1), cfg.viewVentral(2));
        else
            view(ax, 180, 270);
        end
        camup(ax, [0 1 0]);
    otherwise
        view(ax, 90, 20);
        camup(ax, [0 0 1]);
end
end

function [map, covg] = build_density_adjusted_map(verts, coords, weights, sigma, normPower, covgAdj)
if nargin < 5 || isempty(normPower)
    normPower = 1.0;
end
if nargin < 6 || isempty(covgAdj)
    covgAdj = 0.5;
end

nV = size(verts,1);
mapNum = zeros(nV,1);
covg = zeros(nV,1);

for i = 1:size(coords,1)
    dv = verts - coords(i,:);
    d2 = sum(dv.^2, 2);
    k = exp(-d2 ./ sigma);
    covg = covg + k;
    mapNum = mapNum + weights(i) .* k;
end

den = sqrt(covg.^2 + 1) .* max(eps, covgAdj);
if normPower ~= 1
    den = den .^ normPower;
end
den(den < eps) = eps;
map = mapNum ./ den;
end

function coordsSurf = project_to_surface(verts, coords)
coordsSurf = nan(size(coords));
for i = 1:size(coords,1)
    dv = verts - coords(i,:);
    [~, ix] = min(sum(dv.^2,2));
    coordsSurf(i,:) = verts(ix,:);
end
end

function [coords, weights] = sanitize_inputs(coords, weights)
weights = weights(:);
if isempty(coords) || isempty(weights)
    coords = zeros(0,3);
    weights = zeros(0,1);
    return;
end
if size(coords,2) ~= 3 || size(coords,1) ~= numel(weights)
    error('coords must be Nx3 and match weights length.');
end
ok = all(isfinite(coords),2) & isfinite(weights);
coords = coords(ok,:);
weights = weights(ok);
end

function cortex = load_surface(giiPath, meshFraction)
if ~isfile(giiPath)
    error('Surface file not found: %s', giiPath);
end
g = gifti(giiPath);
v = g.vertices;
f = g.faces;
if nargin >= 2 && meshFraction < 1
    [f, v] = reducepatch(f, v, meshFraction);
end
cortex = struct('vert', v, 'tri', f);
end

function cmap = redblue_cmap(n)
if nargin < 1
    n = 256;
end
pivot = [0.0 0.0 0.55; 0.75 0.85 1.0; 1 1 1; 1.0 0.82 0.75; 0.6 0.0 0.0];
% Stronger red/blue endpoints to match paper-like visibility.
pivot = [0.07 0.10 0.72; 0.56 0.74 0.97; 1 1 1; 0.98 0.70 0.63; 0.83 0.14 0.10];
xp = linspace(0,1,size(pivot,1));
x = linspace(0,1,n);
cmap = [interp1(xp, pivot(:,1), x, 'pchip')', ...
        interp1(xp, pivot(:,2), x, 'pchip')', ...
        interp1(xp, pivot(:,3), x, 'pchip')'];
cmap = max(0, min(1, cmap));
end

function save_figure_pair(fig, stem, dpi, isMontage)
set(fig, 'PaperPositionMode', 'auto');
print(fig, [stem '.png'], '-dpng', ['-r' num2str(dpi)]);
if nargin < 4
    isMontage = false;
end
if ~isMontage
    print(fig, [stem '.eps'], '-depsc', ['-r' num2str(dpi)]);
end
end

function save_placeholder(cfg, stem, titleStr, msg)
fig = figure('Visible', 'off', 'Color', 'w', 'Position', [120, 120, 860, 820]);
axis off;
text(0.5, 0.5, msg, 'HorizontalAlignment', 'center', 'FontSize', 12);
title(titleStr, 'Interpreter', 'none');
save_figure_pair(fig, stem, cfg.figDPI, false);
close(fig);
end

function suptitle_safe(txt)
if exist('sgtitle', 'file') == 2
    sgtitle(txt, 'Interpreter', 'none');
else
    annotation('textbox', [0 0.95 1 0.05], 'String', txt, ...
        'EdgeColor', 'none', 'HorizontalAlignment', 'center', ...
        'Interpreter', 'none', 'FontWeight', 'bold');
end
end
