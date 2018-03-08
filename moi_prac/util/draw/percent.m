%% compare the non-pca and pca method
function percent(rmse)
%% global variables
close all;
compare1 = [6.18 21.31];    %u for space interpolation
compare2 = [14.49 15.05];    %v for space interpolation
compare3 = [4.97 10.55];    %u for time interpolation
compare4 = [21.44 25.13];    %v for time interpolation

% x coordinates ,with 2 intervals
x1 = linspace(1,3,size(compare1,2));
x2 = linspace(6,8,size(compare2,2));

%% plot single and kernel comparation figure
figure1 = figure;
subplot1 = subplot(1,2,1,'Parent',figure1,'GridLineStyle','--',...
    'FontSize',36,...
    'XTick',[]);
box(subplot1,'on');
hold(subplot1,'on');

% subplot(1,2,1, 'FontSize',14)
bar(x1,compare1);
hold on;
bar(x2,compare2);

xx1 = [0.544236760124611,2.03021806853583];
xx2 = [5.55981308411215,7.03021806853583];

% text(x1-0.3,compare1+1.75,{'k_{v}','k_{vms}'},'FontSize', 48);
% text(x2-0.3,compare2+1.75,{'k_{v}','k_{vms}'},'FontSize', 48);
text(xx1,compare1+1.75,{'k_{v}','k_{vms}'},'FontSize', 48);
text(xx2,compare2+1.75,{'k_{v}','k_{vms}'},'FontSize', 48);
ylabel('RMSE Percentage','FontSize',36);

% grid on;
set(gca,'gridlinestyle','--','xtick',[]);
h = annotation('textbox',[0.15 0.87 0.02 0.03],...
    'String',{'(a)'},...
    'FitBoxToText','off');
h.LineStyle = 'none';
set(h,'FontSize',36);


subplot2 = subplot(1,2,2,'Parent',figure1,'GridLineStyle','--',...
    'FontSize',36,...
    'XTick',[]);
box(subplot2,'on');
hold(subplot2,'on');
bar(x1,compare3);
hold on;
bar(x2,compare4);

xx1 = [0.528926905132193,2.01570762052877];
xx2 = [5.52892690513219,7.01570762052877];

% text(x1-0.3,compare3+2,{'k_{v}','k_{vms}'},'FontSize', 48);
% text(x2-0.3,compare4+2,{'k_{v}','k_{vms}'},'FontSize', 48);
text(xx1,compare3+2,{'k_{v}','k_{vms}'},'FontSize', 48);
text(xx2,compare4+2,{'k_{v}','k_{vms}'},'FontSize', 48);
ylabel('RMSE Percentage','FontSize',36);

% grid on;
set(gca,'gridlinestyle','--','xtick',[]);
h = annotation('textbox',[0.59 0.87 0.02 0.03],...
    'String',{'(b)'},...
    'FitBoxToText','off');
h.LineStyle = 'none';
set(h,'FontSize',36);

annotation('textbox',...
    [0.352708333333333 0.07 0.02 0.03],...
    'String',{'v'},...
    'LineStyle','none',...
    'FontSize',48);

% Create textbox
annotation('textbox',...
    [0.183458333333333 0.07 0.02 0.03],...
    'String',{'u'},...
    'LineStyle','none',...
    'FontSize',48);

% Create textbox
annotation('textbox',...
    [0.626458333333333 0.07 0.02 0.03],...
    'String',{'u'},...
    'LineStyle','none',...
    'FontSize',48);

% Create textbox
annotation('textbox',...
    [0.794270833333333 0.07 0.02 0.03],...
    'String',{'v'},...
    'LineStyle','none',...
    'FontSize',48);
