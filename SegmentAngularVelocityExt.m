%Segment Angular velocity
dirs = dir('*.xlsx');


L = 6;
SegmentAngularVelocity_Results = zeros(length(dirs),L,70,12);%Has 70 columns
 for MocapFile=1:length(dirs) 
    %loading the relevant .xlsx file
    CurrentFile = dirs(MocapFile).name; 
    Markers = xlsread(CurrentFile, "Markers");
 SegmentAngularVelocity = xlsread(CurrentFile, "Segment Angular Velocity");
for i = 1:L
        A6 = SegmentAngularVelocity(Markers(2*i-1):Markers(2*i),:);
        SegmentAngularVelocity_Results(MocapFile,i,:,1) = max(A6);
        SegmentAngularVelocity_Results(MocapFile,i,:,2) = min(A6);
        SegmentAngularVelocity_Results(MocapFile,i,:,3) = max(A6)-min(A6);
        SegmentAngularVelocity_Results(MocapFile,i,:,4) = prctile((A6),95);
        SegmentAngularVelocity_Results(MocapFile,i,:,5) = prctile((A6),50);
        SegmentAngularVelocity_Results(MocapFile,i,:,6) = prctile((A6),5);
        SegmentAngularVelocity_Results(MocapFile,i,:,7) = prctile((A6),25);
        SegmentAngularVelocity_Results(MocapFile,i,:,8) = prctile((A6),75); 
        SegmentAngularVelocity_Results(MocapFile,i,:,9) = prctile((A6),10);
        SegmentAngularVelocity_Results(MocapFile,i,:,10) = mean(A6);
        SegmentAngularVelocity_Results(MocapFile,i,:,11) = std(A6);
        SegmentAngularVelocity_Results(MocapFile,i,:,12) = prctile((A6),95)- prctile((A6),5);
    end
 end
 
%Segment Angular Velocity
for n6= 1:12 %Feature
    B6 = squeeze(SegmentAngularVelocity_Results(:,:,:,n6));
    for m6=1:L %Task
        C6 = squeeze(B6(:,m6,:));
            xlswrite(['SegmentAngularVelocity_',num2str(n6),'.xlsx'],C6,['Sheet',num2str(m6)]);
            %Different Files for each feature - 6 sheets for each task -
            %separated by per sheet - participant and each segmental value 
    end
end 