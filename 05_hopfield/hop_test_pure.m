
function [s, count, M]=hop_test_pure(W,x)

% function [s, count, M]=hop_test_pure(W,x)
%
%   s - output state vector
%   count - number of cycles until stable state is reached
%   M - matrix containing the intermediate network states
%   W - weight matrix
%   x - probe vector
%   
% Hugh Pasika 1997

% initialize a few variables
[r c]=size(x);   s_prev=x(:);  N=r*c;  count=0; M=zeros(120,1);

% the upper limit in the loop is arbitrary (you'll never reach it)
while count < 1000,
    ind=1; clear ch;

  % store the network state
    count=count+1;
    M(:,count)=s_prev;

  % ch vector will declare which neurons want to change
    for j=1:120,
        nv(j)=sign(sum(W(j,:)'.*s_prev));
        if nv(j)~=0 && abs(nv(j)-s_prev(j)) > 0, ch(ind)=j; ind=ind+1; end;
    end


  % now, do any neurons want to change? if no, break out of the loop 
    if ind==1, break; end
  % update one neuron
    r_ind=ceil(rand(1)*length(ch));  % select one neuron for updating
    s_prev(ch(r_ind))=s_prev(ch(r_ind))*(-1);    % update it

end

% storage of stable state
M(:,count)=s_prev; 
s=reshape(s_prev,r,c);
