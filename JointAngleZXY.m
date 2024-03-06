%%Only for Joint Angle ZXY with 67 columns 

dirs = dir('*.xlsx');
L = 6; %Change per type of Task (Lifting 18, Circuital = 6) 

%%Creating Matrix 
JointAnglesZXY_Results = zeros(length(dirs),L,67,12);%Has 67 columns
for MocapFile=1:length(dirs) 
    %loading the relevant .xlsx file
    CurrentFile = dirs(MocapFile).name; 
    Markers = xlsread(CurrentFile, "Markers");
 
    %%Creating Reference variables:
    JointAnglesZXY = xlsread(CurrentFile, "Joint Angles ZXY");
     %%Joint Angle ZXY - take all but not shoulder from here
    %Column A: Markers (verified)
    for i = 1:L
        A1 = JointAnglesZXY(Markers(2*i-1):Markers(2*i),:);
        JointAnglesZXY_Results(MocapFile,i,:,1) = max(A1);
        JointAnglesZXY_Results(MocapFile,i,:,2) = min(A1);
        JointAnglesZXY_Results(MocapFile,i,:,3) = max(A1)-min(A1);
        JointAnglesZXY_Results(MocapFile,i,:,4) = prctile((A1),95);
        JointAnglesZXY_Results(MocapFile,i,:,5) = prctile((A1),50);
        JointAnglesZXY_Results(MocapFile,i,:,6) = prctile((A1),5);
        JointAnglesZXY_Results(MocapFile,i,:,7) = prctile((A1),25);
        JointAnglesZXY_Results(MocapFile,i,:,8) = prctile((A1),75); 
        JointAnglesZXY_Results(MocapFile,i,:,9) = prctile((A1),10);
        JointAnglesZXY_Results(MocapFile,i,:,10) = mean(A1);
        JointAnglesZXY_Results(MocapFile,i,:,11) = std(A1);
        JointAnglesZXY_Results(MocapFile,i,:,12) = prctile((A1),95)- prctile((A1),5);
    end
end   
    %%Making Separate Files for Analysis 
   %Joint Angles ZXY
for n1= 1:12 %Feature
    B1 = squeeze(JointAnglesZXY_Results(:,:,:,n1));
    for m1=1:L %Task
        C1 = squeeze(B1(:,m1,:));
            xlswrite(['JointAngleZXY_noshoulder_',num2str(n1),'.xlsx'],C1,['Sheet',num2str(m1)]);
            %Different Files for each feature - 6 sheets for each task -
            %separated by per sheet - participant and each segmental value 
    end
end 