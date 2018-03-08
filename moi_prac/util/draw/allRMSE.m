function allRMSE(rmse,start_index,end_size,startInd)  %start_index = 1 for all
% compareS = 2;

size_epoch = size(rmse,2);

% method_size = size(rmse{1},2);
method_size = end_size - startInd+1;
x = linspace(1,method_size,method_size);



%% draw
figure
subplot(121)
% bar(x,r_u);
plotu = [];
for i = start_index:size_epoch
    r_u = rmse{i}(1,startInd:end_size);
    plotu(i) = plot(x,r_u,'-d','LineWidth',1.5);
    if(i < size_epoch)
        hold on;
    end
end
%     text(x-0.5,r_u,getMNameByIndex(x,compareS));
legend(plotu,'reg1','reg2','reg3');
ylabel('RMSE');
xlabel('Method Index');
grid on;
set(gca,'gridlinestyle','--');
h = annotation('textbox',[0.15 0.87 0.02 0.03],...
    'String',{'(a)'},...
    'FitBoxToText','off');
h.LineStyle = 'none';
set(h,'FontSize',16);
% {'mult','MS','MP','VMP','VMS','Spline'}
set(gca,'xtick',[1 2 3 4 5 6]);

subplot(122)
 plotv = [];
for i = start_index:size_epoch
    r_v = rmse{i}(2,startInd:end_size);
    plotv(i) = plot(x,r_v,'-d','LineWidth',1.5);
    if(i < size_epoch)
        hold on;
    end
end
legend(plotv,'reg1','reg2','reg3');
ylabel('RMSE');
xlabel('Method Index');
grid on;
set(gca,'gridlinestyle','--');
% title('v','fontsize',20);
% dim = [0.2 0.8 0.05 0.8];
% str = '(b)';
h = annotation('textbox',[0.59 0.87 0.02 0.03],...
    'String',{'(b)'},...
    'FitBoxToText','off');
h.LineStyle = 'none';
set(h,'FontSize',16);
set(gca,'xtick',[1 2 3 4 5 6]);



