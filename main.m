clear all
close all

 x=((imread('Im3.jpg'))); % input image
 figure,
 imshow(x);

%% Median filter
yr=x(:,:,1);
yg=x(:,:,2);
yb=x(:,:,3);
 
yr=medfilt2(yr);
yg=medfilt2(yg);
yb=medfilt2(yb);
 
x(:,:,1)= yr;
x(:,:,2)=yg;
x(:,:,3)=yb;

figure,
imshow(x);
title('After Median Filter'); 

%% Histogram equalization 

 xr=x(:,:,1);
 xg=x(:,:,2);
 xb=x(:,:,3);
 
xr=ourhisteq(xr);
 xg=ourhisteq(xg);
 xb=ourhisteq(xb);
 
 x(:,:,1)= xr;
 x(:,:,2)=xg;
 x(:,:,3)=xb;

figure,
imshow(x);
title('After HE Image'); 
%%
b = imsharpen(x);
figure, imshow(b)
title('Sharpened Image');

%%
% r = ourunsharp(x(:,:,1),7);
% g = ourunsharp(x(:,:,2),7);
% b = ourunsharp(x(:,:,3),7);
% figure, imshow(r)
% title('red Sharpened Image');
% figure, imshow(g)
% title('blue Sharpened Image');
% figure, imshow(b)
% title('green Sharpened Image');

b = ourunsharp(x,7);
figure, imshow(b)
title('our Sharpened Image');


[Bw,mask]= createMask(x);
figure,
imshow(mask);
title('mask Image');

mask=mask+100;   %taken using Otsu
[Bw,mask]= createMask(mask);
figure,
imshow(mask);
title('remask Image');
