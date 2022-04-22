function flukeTable = FlukeCreateTable(instruments)
%FlukeCreateTable initializes the timetable, storing the measurement data
%
% SYNOPSIS: flukeTable = FlukeCreateTable(setupFile)
%
% INPUT setupFile contains the path for the file "setup.txt", containing the settings for the instruments.
%
% OUTPUT flukeTable is a timetable, containing the measurement data from the FLUKE 1586A DMM
%
% REMARKS
%
% created with MATLAB ver.: 9.10.0.1602886 (R2021a) on Microsoft Windows 10 Enterprise Version 10.0 (Build 19042)
%
% created by: PEO
% DATE: 07-Apr-2022
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

initialArray = zeros(1,size(instruments,2));

flukeTable=array2timetable(initialArray,'RowTimes',datetime(now,'ConvertFrom','datenum'));
flukeTable.Properties.VariableNames=instruments(3,:);