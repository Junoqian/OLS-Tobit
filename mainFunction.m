level = 6;
censored_level = [0.05, 0.15, 0.25, 0.35, 0.45, 0.5];

length_x = 1000;
Gaussian = randn(1,length_x);
RepTrials = 1000;

x = zeros(length_x,RepTrials); % 每一列 = 1000个数据点
y = zeros(length_x,RepTrials);
% y_c = zeros(length_x,RepTrials);


for i = 1:RepTrials
    %% y 模拟
    sdy = 15; my = 80; % cutpoint = 100;
    y_raw = Gaussian' * sdy + my; % 注意是列
    y(:,i) = y_raw + randn(length(y_raw),1);
    %% x 模拟
    sdx = 10; mx = 40;
    x_raw = Gaussian' * sdx + mx;
    x(:,i) = x_raw + randn(length(x_raw),1)*10;
    
end
%% y 截尾
% y_c = y;
% y_c(y_c > cutpoint) = cutpoint;
y_c = data_cut(y,censored_level(level));
csvwrite('datamat_x6.csv',x);
csvwrite('datamat_Ry6.csv',y);
csvwrite('datamat_Cy6.csv',y_c);
% 
% %% 显示x 和 y 的分布
% no = 1:length_x;
% figure('Color',[1 1 1]);
% subplot(3,2,1)
% plot(no,x,'o','MarkerEdgeColor',[0,150,150]/255);
% ylabel('x score');
% box off
% subplot(3,2,2)
% plot(no,y,'bo','MarkerEdgeColor',[240,120,0]/255);
% ylabel('y score');
% box off
% %% Estimated by OLS
% % y = x * beta + e, e -> Gaussian
% p = polyfit(x,y,1);
% % f1 = polyval()
% subplot(3,2,4)
% % 这一段本来是回归的
% % plot(x,y,'o');
% hold on
% % y1 = polyval(p,x);
% % plot(x,y1)
% % csvwrite('datamat.csv',[x',y']);
% %%
% plot(no,y,'o');
% 
% % p = polyfit(x,y,1);
% % plot(x,y,'o');
% % y1 = polyval(p,x);
% % plot(x,y1);
% % box off;
% % xlabel('x score');
% % ylabel('Math Exam Score');
% plot(no,y_c,'o');
% ylabel('Y score censored')
% csvwrite('datamat_C.csv',[x',y_c']);
% box off
% %%
% subplot(3,2,3);
% plot(x,y,'o');
% hold on
% plot(x,y_c,'o');
% xlim([0,120]);
% box off
% xlabel('X score');
% ylabel('Y score');
% %%
% subplot(3,2,5)
% Xlabel = 'Y distribution'
% histgram(y,Xlabel);
% 
% subplot(3,2,6)
% Xlabel = 'Y distribution censored'
% histgram(y_c,Xlabel);