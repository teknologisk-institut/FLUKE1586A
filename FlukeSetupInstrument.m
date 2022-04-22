function [channels, func] = FlukeSetupInstrument(t,instruments)
%FlukeSetup defines the measurement routine of the FLUKE 1586A DMM
%
% SYNOPSIS: [channels, func] = FlukeSetup(channels, func)
%
% INPUT t is the handle to the instrument
%       channels contains an array of the channels to be setup
%		func contains an array of the different measurement types to be measured	  
%
% OUTPUT output should equal input
%
% REMARKS
%
% created with MATLAB ver.: 9.10.0.1602886 (R2021a) on Microsoft Windows 10 Enterprise Version 10.0 (Build 19042)
%
% created by: PEO
% DATE: 07-Apr-2022
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% check if input parameters are of correct class (channels must be either string array or char, func must be string array)

%%
t.writeline('*RST') % reset setup of instrument
t.writeline('MEM:LOG:CLE') % erase all scan data files in internal memory
scanLine="ROUT:SCAN (@"; % initialise command for scan route
for i=1:size(instruments,2) % setup individual channels
    setupLine=strcat('CONF:',instruments(2,i),' (@',instruments(1,i),')');
    t.writeline(setupLine) % send informatino regarding channel func
    scanLine=strcat(scanLine,instruments(1,i),',');
end

% send information regarding scan route
scanLine=char(scanLine);
scanLine=scanLine(1:end-1);
scanLine=strcat(scanLine,')');
t.writeline(scanLine);

% check that configuration and scan route are as intended
t.writeline('CONF?');
func = strsplit(t.readline,',');
t.writeline('ROUT:SCAN?')
channels=strsplit(t.readline,',');

t.writeline('TRIG:COUN 0') % set the trigger count to infinity
t.writeline('INIT') % initiate the scan
