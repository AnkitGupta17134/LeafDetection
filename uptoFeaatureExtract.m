clear all
clc
close all
x=imread('Im10.jpg');
figure(1),
imshow(x),title('Input Image');
 
%% Median filter
x = MedianFilt(x); 

%% Histogram equalization 
x = HistEq(x);

%% Thresholding
I = rgb2lab(x);

[I,gb] = Threshold(I);

%% Segmentation

[I3,RGB] = createMask(gb);
seg_img = RGB;
%figure, imshow(I3); title('BW Image');
figure, imshow(seg_img); title('Segmented Image');

img = rgb2gray(seg_img);
%figure, imshow(img); title('Gray Scale Image');

% Create the Gray Level Cooccurance Matrices (GLCMs)
glcms = graycomatrix(img);

% Derive Statistics from GLCM
stats = graycoprops(glcms,'Contrast Correlation Energy Homogeneity');

Contrast = stats.Contrast;
Energy = stats.Energy;
Homogeneity = stats.Homogeneity;
Mean = mean2(seg_img);
Standard_Deviation = std2(seg_img);
Entropy = entropy(seg_img);
RMS = mean2(rms(seg_img));
%Skewness = skewness(img)
Variance = mean2(var(double(seg_img)));
a = sum(double(seg_img(:)));
Smoothness = 1-(1/(1+a));
% Inverse Difference Movement
m = size(seg_img,1);
n = size(seg_img,2);
in_diff = 0;
for i = 1:m
    for j = 1:n
        temp = seg_img(i,j)./(1+(i-j).^2);
        in_diff = in_diff+temp;
    end
end
IDM = double(in_diff);
feat_disease = [Contrast,Energy,Homogeneity, Mean, Standard_Deviation, Entropy, RMS, Variance, Smoothness, IDM];
