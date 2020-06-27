clear
clc
img=imread('penguins.jpg');
%imshow(img)

prompt = 'How many row do you want to delete? ';%問要刪除幾次
deltime=input(prompt);

for n=1:deltime%重複刪除deletime次

b=rgb2gray(img);
b=double(b);
Gmag=b;
Gmag=double(Gmag);




[y,x]=size(Gmag);
for i=2:y
    for j=1:x
            if j==1
                CV=abs(b(i,j+1)-0);
                CR=abs(b(i,j+1)-0)+abs(b(i-1)-b(i,j+1));
                
                Gmag(i,j)=b(i,j)+min([Gmag(i-1,j)+CV,Gmag(i-1,j+1)+CR]);
            elseif j==x
                CL=abs(0-b(i,j-1))+abs(b(i-1,j)-b(i,j-1));
                CV=abs(0-b(i,j-1));
                
                Gmag(i,j)=b(i,j)+min([Gmag(i-1,j)+CV,Gmag(i-1,j-1)+CL]);
            else
                CL=abs(b(i,j+1)-b(i,j-1))+abs(b(i-1,j)-b(i,j-1));
                CV=abs(b(i,j+1)-b(i,j-1));
                CR=abs(b(i,j+1)-b(i,j-1))+abs(b(i-1)-b(i,j+1));
                
                Gmag(i,j)=b(i,j)+min([Gmag(i-1,j-1)+CL,Gmag(i-1,j)+CV,Gmag(i-1,j+1)+CR]);
            end
    end
end
%上面迴圈是累加能量
imagesc(Gmag)
%find the lowest layer smallest

R=img(:,:,1);
G=img(:,:,2);
B=img(:,:,3);

[v,idx]=min(Gmag(y,:));
R(y,idx)=255;
G(y,idx)=0;
B(y,idx)=0;
tempt=idx;

delete=idx;%存要刪除的座標
for j=y-1:-1:1
    if tempt==1
       [val,idx]=min([Gmag(j,tempt),Gmag(j,tempt+1)]);
       tempt=tempt+idx-1;
    elseif tempt==x
       [val,idx]=min([Gmag(j,tempt-1),Gmag(j,tempt)]);
       tempt=tempt+idx-2;
    else
       [val,idx]=min([Gmag(j,tempt-1),Gmag(j,tempt),Gmag(j,tempt+1)]);
       tempt=tempt+idx-2;
    end
    %tempt=tempt+idx-2;
    R(j,tempt)=255;
    G(j,tempt)=0;
    B(j,tempt)=0;
    delete=[tempt;delete];%delete存要刪除的座標
end
%上面迴圈，是標示最低能量pixel為紅色

img(:,:,1)= R(:,:);
img(:,:,2)= G(:,:);
img(:,:,3)= B(:,:);

%figure;imshow(img);
imshow(img);
new=[];

%remove the optimal seam 下面程式要移除最低能量
for j=y:-1:1
    del=delete(j,1);
    new=[[img(j,1:del-1,:) img(j,del+1:end,:)];new]; 
end
imshow(new);
clear img;
img(:,:,:)=new(:,:,:);
end








     


