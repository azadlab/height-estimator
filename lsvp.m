function vp = lsvp(L)
        
        nlines = size(L,1);
        hvlines = cross([L(:,1:2)';ones(1,nlines)],[L(:,3:4)';ones(1,nlines)]);
%         A = hvlines(1:2,:)';
%         b = -hvlines(3,:)';
        
%         vp = A\b;
%         [U,S,V] = svd(hvlines');
A = hvlines*hvlines'
        [V,D]=eigs(A);
        [val,idx] = sort(diag(D));
        
%         vp = [vp;1];
        vp = V(:,idx(1));
        vp = vp/vp(3);
end