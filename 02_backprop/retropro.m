function [A,B,R,err,c]=retropro(Inp,Targ,nhid,Eta,Err,Nmax,seme);

[N,n]=size(Inp);
[N1,z]=size(Targ);

if N~=N1 
fprintf('Dimensionamento non corretto\n\n');
% break;
end

%Inizializzazione random dei pesi
rand('state',seme);
A=2*(rand(nhid,n)-0.5*ones(nhid,n));
B=2*(rand(z,nhid)-0.5*ones(z,nhid));

Inp=Inp';
Targ=Targ';
Nd=N*z;
err=[];

c=0;
ciclo=0;

while ciclo==0
    R=f(B*f(A*Inp));
	q=ones(1,z)*((R-Targ).^2)*ones(N,1)/Nd;
        err=[err q];

	if q<=Err | c>=Nmax
		ciclo=1;
	end
	
	if ciclo==0
		c=c+1;
		for k=1:N
			%
			% Modifica di A e B.
			%
			Yhid=f(A*Inp(:,k));
			Out=f(B*Yhid);
			DOut=(Targ(:,k)-Out).*Out.*(1-Out);
			E=DOut'*B;
            B=B+DOut*Yhid';
			DYhid=Eta*E'.*Yhid.*(1-Yhid);
			A=A+DYhid*Inp(:,k)';
			%
		end
	end
end
R=R';
