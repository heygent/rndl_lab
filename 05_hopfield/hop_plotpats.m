function hop_plotpats(P)

% function hop_plotpats(P)
%
% routine plots the digits for the Hopfield network, the patterns
% are contained in the file hop_data.mat
%
% Hugh Pasika 1997

names = ['zero'; 'one'; 'two'; 'three'; 'four'; 'six'; 'nine'; 'block'];

for i=1:8,
   subplot(3,3,i);
   hop_plotdig(P(:,i),12,10);
   xlabel(names(i, :))
end
 
endfunction