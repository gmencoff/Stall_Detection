t = 0:0.1:10*pi;
sig1 = sin(t+pi);
sig2 = sin(t);

[dist,a,b] = dtw(sig1,sig2);

euc_orig = norm(sig1-sig2);
euc_warp = norm(sig1(a)-sig2(b));

hold on
subplot(2,1,1)
plot(t,sig1,'-o',t,sig2,'-o')
title(['Original Signals, Distance = ' num2str(euc_orig)],'FontSize',26)

subplot(2,1,2)
plot(1:length(a),sig1(a),'-o',1:length(b),sig2(b),'-o')
title(['Warped Signals, Distance = ' num2str(euc_warp)],'FontSize',26)
