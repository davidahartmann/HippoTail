function out = loadColorMap(pal)
    addpath('/home/dian/scripts/my_functions')
    % assuming the name of the text/mat file is the name of the pallete,
    % the text/mat contains a data matrix (0<rgb<1) with n rows and 3 columns
    colorpath = '/home/dian/scripts/PlottingTools/ColorVec';
    c = dir(fullfile(colorpath, [pal, '*']));
    if isempty(c)
        disp('No given pallete name is found in:')
        disp(colorpath)
        out = [];
        return
    end

    cname = c(1).name;
    cfn = fullfile(c(1).folder, cname);
    if strcmp(cname(end-2:end), 'mat')
       cdata = load(cfn);
    elseif strcmp(cname(end-2:end), 'txt')
        cdata = readmatrix(cfn);
    end
    out = myColors(pal, cdata);
end