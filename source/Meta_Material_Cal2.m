function Meta_Material_Cal2
close all;

figure('Position',[100 100 1200 250]);

np = 1000001;

fontsize = 16;
k1 = 0.99;
g1 = -0.05;
g2 = 0.0065;
w1 = 2;


subplot(1,3,1)

w = linspace(1,3,np);
S211 = 1 - k1./(1i*(w-w1)+g1+k1);
S212 = 1 - k1./(1i*(w-w1)+k1);
S213 = 1 - k1./(1i*(w-w1)-g1+k1);
S21a = mag2db(abs(S211));
S21b = mag2db(abs(S212));
S21c = mag2db(abs(S213));


plot(w,S21a,'b--',w,S21b,'r--',w,S21c,'g-','Linewidth',2); hold on
%hold on; plot([wZDC1 wZDC1],[-pi pi],'k--',-[ZDC2 ZDC2]+2,[-pi pi],'r--')
ylabel('S_{21} (dB)'); ylim([-100 0])
xlabel('\omega/2\pi (GHz)'); xlim([1,3])
set(gca,'FontSize',fontsize,'FontName','Times New Roman')

subplot(1,3,2)

ang1 = atan2(imag(S211),real(S211));
ang2 = atan2(imag(S212),real(S212));
ang3 = atan2(imag(S213),real(S213));

plot(w,ang1,'b.',w,ang2,'r.',w,ang3,'g.','Linewidth',2); hold on 

ylabel('\angle{S_{21}} (rad)'); 
yticks([-pi 0 pi]);
xlabel('\omega/2\pi (GHz)');xlim([1,3])
ylim([-pi pi])
set(gca,'FontSize',fontsize,'FontName','Times New Roman')


subplot(1,3,3)
w = linspace(-5,20,np);
S211 = 1 - k1./(1i*(w-w1)+g1+k1);
S212 = 1 - k1./(1i*(w-w1)+k1);
S213 = 1 - k1./(1i*(w-w1)-g1+k1);

phi = linspace(0,360,1001);
cir = exp(i*phi/180*pi);
s = plot(real(S211'),imag(S211'),'b--'); hold on
s2 = plot(real(S212'),imag(S212'),'r--');
s3 = plot(real(S213'),imag(S213'),'g');

hold on;plot(real(cir),imag(cir),'k--');
set(s(1),'LineWidth',1);
set(s2,'LineWidth',1);
set(s3,'LineWidth',2);

ylabel('Quadrature (mag)'); ylim([-1,1])
xlabel('In-phase (mag)');xlim([-1,1])
set(gca,'FontSize',fontsize,'FontName','Times New Roman')
grid on
daspect([1 1 1])


end