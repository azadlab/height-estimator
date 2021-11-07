function L=enforcePointOrder(lsegs)
        
        L = lsegs;
        nlines = size(lsegs,1);
        shouldChange = logical(zeros(nlines,1));
        direction = atan2(lsegs(:,4)-lsegs(:,2),lsegs(:,3)-lsegs(:,1));
        dx = lsegs(:,3)-lsegs(:,1);
        dy = lsegs(:,4)-lsegs(:,2);
        
		shouldChange = shouldChange & ((dy>0) & ((direction>=-0.75*pi) & (direction<-0.25*pi)));
        shouldChange = shouldChange & ((dx<0) & (direction>=-0.25*pi) & (direction<0.25*pi));
        shouldChange = shouldChange & ((dy<0) & (direction>=0.25*pi) & (direction<0.75*pi));
        shouldChange = shouldChange & ((dx>0) & (((direction>=0.75*pi) & (direction<pi)) | (direction>=-pi & direction<-0.75*pi)));
           
        L(shouldChange,:) = [lsegs(shouldChange,3:4),lsegs(shouldChange,1:2)];
end