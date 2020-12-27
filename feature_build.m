clc
clear
close all

load('feature.mat')
j = 1;
k = 1;
for i = 1:length(feature)
    signal_mfsc = feature{i};
    L           = size(signal_mfsc, 1);
    point = 0;
    while point < length(signal_mfsc) - L
        point = point + L/10;
        data = signal_mfsc(:,point+1: point + L);
        u8data = uint8(255*((data - min(data(:)))/ (max(data(:)) - min(data(:)))));
        xdata = u8data;
        xdata(:,:,2) = u8data;
        xdata(:,:,3) = u8data;
        if mean(data(:)) > 1000
            imwrite(xdata, ['data/pos/',num2str(j),'.jpg']);
%             print(size(xdata))
            j = j+1;
        else
            imwrite(xdata, ['data/neg/',num2str(k),'.jpg']);
            k = k+1;
        end
    end
    
end