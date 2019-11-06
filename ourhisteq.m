
function histeqimg = ourhisteq(image)

% image=rgb2gray(imread('Im3.JPG'));
% figure,imshow(image);
% title('Original Image');

[m,n]=size(image);

freq=zeros(256,1);
pdf=zeros(256,1);
mn=m*n;
L=256;

%freq no. of occurrences of every pixel value.
%probability of each occurrence is calculated by pdf.

for i=1:m
    for j=1:n
        value=round(image(i,j));
        freq(value+1)=freq(value+1)+1;
       
        pdf(value+1)=freq(value+1)/mn;
    end
end

no=1:256;
% figure,stem(no,pdf)
% title('Probability Distribution Function')

cum=zeros(256,1);
cdf=zeros(256,1);
Tr =zeros(256,1);
out=zeros(256,1);
sum=0;

for i=1:256
	sum=sum + freq(i);
	cum(i) = sum;
    Tr(i)  = cdf(i)*(L-1); %Transfer Function    
	cdf(i) = cum(i)/mn;      %cumulative 
	out(i) = round(cdf(i)*(L-1)); %round off
end

%cum
% figure,stem(no,out)

% disp("Cum")
% disp(cdf);
% disp("L-1*CDF")
% disp(Tr);
% disp("Round-off")
% disp(out); %round off out

histeqimg=zeros(256,256); %to display histogram-equalized image

for i=1:m
    for j=1:n
            histeqimg(i,j)=out(round(image(i,j))+1);
    end
end
% figure,
% imshow(uint8(histeqimg));
% title('Histogram equalization');


