% ParaList.kMaxNumHyp                = 100;%the max number of hypotheses generated in ransac procedure.
% ParaList.kMinNumHyp                = 60;%the min number of hypotheses generated in ransac procedure.
% ParaList.kAcceptHypothesisThreshold= 0.89;%threshold to accept a hypothesis. When more than 85% inliers are estabilshed by a hypothesis, then stop test the other hypotheses.
% ParaList.kRefineMethod             ='Iter'; %the way to refine the estimated vanishing points and classification results:  'SVD', 'Iter' or 'AlgLS'.
% ParaList.kConsistencyMeasure       = 1;%the method to compute the residual of a line with respect to a vanishing point: '1 for CM1' or '2 for CM2'.
% ParaList.kInClassResidualThreshold = 0.03;%unit: rad
% [imageHeight,imageWidth] = size(img);
% % fc = [K(1,1) K(2,2)];
% % cc = K(1:2,3)';
% vlines = [transpose(1:size(Lines,1)) L(:,1:4)];
% % lines2 = [transpose(1:size(L2,1)) L2];
% % nlines1 = normalize_lines(lines1,fc,cc);
% % nlines2 = normalize_lines(lines2,fc,cc);
% numOfLines = size(vlines, 1);
%     
% pp = 0.5*[imageWidth, imageHeight];
%    
% center = [0, pp, pp];
% % scale = repmat([1 imageWidth imageHeight imageWidth, imageHeight],size(vlines,1),1);
% % nlines = (vlines - repmat(center,size(vlines,1),1)./scale);  
% nlines = vlines - repmat(center,size(vlines,1),1);
% 
% % [bestClassification, info] = ClassifyLinesWithKnownFocal(nlines1,  ParaList, lines1);
% [bestClassification, info] = ClassifyLinesAndEstimateFocal(nlines, ParaList);
% fc = [1,1]*info.bestFocal; 
% % K = [fc(1) 0 pp(1);0 fc(2) pp(2);0 0 1];
% K = eye(3);
% vp{1} = K*(info.bestVP(:,1)/info.bestVP(3,1));
% vp{2} = K*(info.bestVP(:,2)/info.bestVP(3,2));
% vp{3} = K*(info.bestVP(:,3)/info.bestVP(3,3));

% [vp,inliers]=estimate_vps(Lines);

% hist_vp;

% if(debug)
%     figure, fig2 = plot_vanishing_points(img,vlines(bestClassification ~= 0,:), bestClassification(bestClassification ~= 0),info.bestVP,fc, pp, 0); 
% end

% round(vp{1})
% round(vp{2})
% round(vp{3})

% yy = abs([vp{1}(2) vp{2}(2) vp{3}(2)]);
% xx = abs([vp{1}(1) vp{2}(1) vp{3}(1)]);
% [val,idx1] = max(yy);
% vvp = vp{idx1};
% [val,idx2] = max(xx);
% hvp = vp{idx2};
% 
% idx3 = find(1:3 ~= idx1 & 1:3 ~= idx2);
% 
% ovp = vp{idx3};


% vp = orderVP(vp,K(1:2,3));
% 
% vp{1} = vp{1}(1:2)';
% vp{2} = vp{2}(1:2)';
% vp{3} = vp{3}(1:2)';

% load('vp_seq1.mat');

vx = [1e15;size(img,1)/2;1];
vvp = [size(img,2)/2;-1e12;1];
vy = [size(img,2)/2+100;size(img,1)/2;1];

