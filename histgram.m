%%
function histgram(yinput,labelinput)
% figure('Color',[1 1 1]); %灰色的背景忍不了。。。换成和中央一样的白色了
%%
[ycount1,xgroup1] = hist(yinput,10);
[f,xi] = ksdensity(yinput);
% [ycount2,xgroup2]=ecdf(data1);  % 求cdf并返回数据点的函数
[plot_left,h1,h2]=plotyy(xgroup1,ycount1,xi,f,'bar','plot');  %plotyy的使用
set(gca,'xlim',[40,120]);
% plot(xi,f);
% set(plot_left(2),'ylabel','density');
xlabel(labelinput);
ylabel('counts');
set(h1,'barwidth',1);
set(h1,'edgecolor',[125,125,125]/255);
ylabel(plot_left(2),'density');
box off;
