function ODE_time_domain_mapping_fft
%close all;
% dissipative coupling 
w1 = 10;
w2 = 10;
Fonts = 14;
w2a = [9.7 9.9 10 10.1 10.3];
tic
time =5e2;
r = [0,1,0,0]; % initial condition [o1_speed, o1_position, o2_speed , o2_position]

% tspan=[0 time];
% opts=odeset('RelTol',1e-12,'AbsTol',1e-12);
% [t,x] =ode45(eqnM(w1,w2),tspan,r,opts);
% eqnM == dissipative coupling 
% eqnM2 == coherent coupling 


%%
% subplot(4,2,[1,2]);cla
% plot(t,x(:,2),'r-',t,x(:,4),'b-'); xlabel('t');ylabel('x');grid on
% title('oscillation response')
% xlabel('t(s)')
% ylabel('Oscillation (t)')
% xlim(tspan)
% ylim([-1 1])
% set(gca,'FontSize',Fonts,'FontName','Times New Roman')

%% 
subplot(4,2,[1,3]);cla
w2 = linspace(9.5,10.5,1001);
w1t = w1 + 0.01i;
w2t = w2 + 0.01i;

%G = 0.05; % Coherent coupling
G = 0.05i/2;    % Disspative coupling


wp =1/2*(w1t+w2t +2*G + sqrt((w1t-w2t).^2+4*G^2));
wn =1/2*(w1t+w2t +2*G - sqrt((w1t-w2t).^2+4*G^2));

plot(real(wn),real(w2),'-',real(wp),real(w2),'-','Linewidth',3); hold on 
plot([min(real(w2)) max(real(w2))],[w2a' w2a'],'k--')
title('Eigenfrequencies')

ylabel('\omega_2 (Hz)');xlabel('\omega (Hz)')
set(gca,'FontSize',Fonts,'FontName','Times New Roman')

%%

resultC = [];
resultM = [];
tit = linspace(0,time,10001);
w2a =(9.5:0.01:10.5);

for w2 = w2a
    
tspan=[0 time];
opts=odeset('RelTol',1e-12,'AbsTol',1e-12);
[t,x] =ode45(eqnM(w1,w2),tspan,r,opts);


tint = linspace(0,time,3e6);
xint = interp1(t,x(:,4),tint,'spline');
xint2 = interp1(t,x(:,2),tint,'spline');
       
T = abs(tint(2)-tint(1)); % Sampling period   
Fs = 2*pi/T;            % Sampling frequency             
L = length(tint);             % Length of signal
ti = (0:L-1)*T;        % Time vector

Y = fft(xint);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

Y2 = fft(xint2);
P22 = abs(Y2/L);
P12 = P22(1:L/2+1);
P12(2:end-1) = 2*P12(2:end-1);

f = Fs*(0:(L/2))/L;

subplot(4,2,5);cla
plot(tint,xint2,'r',tint,xint,'b');xlim([0 200])
set(gca,'FontSize',Fonts,'FontName','Times New Roman')

subplot(4,2,7);cla
plot(f,P1./max(P1),'b',f,P12./max(P12),'r'); xlim([8 12])
set(gca,'FontSize',Fonts,'FontName','Times New Roman')

 resultC = [resultC,P1'];
 resultM = [resultM,P12'];
xlabel(num2str(w2))
drawnow

end

subplot(4,2,[2,4]);cla
imagesc(f,w2a,(resultC'));xlim([9 11]); axis xy; caxis([0 0.1]); colormap hot
set(gca,'FontSize',Fonts,'FontName','Times New Roman')

subplot(4,2,[6,8]);cla
imagesc(f,w2a,(resultM'));xlim([9 11]); axis xy; caxis([0 0.1]);colormap hot
set(gca,'FontSize',Fonts,'FontName','Times New Roman')
end

function f=eqnM(w1,w2)
Gamma = 0.05; 
lambda1 = 0.01;
lambda2 = 0.01;
f=@(t,x) [x(2);
          -w1^2*x(1) - lambda1*x(2) - 2*Gamma*(x(2)-x(4));
          x(4);
          -w2^2*x(3) - lambda2*x(4) + 2*Gamma*(x(2)-x(4));
          ];
end

function f=eqnM2(w1,w2)
J = 0.05*w1*2; 
lambda1 = 0.01;
lambda2 = 0.01;
f=@(t,x) [x(2);
          -w1^2*x(1) - lambda1*x(2) - J*(x(1)-x(3));
          x(4);
          -w2^2*x(3) - lambda2*x(4) + J*(x(1)-x(3));
          ];
end

function f=eqnM3(w1,w2)
Gamma = 0.5/2; 
lambda1 = 0.01;
lambda2 = 0.01;
f=@(t,x) [x(2);
          -w1^2*x(1) - lambda1*x(2) - 2*Gamma*(x(3));
          x(4);
          -w2^2*x(3) - lambda2*x(4) + 2*Gamma*(x(1));
          ];
end

