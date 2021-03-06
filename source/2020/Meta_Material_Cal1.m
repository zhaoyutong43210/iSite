function Meta_Material_Cal1
close all;

fh = figure('Position',[100 100 1200 500]);
FMR = [linspace(1,1.8,501),linspace(1.8,2.4,8001),linspace(2.4,3,201)];
np = 1000001;

fontsize = 16;
k1 = 0.99;
g1 = 0.01;
g2 = 0.0065;
w1 = 2;

J = -0.06;
G = 0.06;
k2 = G^2/k1;

g = J + 1i*sqrt(k1*k2);

ZDC1 = (-(-g1+g2+k2)*G*J + (g1+g2+k2)*sqrt((J^2+g1*(g2+k2))*(G^2-g1*(g2+k2))))/(g1*(g2+k2));
ZDC2 = (-(-g1+g2+k2)*G*J - (g1+g2+k2)*sqrt((J^2+g1*(g2+k2))*(G^2-g1*(g2+k2))))/(g1*(g2+k2));
wZDC1 = w1 + (-J*G+sqrt((J^2+g1*(g2+k2))*(G^2-g1*(g2+k2))))/(g2+k2);
wZDC2 = w1 + (-J*G-sqrt((J^2+g1*(g2+k2))*(G^2-g1*(g2+k2))))/(g2+k2);
wp = 1/2.*(w1+1i.*g1+FMR+1i*(g2+k2)+sqrt((w1+1i.*g1-FMR-1i*(g2+k2)).^2+4*g.^2));
wn = 1/2.*(w1+1i.*g1+FMR+1i*(g2+k2)-sqrt((w1+1i.*g1-FMR-1i*(g2+k2)).^2+4*g.^2));

ZDC1 = 0.2;
ZDC2 = -0.2;
FMR2 = linspace(1.5,2.5,3);
FMR2 = [1.5 2-ZDC1 2 2-ZDC2 2.5];


subplot(2,3,1)
a1 = plot(FMR,real(wp),'r.',FMR,real(wn),'r.',[FMR2;FMR2],[1 3],'k--',2-ZDC1,wZDC2,'ro',2-ZDC2,wZDC1,'bo');
set(a1(1:2),'Linewidth',2)
ylabel('Re(\omega_\pm)/2\pi (GHz)'); ylim([1,3])
xlabel('\omega_2/2\pi (GHz)'); xlim([1,3])
set(gca,'FontSize',fontsize,'FontName','Times New Roman')
subplot(2,3,4)
a2 = plot(FMR,imag(wp).*1e3,'b.',FMR,imag(wn).*1e3,'b.',[FMR2;FMR2],[-0.1,0.1].*1e3,'k--');
set(a2(1:2),'Linewidth',2);
ylabel('Im(\omega_\pm)/2\pi (mHz)'); %ylim([-0.1,0.1])
xlabel('\omega_2/2\pi (GHz)'); xlim([1,3])

set(gca,'FontSize',fontsize,'FontName','Times New Roman')

subplot(2,3,[2 5]); cla
for n1 = 1:length(FMR2)
    
w2 = FMR2(n1);
w = linspace(1,3,np);
S21 = 1 - k1./(1i*(w-w1)+g1+k1+g.^2./(1i*(w-w2)+g2+k2));
S21a = mag2db(abs(S21));


plot(w,S21a - (n1-1)*30,'-','Linewidth',2); hold on
%hold on; plot([wZDC1 wZDC1],[-pi pi],'k--',-[ZDC2 ZDC2]+2,[-pi pi],'r--')
ylabel('S_{21} (dB)'); ylim([-(length(FMR2)-1)*30-100 0])
xlabel('\omega/2\pi (GHz)'); xlim([1,3])
set(gca,'FontSize',fontsize,'FontName','Times New Roman')
end

subplot(2,3,[3 6]); cla
w = linspace(1,3,np);
for  n2 = 1:length(FMR2)
 
w2 = FMR2(n2);

S21 = 1 - k1./(1i*(w-w1)+g1+k1+g.^2./(1i*(w-w2)+g2+k2));

ang = atan2(imag(S21),real(S21));

plot(w,ang - (n2-1)*2*pi,'.','Linewidth',2); hold on 

ylabel('\angle{S_{21}} (rad)'); 
%yticks([-pi 0 pi]);
xlabel('\omega/2\pi (GHz)');xlim([1,3])
%ylim([-pi pi])
set(gca,'FontSize',fontsize,'FontName','Times New Roman')

end

color_order = split(['#0072BD',' #D95319',' #EDB120',' #7E2F8E',' #77AC30']);
w = linspace(-5,20,np);
for  n3 = 1:length(FMR2)
 figure('Position',[100 100 350*0.8 300*0.8]);
w2 = FMR2(n3);
S21 = 1 - k1./(1i*(w-w1)+g1+k1+g.^2./(1i*(w-w2)+g2+k2));

phi = linspace(0,360,1001);
cir = exp(i*phi/180*pi);
s = plot(real(S21'),imag(S21'),'Color',string(color_order{n3}));
hold on;plot(real(cir),imag(cir),'k--');
% s.GridLineStyle = '--';
 set(s(1),'LineWidth',2);
% s.ColorOrder = [0.6350 0.0780 0.1840];
ylabel('Quadrature (mag)'); ylim([-1,1])
xlabel('In-phase (mag)');xlim([-1,1])
set(gca,'FontSize',fontsize,'FontName','Times New Roman')
grid on
daspect([1 1 1])

end


end