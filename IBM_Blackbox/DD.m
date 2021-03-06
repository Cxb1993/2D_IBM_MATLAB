%-------------------------------------------------------------------------------------------------------------------%
%
% IB2d is an Immersed Boundary Code (IB) for solving fully coupled non-linear 
% 	fluid-structure interaction models. This version of the code is based off of
%	Peskin's Immersed Boundary Method Paper in Acta Numerica, 2002.
%
% Author: Nicholas A. Battista
% Email:  nick.battista@unc.edu
% Date Created: May 27th, 2015
% Institution: UNC-CH
%
% This code is capable of creating Lagrangian Structures using:
% 	1. Springs
% 	2. Beams (*torsional springs)
% 	3. Target Points
%	4. Muscle-Model (combined Force-Length-Velocity model, "HIll+(Length-Tension)")
%
% One is able to update those Lagrangian Structure parameters, e.g., spring constants, resting %%	lengths, etc
% 
% There are a number of built in Examples, mostly used for teaching purposes. 
% 
% If you would like us %to add a specific muscle model, please let Nick (nick.battista@unc.edu) know.
%
%--------------------------------------------------------------------------------------------------------------------%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% FUNCTION: Finds CENTERED finite difference approximation to 2ND
% DERIVATIVE in z direction, specified by input and 'string' 
% Note: It automatically accounts for periodicity of the domain.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function u_zz = DD(u,dz,string)

% u:      velocity 
% dz:     spatial step in "z"-direction
% string: specifies which 2ND derivative to take (to enforce periodicity)

len = length(u(:,1));

if strcmp(string,'x')

    %For periodicity on ends
    u_zz(:,1) =  ( u(:,2) - 2*u(:,1)   + u(:,len) )   / (dz^2);
    u_zz(:,len)= ( u(:,1) - 2*u(:,len) + u(:,len-1) ) / (dz^2);

    %Standard Upwind Scheme (Centered Difference)
    for j=2:len-1
        u_zz(:,j) = ( u(:,j+1) - 2*u(:,j) + u(:,j-1) ) / (dz^2);
    end

elseif strcmp(string,'y')

    %For periodicity on ends
    u_zz(1,:) =  ( u(2,:) - 2*u(1,:)   + u(len,:) )   / (dz^2);
    u_zz(len,:)= ( u(1,:) - 2*u(len,:) + u(len-1,:) ) / (dz^2);

    %Standard Upwind Scheme (Centered Difference)
    for j=2:len-1
        u_zz(j,:) = ( u(j+1,:) - 2*u(j,:) + u(j-1,:) ) / (dz^2);
    end

else
    
    fprintf('\n\n\n ERROR IN FUNCTION DD FOR COMPUTING 2ND DERIVATIVE\n');
    fprintf('Need to specify which desired derivative, x or y.\n\n\n');  
    
end

