%%
function histgram(yinput,labelinput)
% figure('Color',[1 1 1]); %��ɫ�ı����̲��ˡ��������ɺ�����һ���İ�ɫ��
%%
[ycount1,xgroup1] = hist(yinput,10);
[f,xi] = ksdensity(yinput);
% [ycount2,xgroup2]=ecdf(data1);  % ��cdf���������ݵ�ĺ���
[plot_left,h1,h2]=plotyy(xgroup1,ycount1,xi,f,'bar','plot');  %plotyy��ʹ��
set(gca,'xlim',[40,120]);
% plot(xi,f);
% set(plot_left(2),'ylabel','density');
xlabel(labelinput);
ylabel('counts');
set(h1,'barwidth',1);
set(h1,'edgecolor',[125,125,125]/255);
ylabel(plot_left(2),'density');
box off;
