% main.m
clear; clc; close all;

I = imread("/Users/mingsenhu/Documents/Work/Code/MATLAB/Test/Test1/image/mountain.jpg");

if ~(islogical(I) && ismatrix(I))
    % If RGB → grayscale (IPT):
    if ndims(I) == 3
        Igray = rgb2gray(I);
    else
        Igray = I;
    end
    BW = imbinarize(Igray);
    I = BW;
end




% Make a logical binary image for your function:
% 
% (If you need binarization from grayscale, use: BW = imbinarize(Igray);)

% Call your DFS function (expects logical):
boxes = find_bounding_boxes_34(I);

% --- Display with IPT ---
figure; imshow(I, []); title('Bounding boxes'); hold on;
for i = 1:size(boxes,1)
    cmin = boxes(i,1); rmin = boxes(i,2);
    cmax = boxes(i,3) + cmin; rmax = boxes(i,4) + rmin;
    rectangle('Position', [cmin-0.5, rmin-0.5, cmax-cmin+1, rmax-rmin+1], ...
              'EdgeColor','y','LineWidth',2);
end
hold off;
