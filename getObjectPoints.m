function [top_object,bottom_object,rect]=getObjectPoints(rimg,img,thresh,removeShadow,shadowThresh)

    top_object = -1;
    bottom_object = -1;
    rect = zeros(1,4);
    global debug;
%     imgGray = rgb2gray(img);
%     G = fspecial('gaussian',[10 10],2);
%     imgGray=imfilter(imgGray,G,'same');
%     rimgGray = rgb2gray(rimg);
%     rimgGray = imfilter(rimg,G,'same');

% I1 = rgb2ycbcr(rimg);
% I2 = rgb2ycbcr(img);
% im1 = I1(:,:,1);
% im2 = I2(:,:,1);
im1 = rgb2gray(rimg);
im2 = rgb2gray(img);
% HMImg1=normalize8(homomorphic(im1,3, .5, 3));
% HMImg2=normalize8(homomorphic(im2,3, .5, 3));
% I1(:,:,1) = HMImg1;
% I2(:,:,1) = HMImg2;
% im1 = ycbcr2rgb(I1);
% im2 = ycbcr2rgb(I2);
% im1 =HMImg1;im2 = HMImg2;
diffCHM = abs(im1-im2);
diffImg = 2*double((diffCHM))/256;


% waitforbuttonpress;

if(removeShadow)
    shadowThresh = shadowThresh*256;
    imgGray(imgGray>shadowThresh(1) & imgGray<shadowThresh(2)) = rimg(imgGray>shadowThresh(1) & imgGray<shadowThresh(2));
end
%     diffImg = rgb2gray((rimg - img).^2);
%     diffImg = double(diffImg - min(diffImg(:)))/256;
    thresh=graythresh(diffImg);
    if(thresh < 0.2)
        thresh = 0.2;
    end
    bwImg = im2bw(diffImg,thresh);
    
%     axes(gca);
% imagesc(bwImg);
    
%     bwImg = medfilt2(bwImg,[5 5]);
%     bwImg = bwmorph(bwImg,'fill',10);

bwImg(1:size(bwImg,1),1:size(bwImg,2)/4)=0;
bwImg(1:size(bwImg,1),3*size(bwImg,2)/4:size(bwImg))=0;

bwImg=bwmorph(bwImg,'clean',10);
bwImg=bwmorph(bwImg,'close',5);
bwImg = activecontour(im2,bwImg,7);
    lbls = bwlabel(bwImg);
    s = regionprops(lbls,'Area','BoundingBox');
    [val,indx]=max([s.Area]);
    imgArea = size(img,1)*size(img,2);

    if(isempty(val))
        return;
    end
    rect = s(indx).BoundingBox;    
    if((rect(3)*rect(4))/imgArea < 0.05)
        return;
    end
    
%     imshow(diffImg);
    top_object = [rect(1)+rect(3)/2 rect(2)];
    bottom_object = [top_object(1) top_object(2)+rect(4)];

    if(debug)
        plot(top_object(1),top_object(2),'g*');
        plot(bottom_object(1),bottom_object(2),('g*'));
    end

end