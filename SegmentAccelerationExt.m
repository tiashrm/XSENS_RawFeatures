%Segment Acceleration

dirs = dir('*.xlsx');


L = 6; %Change per type of Task (Lifting 18, Circuital = 6) 
SegmentAcceleration_Results = zeros(length(dirs),L,70,12);%Has 70 columns
for MocapFile=1:length(dirs) 
    %loading the relevant .xlsx file
    CurrentFile = dirs(MocapFile).name; 
    Markers = xlsread(CurrentFile, "Markers");
SegmentAcceleration = xlsread(CurrentFile, "Segment Acceleration");
     for i = 1:L
        A5 = SegmentAcceleration(Markers(2*i-1):Markers(2*i),:);
        SegmentAcceleration_Results(MocapFile,i,:,1) = max(A5);
        SegmentAcceleration_Results(MocapFile,i,:,2) = min(A5);
        SegmentAcceleration_Results(MocapFile,i,:,3) = max(A5)-min(A5);
        SegmentAcceleration_Results(MocapFile,i,:,4) = prctile((A5),95);
        SegmentAcceleration_Results(MocapFile,i,:,5) = prctile((A5),50);
        SegmentAcceleration_Results(MocapFile,i,:,6) = prctile((A5),5);
        SegmentAcceleration_Results(MocapFile,i,:,7) = prctile((A5),25);
        SegmentAcceleration_Results(MocapFile,i,:,8) = prctile((A5),75); 
        SegmentAcceleration_Results(MocapFile,i,:,9) = prctile((A5),10);
        SegmentAcceleration_Results(MocapFile,i,:,10) = mean(A5);
        SegmentAcceleration_Results(MocapFile,i,:,11) = std(A5);
        SegmentAcceleration_Results(MocapFile,i,:,12) = prctile((A5),95)- prctile((A5),5);
     end
    
end

%Segment Acceleration
for n5= 1:12 %Feature
    B5 = squeeze(SegmentAcceleration_Results(:,:,:,n5));
    for m5=1:L %Task
        C5 = squeeze(B5(:,m5,:));
            xlswrite(['SegmentAcceleration_',num2str(n5),'.xlsx'],C5,['Sheet',num2str(m5)]);
            %Different Files for each feature - 6 sheets for each task -
            %separated by per sheet - participant and each segmental value 
    end
end 