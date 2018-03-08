%% compare the single kernel and multikernel,aka mat method and mpng method
function kernelRMSE(rmse)
close all;
%% global variables
compareS = 2;
index = {[1 8 2 ],[3 10 6 11],[4 5 9 12 ]};    % method index,comes from gerMethodName
var_index = [1 2];  %u and v
compare1 = rmse(var_index,index{1});
compare2 = rmse(var_index,index{2});
compare3 = rmse(var_index,index{3});

% x coordinates ,with 2 intervals
x1 = linspace(1,3,size(index{1},2));
x2 = linspace(5,7,size(index{2},2));
x3 = linspace(9,11,size(index{3},2));

%% plot single and kernel comparation figure
figure;
subplot(121)
bar(x1,compare1(1,:));
hold on;
bar(x2,compare2(1,:));
hold on;
bar(x3,compare3(1,:));
text(x1-0.15,compare1(1,:)+0.0035,getMNameByIndex(index{1},compareS),'FontSize', 13);
text(x2-0.15,compare2(1,:)+0.0035,getMNameByIndex(index{2},compareS),'FontSize', 13);
text(x3-0.15,compare3(1,:)+0.0035,getMNameByIndex(index{3},compareS),'FontSize', 13);
ylabel('RMSE');
xlabel('Method');
% grid on;
set(gca,'gridlinestyle','--','xtick',[]);
title('u');

subplot(122)
bar(x1,compare1(2,:));
hold on;
bar(x2,compare2(2,:));
hold on;
bar(x3,compare3(2,:));
text(x1-0.15,compare1(2,:)+0.002,getMNameByIndex(index{1},compareS),'FontSize', 13);
text(x2-0.15,compare2(2,:)+0.002,getMNameByIndex(index{2},compareS),'FontSize', 13);
text(x3-0.15,compare3(2,:)+0.002,getMNameByIndex(index{3},compareS),'FontSize', 13);
title('v');

