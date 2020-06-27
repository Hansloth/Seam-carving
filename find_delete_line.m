img=imread('penguins.jpg');
imshow(img);
b=rgb2gray(img);
imshow(b);
[Gmag,Gdir] = imgradient(b,'prewitt');
%%imshowpair(Gmag, Gdir, 'montage');

[y,x]=size(Gmag);
for i=2:y
    for j=1:x
            if j==1
                Gmag(i,j)=Gmag(i,j)+min([Gmag(i-1,j),Gmag(i-1,j+i)]);
            elseif j==x
                Gmag(i,j)=Gmag(i,j)+min([Gmag(i-1,j),Gmag(i-1,j-1)]);
            else
                 Gmag(i,j)=Gmag(i,j)+min([Gmag(i-1,j-1),Gmag(i-1,j),Gmag(i-1,j+1)]);
            end
    end
end

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
    R(j,tempt)=255;
    G(j,tempt)=0;
    B(j,tempt)=0;
end

img(:,:,1)= R(:,:);
img(:,:,2)= G(:,:);
img(:,:,3)= B(:,:);

figure;imshow(img);

     


