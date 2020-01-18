load con1
% suppone caricato conc1 : c'è con1 in memoria, è 2500x3

figure(1)
plot(con1(:,1)',con1(:,2)','o')
pause

rand('state',1992)

[a,b]=percett(con1(1:1250,1:2),2*con1(1:1250,3)-1,200);

figure(2)
plot(b,'o')

[z,h]=max(b);
h %indice del primo massimo

W=a(:,h)'; %riga dei pesi ottimale

ris=usaperc(W,con1(1:1250,1:2));

sum(ris==2*con1(1:1250,3)-1) %numero patterns imparati
sum(ris)
ris=usaperc(W,con1(1251:2500,1:2));

sum(ris==2*con1(1251:2500,3)-1) %numero patterns classificati esattamente fra i 1250 mai visti


sum(ris)





