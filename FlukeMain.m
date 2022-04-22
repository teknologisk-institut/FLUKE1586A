clear variables
close all
clc

[flukeInstruments,flukeAddress,flukePort]=FlukeReadSetupFile("C:\Users\peo\Documents\GitHub\FLUKE1586A\");

flukeTable = FlukeCreateTable(flukeInstruments);
[t,make,model,SN] = FlukeInitialize(flukeAddress,flukePort);
[channels, func] = FlukeSetupInstrument(t,flukeInstruments);

i = 0;
while true
    try
        [measurements,flukeTable,newData] = FlukeRead(t,flukeTable,flukeInstruments);
        if newData==1
            i = i+1;
        end
        if i>3
            break
        end
    catch
        clear t;
        [t,make,model,SN] = FlukeInitialize(flukeAddress,flukePort);
        [channels, func] = FlukeSetupInstrument(t,flukeInstruments);
    end
    pause(0.1)
end
t.writeline('ABOR')