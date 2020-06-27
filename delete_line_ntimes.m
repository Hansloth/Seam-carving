clear
clc
img=imread('penguins.jpg');
%imshow(img)

prompt = 'How many row do you want to delete? ';%�ݭn�R���X��
deltime=input(prompt);
for n=1:deltime%���ƧR��deletime��

b=rgb2gray(img);
%imshow(b);
[Gmag,Gdir] = imgradient(b,'prewitt');
%%imshowpair(Gmag, Gdir, 'montage');



    
[y,x]=size(Gmag);
for i=2:y
    for j=1:x
            if j==1
                Gmag(i,j)=Gmag(i,j)+min([Gmag(i-1,j),Gmag(i-1,j+1)]);
            elseif j==x
                Gmag(i,j)=Gmag(i,j)+min([Gmag(i-1,j),Gmag(i-1,j-1)]);
            else
                 Gmag(i,j)=Gmag(i,j)+min([Gmag(i-1,j-1),Gmag(i-1,j),Gmag(i-1,j+1)]);
            end
    end
end
%�W���j��O�֥[��q

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

delete=idx;%�s�n�R�����y��
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
    delete=[tempt;delete];%delete�s�n�R�����y��
end
%�W���j��A�O�Х̧ܳC��qpixel������

img(:,:,1)= R(:,:);
img(:,:,2)= G(:,:);
img(:,:,3)= B(:,:);

%figure;imshow(img);
imshow(img);
new=[];

%remove the optimal seam �U���{���n�����̧C��q
for j=y:-1:1
    del=delete(j,1);
    new=[[img(j,1:del-1,:) img(j,del+1:end,:)];new]; 
end
imshow(new);
clear img;
img(:,:,:)=new(:,:,:);
end








     


