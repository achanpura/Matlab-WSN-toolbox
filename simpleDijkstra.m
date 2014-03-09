%##################################################################
% Implementation of a simple version of the Dijkstra shortest path algorithm
% Returns the distances from a single vertex to all others, doesn't save the path
%
% INPUTS: adjacency matrix, adj (nxn), start node s (index between 1 and n)
% OUTPUTS: shortest path length from the start node to all other nodes, 1xn
%
% Note: Works for a weighted/directed graph.

% Updated 3/8/14: increased efficency 10x by unrolling for loop, removing
% setdiff.

% IB: Last updated, 3/4/14
%##################################################################

function d = simpleDijkstra(adj,s)

n=length(adj);
d = inf*ones(1,n); % distance s-all nodes
d(s) = 0;    % s-s distance
T = 1:n;    % node set with shortest paths not found yet

while not(isempty(T))
    [~,ind] = min(d(T));
    
    idx_update = find(adj(T(ind), T) > 0 & d(T) > d(T(ind)) + adj(T(ind), T));
    if(~isempty(idx_update))
        d(T(idx_update)) = d(T(ind)) + adj(T(ind), T(idx_update));
    end    
    T(ind) = [];
end