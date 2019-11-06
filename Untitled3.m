clear all
close all
clc
%READ A RGB IMAGE
A = imread('Im3.jpg');

figure,subplot(121),imagesc(A);title('RGB Image');hold on;

A = double(A);

%CARTESIAN GRID FOR THE 2D IMAGE
[Xp,Yp] = meshgrid(1:size(A,2),1:size(A,1));

%NUMBER OF CLUSTERS
num_clusters = 2;

%THRESHOLD VALUE FOR EACH CHANNEL
Tval = 1;

%GLOBAL THRESHOLD VALUE
Global_Tval = 3;

%RANDOM IMAGE POSITIONS
RX = randi(size(A,1),1,num_clusters);
RY = randi(size(A,2),1,num_clusters);



%PREALLOCATE THE VECTORS
RGB_val = zeros([num_clusters,3]);
RGB_new = zeros([num_clusters,3]);

%FETCH THE RGB PIXEL VALUE OF THE RANDOM IMAGE POSITIONS
for j = 1:num_clusters
   RGB_val(j,:) = A(RX(j),RY(j),:); 
end


myvox = zeros([size(A,1) size(A,2) num_clusters]);
flag = 1;

Rcomp = A(:,:,1); %RED CHANNEL
Gcomp = A(:,:,2); %GREEN CHANNEL
Bcomp = A(:,:,3); %BLUE CHANNEL
it=0;


while flag==1
 
 %EUCLIDEAN DISTANCE BETWEEN THE RANDOM RGB PIXEL VALUE
 %AND THE PIXEL VALUES IN THE IMAGE
 for j = 1: num_clusters
     myvox(:,:,j) = sqrt((A(:,:,1)-RGB_val(j,1)).^2+(A(:,:,2)-RGB_val(j,2)).^2+(A(:,:,3)-RGB_val(j,3)).^2);
 end

%FIND THE MINIMUM VALUE(Y) AND THE CORRESPONDING CLUSTER NUMBERS(ClusterMap)
[Y,ClusterMap] = min(myvox,[],3);


%MEAN VALUE PIXEL VALUES IN EACH CHANNEL WITH RESPECT TO THE CLUSTERS
for j = 1:num_clusters
  
   RGB_new(j,1) = mean(Rcomp(ClusterMap(:)==j));
   RGB_new(j,2) = mean(Gcomp(ClusterMap(:)==j));
   RGB_new(j,3) = mean(Bcomp(ClusterMap(:)==j));
end

%DIFFERENCE BETWEEN THE NEW VALUE AND THE OLD VALUE
DiffVal = abs(RGB_val-RGB_new);


%IF THE DIFFERENCE IS LESS,STOP THE ITERATION ELSE
%ASSIGN THE NEW VALUE AND CONTINUE
if(sum(DiffVal(:)) < Global_Tval)
    flag = 0;
else
  if(sum(DiffVal(:,1))>Tval)
    RGB_val(:,1) = RGB_new(:,1);
  end
  if(sum(DiffVal(:,2))>Tval)
    RGB_val(:,2) = RGB_new(:,2);
  end
  if(sum(DiffVal(:,3))>Tval)
     RGB_val(:,3) = RGB_new(:,3);
  end
end




%NUMBER OF ITERATIONS
it=it+1;

end
subplot(122),imagesc(ClusterMap);title('Clusters');colormap(jet);

m=2;
n = round(num_clusters/m);
for k=1:num_clusters
F = repmat(logical(ClusterMap==k),1,1,3).*double(A);
figure(2),subplot(n,m,k),imagesc(uint8(F));hold on;
end
