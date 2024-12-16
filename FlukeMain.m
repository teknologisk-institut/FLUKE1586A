clear variables
close all
clc

[flukeInstruments,flukeAddress,flukePort] = FlukeReadSetupFile("Y:\Personal\EAK\materialefugt\materialefugt\");

flukeTable = FlukeCreateTable(flukeInstruments);
[t,make,model,SN] = FlukeInitialize(flukeAddress,flukePort);
[channels, func] = FlukeSetupInstrument(t,flukeInstruments);

i = 0;
disp('Starting loop')
while true
    try
        [newData, flukeTable] = FlukeRead(t,flukeTable);
        if newData
            i=i+1;
        end
        if i>3
            break
        end
    catch exception
        msgText = getReport(exception);
        disp(msgText);
        clear t;
        [t,make,model,SN] = FlukeInitialize(flukeAddress,flukePort);
        [channels, func] = FlukeSetupInstrument(t,flukeInstruments);
    end
    pause(0.1)
end
t.writeline('ABOR')

figure(1)
stackedplot(flukeTable)