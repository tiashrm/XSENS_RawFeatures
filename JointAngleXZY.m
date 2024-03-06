%%Only for Joint Angle XZY

dirs = dir('*.xlsx');


L = 18; %Change per type of Task (Lifting 18, Circuital = 6) 
JointAnglesXZY_Results = zeros(length(dirs),L,67,12);%Has 67 columns

for MocapFile=1:length(dirs) 
    %loading the relevant .xlsx file
    CurrentFile = dirs(MocapFile).name; 
    Markers = xlsread(CurrentFile, "Markers");
 JointAnglesXZY = xlsread(CurrentFile, "Joint Angles XZY");
    for i = 1:L
        A2 = JointAnglesXZY(Markers(2*i-1):Markers(2*i),:);
        JointAnglesXZY_Results(MocapFile,i,:,1) = max(A2);
        JointAnglesXZY_Results(MocapFile,i,:,2) = min(A2);
        JointAnglesXZY_Results(MocapFile,i,:,3) = max(A2)-min(A2);
        JointAnglesXZY_Results(MocapFile,i,:,4) = prctile((A2),95);
        JointAnglesXZY_Results(MocapFile,i,:,5) = prctile((A2),50);
        JointAnglesXZY_Results(MocapFile,i,:,6) = prctile((A2),5);
        JointAnglesXZY_Results(MocapFile,i,:,7) = prctile((A2),25);
        JointAnglesXZY_Results(MocapFile,i,:,8) = prctile((A2),75); 
        JointAnglesXZY_Results(MocapFile,i,:,9) = prctile((A2),10);
        JointAnglesXZY_Results(MocapFile,i,:,10) = mean(A2);
        JointAnglesXZY_Results(MocapFile,i,:,11) = std(A2);
        JointAnglesXZY_Results(MocapFile,i,:,12) = prctile((A2),95)- prctile((A2),5);
    end
end

%Joint Angles XZY
for n2= 1:12 %Feature
    B2 = squeeze(JointAnglesXZY_Results(:,:,:,n2));
    for m2=1:L %Task
        C2 = squeeze(B2(:,m2,:));
            xlswrite(['JointAngleXZY_',num2str(n2),'.xlsx'],C2,['Sheet',num2str(m2)]);
            %Different Files for each feature - 6 sheets for each task -
            %separated by per sheet - participant and each segmental value 
    end
end 