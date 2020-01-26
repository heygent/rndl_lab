load con1
% suppone caricato con1 : c'è con1 in memoria, size: 2500x3

% prima prova
% il problema è difficile, pongo nhid = 4, eta = 1, errmax = .01

% parametri passati a retropro: Inp,Targ,nhid,Eta,Err,Nmax,seme
[A,B,R,err,c]=retropro(con1(:,1:2),con1(:,3),4,1,.01,100,1992);

% calcolo errore
[d,p]=comparer(round(R),con1(:,3));

V=round(R);

figure(1)
hold on
for i=1:2500
   if V(i)>0
      plot(con1(i,1),con1(i,2),'or')
   else
       
      plot(con1(i,1),con1(i,2),'ob')
   end
end
hold off

% aumento il numero di neuroni nascosti a 20, abbasso err a 0.005   ,nhid,Eta,Err,Nmax,seme
[A,B,R,err,c]=retropro(con1(:,1:2),con1(:,3),20,0.4,.005,250,1992);
% la situazione è molto migliorata

% hint: [A,B,R,err,c]=retropro(con1(:,1:2),con1(:,3),35,0.3,.0001,250,1992); 

[d,p]=comparer(round(R),con1(:,3));

V=round(R);

figure(2)
hold on
for i=1:2500
   if V(i)>0
      plot(con1(i,1),con1(i,2),'or')
   else
       
      plot(con1(i,1),con1(i,2),'ob')
   end
end
hold off
