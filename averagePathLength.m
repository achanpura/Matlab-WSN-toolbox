%##################################################################
% Compute average path length for a network - the average shortest path
% Note: works for directed/undirected networks 
%
% INPUTS: adjacency (or weights/distances) matrix, nxn
% OUTPUTS: average path length, optional matrix of pairwise path lengths.
%
% Other routines used: simpleDijkstra.m 

% updated: Handled case where nodes are unreachable t.f. value goes to Inf.

% IB: Last updated, 3/8/14
%##################################################################

function [l, d_back]  = averagePathLength(adj)

n=size(adj,1);

d = zeros(n);

for i=1:n 
    d(:, i) = simpleDijkstra(adj, i);
end
d_back = d;
d = d(:);
d = d(d ~= Inf & d ~= 0); % not unreachable and not self
l = nanmean(d); % sum and average across everything but the diagonal