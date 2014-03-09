%##################################################################
% Finds the number of k-neighbors (k links away) for every node
%
% INPUTS: adjacency matrix (nxn), start node index, k - number of links
% OUTPUTS: vector of k-neighbors indices
%
% Updated: For readability.

% IB: last updated, 3/9/14
%##################################################################

function kneigh = kneighbors(adj,ind,k)

adjk = adj;
for i=1:k-1 
    adjk = adjk*adj; 
end;

kneigh = find(adjk(ind,:)>0);