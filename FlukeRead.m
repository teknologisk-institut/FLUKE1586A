function [measurements,flukeDataFile,newData] = FlukeRead(t,flukeDataFile,instruments)
%FlukeRead reads the latest measurement from FLUKE 1586A DMM
%
% SYNOPSIS: measurements = FlukeRead(instrument)
%
% INPUT t is the handle for the DMM instrument
%
% OUTPUT measurement is an array of the measurements, one field for each measure
%
% REMARKS
%
% created with MATLAB ver.: 9.10.0.1602886 (R2021a) on Microsoft Windows 10 Enterprise Version 10.0 (Build 19042)
%
% created by: PEO
% DATE: 06-Apr-2022
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


t.writeline('STAT:OPER?') % query the operation status
status = dec2bin(double(t.readline));
t.flush
if length(status)>4 && status(end-4)=='1'
    t.writeline('DATA:READ?')
    measurements = str2double(strsplit(t.readline,','));
    timestamp = datetime(now,'ConvertFrom','datenum');
    dataFileTemp = array2timetable(measurements(:)','RowTimes',timestamp);
    dataFileTemp.Properties.VariableNames=instruments(3,:); %% solve something here
    flukeDataFile = [flukeDataFile;dataFileTemp];
    newData=1;
else
    measurements = [];
    newData=0;
end


