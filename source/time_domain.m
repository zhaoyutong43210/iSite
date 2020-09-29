function time_domain

lam1 = 0.005;
lam2 = (0.01^2)/lam1;

w1 = 1 + 1i*lam1;
w2 = linspace(0.5,1.5,5001)+ 1i*lam2;

%J = 1i*sqrt(lam1*lam2);
J = 0.05;
wp = 1/2*(sqrt(w1.^2 +J) + w2 + sqrt((w1-w2).^2+4*J^2));
wn = 1/2*(w1 + sqrt(w2.^2+J) - sqrt((w1-w2).^2+4*J^2));



t = linspace(0,500,1e6);
% phi1 = exp(-(lam1+lam2).*t/2).*cos(J.*t).*cos(real(w1).*t);
% phi2 = exp(-(lam1+lam2).*t/2).*sin(J.*t).*sin(real(w1).*t);

% phi1 = exp(-(lam1+lam2).*t/2).*(1+exp(i*2*J.*t)).*cos(real(w1).*t)/2;
% phi2 = exp(-(lam1+lam2).*t/2).*(1-exp(i*2*J.*t)).*cos(real(w1).*t)/2;

phi1 = 1/(lam1+lam2).*[lam1+lam2.*exp(-(lam1+lam2).*t)].*cos(real(w1).*t);
phi2 = sqrt(lam1.*lam2)/(lam1+lam2).*[1-exp(-(lam1+lam2).*t)].*cos(real(w1).*t);


decay1 = exp(-(lam1+lam2).*t/2)/2;
decay2 = (1+exp(i*2*J.*t))/2;

subplot(3,2,1)
plot(real(w2),real(wp),'r',real(w2),real(wn),'b')

subplot(3,2,2)
plot(real(w2),imag(wp),'r.',real(w2),imag(wn),'b.')

subplot(3,2,[3,4])
plot(t,phi1,'r');ylim([-1 1])

subplot(3,2,[5,6])
plot(t,phi2,'b');ylim([-1 1])

data1 = [real(w2)',real(wp)',real(wn)'];
data2 = [real(w2)',imag(wp)',imag(wn)'];
data3 = [t',phi1'];
data4 = [t',phi2'];
data5 = [t',decay1',decay2'];

fp=fopen('data1.txt','w');
fprintf(fp,'f\tS21\tD\twr\r\n');
fprintf(fp,'%e\t %e\t %e\t \r\n',data1'); 
fclose(fp);

fp=fopen('data2.txt','w');
fprintf(fp,'f\tS21\tD\twr\r\n');
fprintf(fp,'%e\t %e\t %e\t\r\n',data2'); 
fclose(fp);

fp=fopen('data3.txt','w');
fprintf(fp,'f\tS21\tD\twr\r\n');
fprintf(fp,'%e\t %e\t\r\n',data3'); 
fclose(fp);

fp=fopen('data4.txt','w');
fprintf(fp,'f\tS21\tD\twr\r\n');
fprintf(fp,'%e\t %e\t\r\n',data4'); 
fclose(fp);

fp=fopen('data5.txt','w');
%fprintf(fp,'tt \t decay1\t decay1\t \r\n');
fprintf(fp,'%e\t %e\t %e\t \r\n',data5'); 
fclose(fp);
end