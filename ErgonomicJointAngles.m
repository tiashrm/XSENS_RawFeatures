%%For Ergonomic Joint Angles ZXY 
dirs = dir('*.xlsx');


L = 6;
ErgonomicJointAnglesZXY_Results = zeros(length(dirs),L,19,12);%Has 19 columns
for MocapFile=1:length(dirs) 
    %loading the relevant .xlsx file
    CurrentFile = dirs(MocapFile).name; 
    Markers = xlsread(CurrentFile, "Markers");
 ErgonomicJointAnglesZXY = xlsread(CurrentFile, "Ergonomic Joint Angles ZXY");
 for i = 1:L
        A3 = ErgonomicJointAnglesZXY(Markers(2*i-1):Markers(2*i),:);
        ErgonomicJointAnglesZXY_Results(MocapFile,i,:,1) = max(A3);
        ErgonomicJointAnglesZXY_Results(MocapFile,i,:,2) = min(A3);
        ErgonomicJointAnglesZXY_Results(MocapFile,i,:,3) = max(A3)-min(A3);
        ErgonomicJointAnglesZXY_Results(MocapFile,i,:,4) = prctile((A3),95);
        ErgonomicJointAnglesZXY_Results(MocapFile,i,:,5) = prctile((A3),50);
        ErgonomicJointAnglesZXY_Results(MocapFile,i,:,6) = prctile((A3),5);
        ErgonomicJointAnglesZXY_Results(MocapFile,i,:,7) = prctile((A3),25);
        ErgonomicJointAnglesZXY_Results(MocapFile,i,:,8) = prctile((A3),75); 
        ErgonomicJointAnglesZXY_Results(MocapFile,i,:,9) = prctile((A3),10);
        ErgonomicJointAnglesZXY_Results(MocapFile,i,:,10) = mean(A3);
        ErgonomicJointAnglesZXY_Results(MocapFile,i,:,11) = std(A3);
        ErgonomicJointAnglesZXY_Results(MocapFile,i,:,12) = prctile((A3),95)- prctile((A3),5);
    end
    
end
%%Ergonomic Joint Angles ZXY
for n3= 1:12 %Feature
    B3 = squeeze(ErgonomicJointAnglesZXY_Results(:,:,:,n3));
    for m3=1:L %Task
        C3 = squeeze(B3(:,m3,:));
            xlswrite(['ErgonomicJointAnglesZXY_',num2str(n3),'.xlsx'],C3,['Sheet',num2str(m3)]);
            %Different Files for each feature - 6 sheets for each task -
            %separated by per sheet - participant and each segmental value 
    end
end 
