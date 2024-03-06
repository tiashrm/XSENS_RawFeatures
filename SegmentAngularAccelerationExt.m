%Segment Angular Acceleration 
dirs = dir('*.xlsx');


L = 6; %Change per type of Task (Lifting 18, Circuital = 6) 

SegmentAngularAcceleration_Results = zeros(length(dirs),L,70,12);%Has 70 columns
 for MocapFile=1:length(dirs) 
    %loading the relevant .xlsx file
    CurrentFile = dirs(MocapFile).name; 
    Markers = xlsread(CurrentFile, "Markers");
 SegmentAngularAcceleration = xlsread(CurrentFile, "Segment Angular Acceleration");
    for i = 1:L
        A7 = SegmentAngularAcceleration(Markers(2*i-1):Markers(2*i),:);
        SegmentAngularAcceleration_Results(MocapFile,i,:,1) = max(A7);
        SegmentAngularAcceleration_Results(MocapFile,i,:,2) = min(A7);
        SegmentAngularAcceleration_Results(MocapFile,i,:,3) = max(A7)-min(A7);
        SegmentAngularAcceleration_Results(MocapFile,i,:,4) = prctile((A7),95);
        SegmentAngularAcceleration_Results(MocapFile,i,:,5) = prctile((A7),50);
        SegmentAngularAcceleration_Results(MocapFile,i,:,6) = prctile((A7),5);
        SegmentAngularAcceleration_Results(MocapFile,i,:,7) = prctile((A7),25);
        SegmentAngularAcceleration_Results(MocapFile,i,:,8) = prctile((A7),75); 
        SegmentAngularAcceleration_Results(MocapFile,i,:,9) = prctile((A7),10);
        SegmentAngularAcceleration_Results(MocapFile,i,:,10) = mean(A7);
        SegmentAngularAcceleration_Results(MocapFile,i,:,11) = std(A7);
        SegmentAngularAcceleration_Results(MocapFile,i,:,12) = prctile((A7),95)- prctile((A7),5);
     end
 end
 
 for n7= 1:12 %Feature
    B7 = squeeze(SegmentAngularAcceleration_Results(:,:,:,n7));
    for m7=1:L %Task
        C7 = squeeze(B7(:,m7,:));
            xlswrite(['SegmentAngularAcceleration_',num2str(n7),'.xlsx'],C7,['Sheet',num2str(m7)]);
            %Different Files for each feature - 6 sheets for each task -
            %separated by per sheet - participant and each segmental value 
    end
end