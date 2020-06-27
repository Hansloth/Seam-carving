clear
clc
img=imread('penguins.jpg');


imcrop=roipoly(img); 
%imshow(imcrop);%���X�n�O�d�ϰ�


b=rgb2gray(img);
[Gmag,Gdir] = imgradient(b,'prewitt');


Left=700;
Right=0;
%�w���w�qR�n��n�R�����϶����̥k��y��
%�w���w�qL�n��n�R�����϶����̥���y��


[y,x]=size(Gmag);
for i=1:y
    for j=1:x
        if imcrop(i,j)==1
        Gmag(i,j)=-300000;
        end
    end
end
NGmag=Gmag;
%imshow(NGmag);%Test

deletetime=1;

while deletetime==1%���ƧR��deletime��
clc
    
[y,x]=size(NGmag);
for i=2:y
    for j=1:x
            if j==1
                NGmag(i,j)=NGmag(i,j)+min([NGmag(i-1,j),NGmag(i-1,j+1)]);
            elseif j==x
                NGmag(i,j)=NGmag(i,j)+min([NGmag(i-1,j-1),NGmag(i-1,j)]);
            else
                 NGmag(i,j)=NGmag(i,j)+min([NGmag(i-1,j-1),NGmag(i-1,j),NGmag(i-1,j+1)]);
            end
    end
end
%�W���j��O�֥[��q

%figure;imagesc(NGmag);%Test
R=img(:,:,1);
G=img(:,:,2);
B=img(:,:,3);

[v,idx]=min(NGmag(y,:));
R(y,idx)=255;
G(y,idx)=0;
B(y,idx)=0;

tempt=idx;

delete=idx;%�s�n�R�����y��
for j=y-1:-1:1
    if tempt==1
       [val,idx]=min([NGmag(j,tempt),NGmag(j,tempt+1)]);
       tempt=tempt+idx-1;
    elseif tempt==x
       [val,idx]=min([NGmag(j,tempt-1),NGmag(j,tempt)]);
       tempt=(tempt+idx)-2;
    else
       [val,idx]=min([NGmag(j,tempt-1),NGmag(j,tempt),NGmag(j,tempt+1)]);
       tempt=(tempt+idx)-2;
    end
   
    R(j,tempt)=255;
    G(j,tempt)=0;
    B(j,tempt)=0;
    %�ХX�n�R����pixel������
    
    delete=[tempt;delete]; %delete�s�n�R�����y��
end
%�W���j��A�O�Х̧ܳC��qpixel������

img(:,:,1)= R(:,:);
img(:,:,2)= G(:,:);
img(:,:,3)= B(:,:);


%figure;imshow(img);
imshow(img);
new=[];
NewGmag=[];


%remove the optimal seam �U���{���n�����̧C��q
for j=y:-1:1
    del=delete(j,1);
    new=[[img(j,1:del-1,:) img(j,del+1:end,:)];new]; 
end


for j=y:-1:1
    del=delete(j,1);
    NewGmag=[[Gmag(j,1:del-1,:) Gmag(j,del+1:end,:)];NewGmag];
end
%Here's the bug;
    newimcrop=[];
for j=y:-1:1
    del=delete(j,1);
    newimcrop=[[imcrop(j,1:del-1,:) imcrop(j,del+1:end,:)];newimcrop];
    
    check=0;
    [p,q]=size(newimcrop);
    for m=1:p
    for k=1:q
        if newimcrop(m,k)==1
            check=check+1;
        end
    end
    end   
end

imshow(new);
clear img;
img(:,:,:)=new(:,:,:);
clear NGmag;
NGmag=NewGmag;
clear Gmag;
Gmag=NewGmag;
clear imcrop;
imcrop=newimcrop;
if check>0
    deletetime=1;
else
    deletetime=0;
end
end
