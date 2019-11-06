function yout = HistEq(x)
%HISTEQ Summary of this function goes here
%   Detailed explanation goes here

 xr=x(:,:,1);
 xg=x(:,:,2);
 xb=x(:,:,3);
 
xr=ourhisteq(xr);
 xg=ourhisteq(xg);
 xb=ourhisteq(xb);
 
 x(:,:,1)= xr;
 x(:,:,2)=xg;
 x(:,:,3)=xb;
yout = x;
figure,
imshow(x);
title('After HE Image');
end

