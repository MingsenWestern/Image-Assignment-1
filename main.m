% main.m
clear; clc; close all;

I = imread("/Users/mingsenhu/Documents/Work/Code/MATLAB/Test/Test1/image/mountain.jpg");

% If RGB → grayscale (IPT):
if ndims(I) == 3
    Igray = rgb2gray(I);
else
    Igray = I;
end

% Make a logical binary image for your function:
BW = imbinarize(Igray);
% (If you need binarization from grayscale, use: BW = imbinarize(Igray);)

% Call your DFS function (expects logical):
boxes = find_bounding_boxes_34(BW);

% --- Display with IPT ---
figure; imshow(BW, []); title('Bounding boxes'); hold on;
for i = 1:size(boxes,1)
    rmin = boxes(i,1); cmin = boxes(i,2);
    rmax = boxes(i,3); cmax = boxes(i,4);
    rectangle('Position', [cmin-0.5, rmin-0.5, cmax-cmin+1, rmax-rmin+1], ...
              'EdgeColor','y','LineWidth',2);
end
hold off;
