%% compare the non-pca and pca method
function variableRMSE(rmse)
%% global variables
close all;
compareS = 2;
index = {[],[2 6 5] [8 10 9] [11 12] };    % method index,comes from gerMethodName
var_index = [1 2];  %u and v
compare1 = rmse(var_index,index{1});
compare2 = rmse(var_index,index{2});
compare3 = rmse(var_index,index{3});
compare4 = rmse(var_index,index{4});

% x coordinates ,with 2 intervals
x1 = linspace(1,3,size(compare1,2));
x2 = linspace(5,7,size(compare2,2));
x3 = linspace(9,11,size(compare3,2));
x4 = linspace(13,14,size(compare4,2));

%% plot single and kernel comparation figure
figure;
subplot(121)
bar(x1,compare1(1,:));
hold on;
bar(x2,compare2(1,:));
hold on;
bar(x3,compare3(1,:));
hold on;
bar(x4,compare4(1,:));
text(x1-0.3,compare1(1,:)+0.0005,getMNameByIndex(index{1},compareS),'FontSize', 13);
text(x2-0.3,compare2(1,:)+0.0005,getMNameByIndex(index{2},compareS),'FontSize', 13);
text(x3-0.3,compare3(1,:)+0.0005,getMNameByIndex(index{3},compareS),'FontSize', 13);
text(x4-0.3,compare4(1,:)+0.0005,getMNameByIndex(index{4},compareS),'FontSize', 13);
ylabel('RMSE');
xlabel('Method');
% grid on;
set(gca,'gridlinestyle','--','xtick',[]);
h = annotation('textbox',[0.15 0.87 0.02 0.03],...
    'String',{'(a)'},...
    'FitBoxToText','off');
h.LineStyle = 'none';
set(h,'FontSize',16);

subplot(122)
bar(x1,compare1(2,:));
hold on;
bar(x2,compare2(2,:));
hold on;
bar(x3,compare3(2,:));
hold on;
bar(x4,compare4(2,:));
text(x1-0.3,compare1(2,:)+0.005,getMNameByIndex(index{1},compareS),'FontSize', 13);
text(x2-0.3,compare2(2,:)+0.005,getMNameByIndex(index{2},compareS),'FontSize', 13);
text(x3-0.3,compare3(2,:)+0.005,getMNameByIndex(index{3},compareS),'FontSize', 13);
text(x4-0.3,compare4(1,:)+0.005,getMNameByIndex(index{4},compareS),'FontSize', 13);
ylabel('RMSE');
xlabel('Method');
% grid on;
set(gca,'gridlinestyle','--','xtick',[]);
h = annotation('textbox',[0.59 0.87 0.02 0.03],...
    'String',{'(b)'},...
    'FitBoxToText','off');
h.LineStyle = 'none';
set(h,'FontSize',16);
