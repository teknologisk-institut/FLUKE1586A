function measurements = FlukeRead(t,status)
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

if status==0
    t.writeline('FETCH?')
end

if t.NumBytesAvailable>0
    data = t.readline;
    data = strsplit(data,',');
    measurements=str2double(data);
end
