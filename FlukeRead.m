function [flukeTable] = FlukeRead(t,flukeTable)
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
timestamp = datetime(now,'ConvertFrom','datenum');
if minutes(timestamp-flukeTable.Time(end))<10
    try
        t.writeline('STAT:OPER?') % query the operation status
        status = dec2bin(double(t.readline));
        t.flush
        if length(status)>4 && status(end-4)=='1'
            t.writeline('DATA:READ?')
            pause(0.05);
            measurements = str2double(strsplit(t.readline,','));
            dataFileTemp = array2timetable(measurements(:)','RowTimes',timestamp);
            dataFileTemp.Properties.VariableNames=flukeTable.Properties.VariableNames; %% solve something here
            flukeTable = [flukeTable;dataFileTemp];
        end
    catch
        disp("wrong output from instrument");
    end
else
    flukeAddress = t.Address;
    flukePort = t.Port;
    clear t
    [t,~,~,~] = FlukeInitialize(flukeAddress,flukePort);
    [~,~] = FlukeSetupInstrument(t,flukeInstruments);
%     flukeTable=flukeTable;
end

