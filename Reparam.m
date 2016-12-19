% Embedding using Anisotropic Diffusion 
% *************************************************
% Phi - the embedding of the reference points.
% Psi - the extended embedding of the entire set.
%
% By Ronen Talmon (20.3.2012)
% *************************************************

%% Configuration
ep =  size(c, 2) *15e-4; % kernel scale chosen empirically

data = c;
subidx = 1:2:M; % subset of reference points
dataref = c(subidx,:);
m = size(dataref, 1);
D = size(dataref, 2);

%% Compute the Mahalanobis distance
Dis = zeros(M, m);
h = waitbar(0, 'Computing distance');
for i = 1:M
    waitbar(i/M, h);
    for j = 1:m
         Dis(i,j) = [data(i,:) - dataref(j,:)] * inv_Cc(:,:,subidx(j)) * [data(i,:) - dataref(j,:)]';
    end
end
close(h);

%% Build anisotropic kernel
A = exp(-Dis/(4*ep));

% normalize twice to handle nonuniform density 
W_sml=A'*A;    
d1=sum(W_sml,1);
A1=A./repmat(sqrt(d1),M,1);
W1=A1'*A1;

d2=sum(W1,1);
A2=A1./repmat(sqrt(d2),M,1);
W2=A2'*A2;

%% Compute eigenvectors
[V,Vals] = eigs(W2,4);

[srtdVals,IVals] = sort(sum(Vals),'descend');

% embedding of the reference points
DD=diag(sqrt(1./d2));
Phi = DD*V(:,IVals(1,[2,3,4]));

%% Extension
Psi=[];

omega=sum(A2,2);
A2_nrm=A2./repmat(omega,1,m);

for i=1:size(Phi,2)
    psi=A2_nrm*Phi(:,i)./sqrt((srtdVals(i+1)));
    Psi=[Psi,psi]; % embedding of the entire set
end

