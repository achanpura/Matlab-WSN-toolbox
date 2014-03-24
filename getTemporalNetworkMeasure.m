function [ ret, implemented_str ] = getTemporalNetworkMeasure( dyn_net, measure )
%GETTEMPORALNETWORKMEASURE Compute a network measure over a sequence of adjacency matrices
%   This is a meta/calling function for usability. Given a sequence of adjacency matrices [NxNxT], compute the network measure/feature at each time step.

%   This method is optimized for speed, so the time 'for' loop is on the
%   interior and replicated several times. This saves on a strcmp each
%   iteration. A 'helper' output is written to show currently implemented methods.

%   @input dyn_net, a [NxNxT] sequence of adjacency matrices over T time steps.
%   @input measure, a string specifying the network measure to compute
%   @output ret, a T-length vector of network measures
%   @output implemented_str [optional], a cell array of implemented method strings, for ease of method selection (e.g. to loop over all features)

[~,~,s] = size(dyn_net);

%% preallocate
ret = zeros(s, 1); 

%% keep track of implemented methods for helper output
implemented_str = sort({'max component', 'num components', 'average degree', 'average path', 'clustering coeff', 'density', 'radius', 'diameter', 'transitivity', 'clique number'})';

%% logic for measures
if(exist('measure', 'var')) %if measure given
    if(strcmpi(measure, 'max component'))
        if(~matlabpool('size'))
            for i=1:s
                [~, ret(i)] = connectedComponentMeasures( dyn_net(:,:, i) );
            end
        else
            parfor i=1:s
                [~, ret(i)] = connectedComponentMeasures( dyn_net(:,:, i) );
            end
            
        end
    elseif(strcmpi(measure, 'num components'))
        if(~matlabpool('size'))
            for i=1:s
                [ret(i), ~] = connectedComponentMeasures(dyn_net(:,:, i));
            end
        else
            parfor i=1:s
                [ret(i), ~] = connectedComponentMeasures(dyn_net(:,:, i));
            end
            
        end
    elseif(strcmpi(measure, 'clique number'))
        if(~matlabpool('size'))
            for i=1:s
                [ret(i), ~] = cliqueNumber(dyn_net(:,:, i));
            end
        else
            parfor i=1:s
                [ret(i), ~] = cliqueNumber(dyn_net(:,:, i));
            end
            
        end   
    elseif(strcmpi(measure, 'average degree'))
        if(~matlabpool('size'))
            for i=1:s
                ret(i) = averageDegree(dyn_net(:,:, i));
            end
        else
            parfor i=1:s
                ret(i) = averageDegree(dyn_net(:,:, i));
            end
            
        end
       
    elseif(strcmpi(measure, 'average path'))
        if(~matlabpool('size'))
            for i=1:s
                ret(i) = averagePathLength(dyn_net(:,:, i));
            end
        else
            parfor i=1:s
                ret(i) = averagePathLength(dyn_net(:,:, i));
            end
            
        end
      
    
    elseif(strcmpi(measure, 'clustering coeff'))
        if(~matlabpool('size'))
            for i=1:s
                [~, ret(i), ~] = clustCoeff(dyn_net(:,:,i));
            end
        else
            parfor i=1:s
                [~, ret(i), ~] = clustCoeff(dyn_net(:,:,i));
            end
            
        end
    elseif(strcmpi(measure, 'transitivity'))
        if(~matlabpool('size'))
            for i=1:s
                [ret(i), ~, ~] = clustCoeff(dyn_net(:,:,i));
            end
        else
            parfor i=1:s
                [ret(i), ~, ~] = clustCoeff(dyn_net(:,:,i));
            end
            
        end        
    elseif(strcmpi(measure, 'density'))
        if(~matlabpool('size'))
            for i=1:s
                ret(i) = edgeDensity(dyn_net(:,:,i));
            end
        else
            parfor i=1:s
                ret(i) = edgeDensity(dyn_net(:,:,i));
            end
            
        end    
    elseif(strcmpi(measure, 'radius'))
        if(~matlabpool('size'))
            for i=1:s
                [ret(i), ~] = radiusAndDiameter(dyn_net(:,:,i));
            end
        else
            parfor i=1:s
                [ret(i), ~] = radiusAndDiameter(dyn_net(:,:,i));
            end
            
        end    
    elseif(strcmpi(measure, 'diameter'))
        if(~matlabpool('size'))
            for i=1:s
                [~, ret(i)] = radiusAndDiameter(dyn_net(:,:,i));
            end
        else
            parfor i=1:s
                [~, ret(i)] = radiusAndDiameter(dyn_net(:,:,i));
            end
            
        end            
        
    else
        fprintf(['String ' measure ' not valid, implemented methods:\n' strjoin(implemented_str, '\n') '\n']);
    end      

        
else %if measure not given
    fprintf(['No network measure given, implemented methods:\n' strjoin(implemented_str, '\n') '\n']);
end


end

