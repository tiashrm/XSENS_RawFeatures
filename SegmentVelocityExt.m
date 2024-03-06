%Segment Velocity
dirs = dir('*.xlsx');


L = 6; %Change per type of Task (Lifting 18, Circuital = 6) 
SegmentVelocity_Results = zeros(length(dirs),L,70,12);%Has 70 columns


for MocapFile=1:length(dirs) 
    %loading the relevant .xlsx file
    CurrentFile = dirs(MocapFile).name; 
    Markers = xlsread(CurrentFile, "Markers");
   
     SegmentVelocity = xlsread(CurrentFile, "Segment Velocity");
    for i = 1:L
        A4 = SegmentVelocity(Markers(2*i-1):Markers(2*i),:);
        SegmentVelocity_Results(MocapFile,i,:,1) = max(A4);
        SegmentVelocity_Results(MocapFile,i,:,2) = min(A4);
        SegmentVelocity_Results(MocapFile,i,:,3) = max(A4)-min(A4);
        SegmentVelocity_Results(MocapFile,i,:,4) = prctile((A4),95);
        SegmentVelocity_Results(MocapFile,i,:,5) = prctile((A4),50);
        SegmentVelocity_Results(MocapFile,i,:,6) = prctile((A4),5);
        SegmentVelocity_Results(MocapFile,i,:,7) = prctile((A4),25);
        SegmentVelocity_Results(MocapFile,i,:,8) = prctile((A4),75); 
        SegmentVelocity_Results(MocapFile,i,:,9) = prctile((A4),10);
        SegmentVelocity_Results(MocapFile,i,:,10) = mean(A4);
        SegmentVelocity_Results(MocapFile,i,:,11) = std(A4);
        SegmentVelocity_Results(MocapFile,i,:,12) = prctile((A4),95)- prctile((A4),5);
    end
    
end
%Segment Velocity
for n4= 1:12 %Feature
    B4 = squeeze(SegmentVelocity_Results(:,:,:,n4));
    for m4=1:L %Task
        C4 = squeeze(B4(:,m4,:));
            xlswrite(['SegmentVelocity_',num2str(n4),'.xlsx'],C4,['Sheet',num2str(m4)]);
            %Different Files for each feature - 6 sheets for each task -
            %separated by per sheet - participant and each segmental value 
    end
end