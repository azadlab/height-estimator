function V =orderVP(VP,Ic)

   
    vpts = [];
    
    for i=1:length(VP)
  
        vpts(i,:) = VP{i}'/norm(VP{i});
    end
    
    
    [maxVP,idx]=max(abs(vpts));
    oidx = find([1,2,3]~=idx(2));
    V{1} = VP{idx(2)};
    V2 = VP{oidx(1)};
    V3 = VP{oidx(2)};
    
    if norm(V2(1:2)-Ic) < norm(V3(1:2)-Ic)
        temp = V2;
        V2 = V3;
        V3 = temp;
    end
    V{2} = V2;
    V{3} = V3;
%        V{2} = VP{oidx(1)};
%        V{3} = VP{oidx(2)};
end

    
