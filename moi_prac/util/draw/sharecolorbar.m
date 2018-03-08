% sharing colorbar

function [fig_position,colorbar_position] = sharecolorbar(top_margin,btm_margin,left_margin,right_margin,subfig_margin,row,col)

% top_margin = 0.03;  
% btm_margin = 0.03;
% left_margin = 0.03;
% right_margin = 0.15;
% 
% subfig_margin = subfig_margin;  %margin between subfigures

% row = 2;
% col = 2;



% calculate figure height and width according to rows and cols

fig_h = (1-top_margin-btm_margin-(row-1) * subfig_margin)/row;
fig_w = (1-left_margin-right_margin-(col-1) * subfig_margin)/col;
p_index = 1;    % index  of the subfigure
for i = 1:row
    for j = 1:col
        % 
        position = [left_margin+(j-1)*(subfig_margin+fig_w),...
            1-(top_margin+i*fig_h + (i-1)*subfig_margin),...
            fig_w,fig_h];
        
        fig_position{p_index} = position;
        
        p_index = p_index + 1;
    end
end

% colorbar_position = [1-right_margin-subfig_margin, btm_margin,0.2,1-(top_margin+btm_margin)];
colorbar_position = [ btm_margin,1-right_margin-subfig_margin,0.5,1-(top_margin+btm_margin)];



