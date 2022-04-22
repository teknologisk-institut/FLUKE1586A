function [instruments, address,port]=FlukeReadSetupFile(setupPath)
%FlukeReadSetup reads the setup file and creates required arrays for the initialization of the instrument
%
% SYNOPSIS: [channels,func]=FlukeReadSetup(setupPath)
%
% INPUT setupPath is the path to the setup.txt-file, containing the information for the instrument	
%
% OUTPUT channels is an array consisting of the different channels used on the FLUKE 1586 DMM
%			func is a string array consisting of the different functions used on the FLUKE 1586 DMM
%			The two lists must be in the same order.                                                 
%
% REMARKS
%
% created with MATLAB ver.: 9.10.0.1602886 (R2021a) on Microsoft Windows 10 Enterprise Version 10.0 (Build 19042)
%
% created by: PEO
% DATE: 07-Apr-2022
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% setupPath = "C:\Users\peo\Documents\GitHub\FLUKE1586A\";
setupFile = "setup.txt";

location = strcat(setupPath,setupFile);

setupFile = fopen(location,'r');
setup = fscanf(setupFile,'%c'); % read data as characters
setupLines=strsplit(setup,'\r\n'); % split file into lines
flukeStart = strfind(setupLines,'%% FLUKE 1586A %%'); % find beginning of FLUKE setup

for i=1:size(flukeStart,2) 
    if ~isempty(flukeStart{i})
        startLine=i+1;
        break
    end
end

% make one array with channels and one with functions
for i=startLine:startLine+6
    try
        setupSplit = strsplit(setupLines{i},':');
        field = strtrim(setupSplit{1});
        data = strtrim(strsplit(setupSplit{2},','));
        if strfind(field,'channels')
            channels = str2double(data);
        elseif strfind(field,'measurands')
            func = data;
        elseif strfind(field, 'instrument ids')
            id = data;
        elseif strfind(field, 'address')
            address = char(data);
        elseif strfind(field, 'port')
            port = str2double(data);
        end
    catch
    end
end

% make sure the channels are in right order
[~,idx] = sort(channels);
channels = string(channels(idx));
func = upper(func(idx));
id = id(idx);
instruments = [channels;func;id];