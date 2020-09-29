function Coupling_dispersion_Cal
 close all
w2a = linspace(0.5,1.5,10000)';

dw1 = 0.009;
dw2 = 0.001;
w1 = 1-1i*dw1;
w2 = w2a -1i*dw2;
k = 0.05;

D = real(w2)-real(w1);

wp = ((w1+w2+2*k)+sign(real(w1-w2)).*sqrt((w1-w2).^2+4*k^2))/2;
wn = ((w1+w2+2*k)-sign(real(w1-w2)).*sqrt((w1-w2).^2+4*k^2))/2;







Ev = zeros(4,length(w2));
Ed = zeros(2,length(w2));
for n = 1:length(w2)
    w2n = w2(n);
   M =  [w1+k k; -k w2n+k];
   [V,d] = eig(M);
  % if real(w1) < real(w2n)
   Ev(:,n) = V(:);
   Ed(:,n) = [d(1),d(4)];
   %elseif real(w1) > real(w2n)
%    Ev(:,n) = [V(3),V(4),-V(1),-V(2)];
%    Ed(:,n) = [d(4),d(1)];
  % end
end

subplot(2,2,1); hold on
   plot(D,real(Ed(1,:)),'r--')
   plot(D,real(Ed(2,:)),'b--')

   subplot(2,2,2); hold on
   plot(D,-imag(Ed(1,:))*1e3,'r--')
   plot(D,-imag(Ed(2,:))*1e3,'b--')
   
color1 =  abs(Ev(1,:)./Ev(2,:));
color2 =  -abs(Ev(4,:)./Ev(3,:));

figure('pos',[50 50 800 600])
subplot(2,2,1)
cla


scatter(D,real(wp),10,color1); hold on
scatter(D,real(wn),10,color2); 

plot(D,real(wn)*0+1,'k--','Linewidth',0.5); 
plot(D,real(w2),'k--','Linewidth',0.5); hold off

colormap jet;
ylabel('Re(\omega_\pm) (GHz)')
% xlabel('\omega_s - \omega_c (GHz)')
xlabel('\Delta (GHz)')
%title('Dispersion')
set(gca,'Fontsize',16,'FontName','Times New Roman')
xlim([min(real(w2)-real(w1)) max(real(w2)-real(w1))])

subplot(2,2,2)
cla
% plot(D,-(imag(wp))*1e3,'r.','Linewidth',3); hold on
% plot(D,-(imag(wn))*1e3,'b.','Linewidth',3); 

scatter(D,-(imag(wp))*1e3,10,color1); hold on
scatter(D,-(imag(wn))*1e3,10,color2); 

plot([-0.5,0.5],([dw1,dw1]+1i*k)*1e3,'k--','Linewidth',0.5);
plot([-0.5,0.5],([dw2,dw2]+1i*k)*1e3,'k--','Linewidth',0.5);hold off
%ylim([0 25])
ylabel('Im(\omega_\pm) (MHz)')
%xlabel('\omega_s - \omega_c (GHz)')
xlabel('\Delta (GHz)')
%title('Linewidth')
set(gca,'Fontsize',16,'FontName','Times New Roman')
xlim([min(real(w2)-real(w1)) max(real(w2)-real(w1))])

% Delta = w1-w2;
% ev1 = normalize([2*k+D*0 Delta-sqrt(Delta.^2+4*k^2)]');
% ev2 = normalize([2*k+D*0 Delta+sqrt(Delta.^2+4*k^2)]');
% 
% subplot(2,2,3)
% plot(D,ev1(1,:),'r',D,ev1(2,:),'r--')
% % plot(D,real(ev1(1,:)./ev1(2,:)),'r--'); hold on
% % plot(D,real(ev2(1,:)./ev2(2,:)),'r--')
% subplot(2,2,4)
% plot(D,ev2(1,:),'b',D,ev2(2,:),'b--')
% plot(D,imag(ev1(1,:)./ev1(2,:)),'r--'); hold on
% plot(D,imag(ev2(1,:)./ev2(2,:)),'r--')
   subplot(2,2,3); 
   plot(D,real(Ev(1,:)),'r-','Linewidth',2);hold on
   plot(D,real(Ev(2,:)),'b--','Linewidth',2)
   
    plot(D,imag(Ev(1,:)),'r--','Linewidth',0.5);hold on
   plot(D,imag(Ev(2,:)),'b--','Linewidth',0.5)
   
   
   ylabel('Re(A_{+} B_{+})')
%xlabel('\omega_s - \omega_c (GHz)')
xlabel('\Delta (GHz)')
%title('Linewidth')
set(gca,'Fontsize',16,'FontName','Times New Roman')
xlim([min(real(w2)-real(w1)) max(real(w2)-real(w1))])
ylim([-1.1 1.1])

   subplot(2,2,4); 
   plot(D,real(Ev(3,:)),'r--','Linewidth',2); hold on
   plot(D,real(Ev(4,:)),'b-','Linewidth',2)
   
      plot(D,imag(Ev(3,:)),'r--','Linewidth',0.5); hold on
   plot(D,imag(Ev(4,:)),'b-','Linewidth',0.5)
   
   ylabel('Re(A_{-} ,B_{-})')
%xlabel('\omega_s - \omega_c (GHz)')
xlabel('\Delta (GHz)')
%title('Linewidth')
set(gca,'Fontsize',16,'FontName','Times New Roman')
xlim([min(real(w2)-real(w1)) max(real(w2)-real(w1))])
ylim([-1.1 1.1])
end