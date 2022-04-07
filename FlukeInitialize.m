function [t,make,model,SN] = FlukeInitialize(Address,Port)
%FlukeInitialize initializes a connection to a FLUKE 1586A DMM
%
% SYNOPSIS: t = FlukeInitialize(Address,Port)
%
% INPUT Address is the IP-address of the instrument
%		Port is the port used for the instrument     
%
% OUTPUT t is the handle for the instrument object
%
% REMARKS
%
% created with MATLAB ver.: 9.10.0.1602886 (R2021a) on Microsoft Windows 10 Enterprise Version 10.0 (Build 19042)
%
% created by: PEO
% DATE: 06-Apr-2022
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% make a connection to the instrument
t = tcpclient(Address,Port);

% configure the terminator for the instrument
t.configureTerminator("CR/LF");

    
% check the connection
t.writeline('*IDN?')
i=0;
while true
    if t.NumBytesAvailable>0
        responseCode = 1;
        responseText = t.readline;
        break
    elseif i==10
        responseCode = -1;
    else
        pause(1);
        i=i+1;
    end
end
if responseCode==-1
    disp('No connection to the instrument')
    return
elseif responseCode==1
    responseArray=split(responseText,',');
    make=responseArray(1);
    model=responseArray(2);
    SN=responseArray(3);
end

    
