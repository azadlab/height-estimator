
angles = abs(atan2(L(:,4)-L(:,2),(L(:,3)-L(:,1))));
[counts,bins]=histc(angles,0:0.005:pi);
nbins = max(bins);
Vpts = zeros(nbins,3);
k=1;
nzcounts = counts;
for bi=1:nbins
    if(counts(bi)<=0)
        continue;
    end
    vpt = lsvp(L(bins==bi,:));
    Vpts(k,:) = vpt;
    nzcounts(k) = counts(bi);
    k = k + 1;
end
Vpts = Vpts(1:k,:);
nzcounts = nzcounts(1:k);

[IDX,C,sumd,D]=kmeans(Vpts,3);
D = (D-repmat(min(D),k,1))./(repmat(max(D)-min(D),k,1));
labels1 = D(:,1)<0.01;
labels2 = D(:,2)<0.01;
labels3 = D(:,3)<0.01;
% vp{1} = K*lsvp(L(labels1,:));
% vp{2} = K*lsvp(L(labels2,:));
% vp{3} = K*lsvp(L(labels3,:));
vp{1}=Vpts(labels1,:)';
if(size(vp{1},2)>1)
    vp{1} = sum(repmat(nzcounts(labels1)',3,1).*vp{1},2)/sum(nzcounts(labels1));
end
vp{2} = Vpts(labels2,:)';
if(size(vp{2},2)>1)
    vp{2} = sum(repmat(nzcounts(labels2)',3,1).*vp{2},2)/sum(nzcounts(labels2));
end
vp{3} = Vpts(labels3,:)';
if(size(vp{3},2)>1)
    vp{3} = sum(repmat(nzcounts(labels3)',3,1).*vp{3},2)/sum(nzcounts(labels3));
end


% vp = orderVP(vp,K(1:2,3));

% w = inv(K*K');
% [ov,mi,mj,alpha]=computeOrthogonalVP(vp{1},vp{2},w,K);
% vp{2}=real(ov);
%  
% vp{3} = cross(vp{1}/norm(vp{1}),vp{2}/norm(vp{2}));
% vp{3} = K*(vp{3}/vp{3}(3));
% acos((vp{1}'*w*vp{2})/(sqrt(vp{1}'*w*vp{1})*sqrt(vp{2}'*w*vp{2})))*180/pi
% 
% vp{1} = vp{1}(1:2)';
% vp{2} = vp{2}(1:2)';
% vp{3} = vp{3}(1:2)';