%##################################################################
% Compute the average degree of neighboring nodes for every vertex.
% Note: Works for weighted degrees (graphs) also.
%
% INPUTs: adjacency matrix, nxn
% OUTPUTs: average neighbor degree vector, 1xn
%
% Other routines used: degrees.m, kneighbors.m

% Updated : Changed for function name consistency

% IB: last updated, 3/9/14
%##################################################################

function av=averageNeighborDegree(adj)

av=zeros(1,length(adj));   % initialize output vector
[deg,~,~]=degrees(adj);

for i=1:length(adj)  % across all nodes
  
  neigh=kneighbors(adj,i,1);  % neighbors of i, one link away
  if isempty(neigh)
      av(i)=0; 
      continue; 
  end
  av(i)=sum(deg(neigh))/deg(i);
  
end