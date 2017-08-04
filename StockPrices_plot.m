% Conclusion of this analysis
% When a stock moves up, it is likely to move up again (same for down)
% The list of stocks, in inc. order of signal strength, is:
%	CPG 14
%	NSQ 13
%	CAS 12
%	MTI 12
%	TIM 10
%	EPSX 9
%	KRONADAX 9
%	ZWF 9
%	EEX 8
%	USSREX 7
%
% As short sales is not permitted, then only up-trends can be benefited from.
% Hence a good strategy would be to go long in stability of


fn='StockPrices.txt';

d=csvread(fn);
d(d==0)=NaN;
st={'CAS','CPG','EEX','EPSX','KRONADAX','NSQ','TIM','USSREX','ZWF','MTI'};
d=reshape(d(:,4),[10,30]);

n=numel(st);

figure
for i=1:numel(st)
subplot(5,2,i);
plot(d(i,:),'-x');
title(st{i});
end

% Indicator
figure
for i=1:numel(st)
subplot(5,2,i);
plot(sign(diff(d(i,:))),'-x')
title(st{i});
end

[x i]=sort(sum(diff(sign(diff(d,1,2)),1,2)==0,2),'descend'); % stock with largest number is easiest to make money

for j=1:n, disp(sprintf('%s %i',st{i(j)},x(j))), end

