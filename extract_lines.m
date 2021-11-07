        L = lsd(double(img));
%     end
%         L = enforcePointOrder(L);
        
    if(size(L,1)<30)
        L = lsd(double(img));
    end
    
    Lines = [L(:,1),L(:,3),L(:,2),L(:,4)];
    
    if(debug)
        figure,imshow(img,[]);
        line_colors = draw_lines(Lines);
    end
    
    
    Lines = [L(:,1),L(:,3),L(:,2),L(:,4)];

nlines = size(Lines,1);
s1h = [L(:,1:2)';ones(1,nlines)];
e1h = [L(:,3:4)';ones(1,nlines)];


Lh = cross(s1h,e1h);
Lh = Lh./repmat(sqrt(sum(Lh(1:2,:).^2)),3,1);
