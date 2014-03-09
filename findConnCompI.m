%##################################################################
% Find the connected component to which node "i" belongs to
%
% INPUTS: adjacency matrix and index of the key node
% OUTPUTS: all node indices of the nodes in the same group 
%          to which "i" belongs to (including "i")
%
% Note: Only works for undirected graphs.
% Other functions used: kneighbors.m

% Update: minor optimizations

% IB: last updated, 3/9/14
%##################################################################


function comp=findConnCompI(adj,i)

neigh1=(kneighbors(adj,i,1))';   % all neighbors of "i" 1 link away
neigh1=unique([neigh1;  i]);    % add i to its own component

while 1
    len0=length(neigh1);    
    neigh2 = cell(len0, 1);
    for j=1:len0
        neigh2{j}=(kneighbors(adj,neigh1(j),1))';        
    end
    neigh1=unique([neigh1; cell2mat(neigh2)]);   % merge neigh1 and neigh2
    if len0==length(neigh1)  % if no new neighbors found, return component
        comp=neigh1;
        return
    end
    
end

end  % end of function