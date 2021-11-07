close all;
clear all;
% addpath('Utils');
% addpath('vanishing-points');
% addpath('vp_computation');
% addpath('geometry');
img_dir = 'F:\burglary project\sequences';
% seq = 1;
global debug;
ref_height = 2.082;  % In meters
ref_width = 0.77;  % In meters
ref_border_width = 5.5;  % In meters

threshVec = [0.25,0.95,0.85,0.6,0.6,0.6,0.85];
shadowthreshVec = [0.1,0.2;0.1,0.2;0.2,0.3;0.1,0.2;0.1,0.2;0.1,0.2;0.1,0.2];
startframes=[15,1,1,1,1,1,70];
endframes= [100,80,150,170,140,150,200];
resize_ratio = 0.25;
debug = 0;
    
heights = cell(1,7);
widths = cell(1,7);
rects = cell(1,7);

for seq=3:3

    h = zeros(1,endframes(seq)-startframes(seq));
    w = zeros(1,endframes(seq)-startframes(seq));
    brects = cell(1,endframes(seq)-startframes(seq));
    
    for k=startframes(seq):endframes(seq)

       j =  k-startframes(seq)+1;
       img = imresize(imread([img_dir '\' num2str(seq) '\' sprintf('%04d.jpeg',k)]),resize_ratio);

        if(k == startframes(seq))
%                 rimg = rgb2gray(img);
                rimg = img;
%                 extract_lines;
                
                
                estimateVPS;

                figure;
                imgH = imagesc(img);
                imgAxes = gca;
                axis off;
                disp('choose top of reference object');
                tref = ginput(1);
                tref = [tref 1]';
                disp('choose bottom of reference object');
                bref = ginput(1);
                bref = [bref 1]';
                disp('choose left of reference object');
                lref = ginput(1);
                lref = [lref 1]';
                disp('choose right of reference object');
                rref = ginput(1);
                rref = [rref 1]';

       else

        if(seq==3)
            [tobj,bobj,rect]=getObjectPoints(rimg,img,threshVec(seq),0,shadowthreshVec(seq,:));
        else
           [tobj,bobj,rect]=getObjectPoints(rimg,img,threshVec(seq),0);
        end
           top = [tobj 1]';
           bot =  [bobj 1]';
           left = [rect(1);rect(2)+rect(4)/2;1];
           right = [rect(1)+rect(3);rect(2)+rect(4)/2;1];
           
           if(top(1)>0 && bot(1)>0)
               %%  Finding image of reference top 
    %            tvp = int2Points(hvp,vvp);
    %            tvp = (tvp/tvp(3))';
    %            van_line = int2Points(hvp,ovp);
               van_line = int2Points([0;size(img,1)/2;1],[size(img,2)/2;size(img,1)/2;1]);
               van_line = van_line/van_line(3);
               bbr_line = int2Points(bref,bot);
               bbr_line = bbr_line/bbr_line(3);
               q = int2Lines(van_line,bbr_line);
               q = q/q(3);
               tref_q_line = int2Points(tref,q);
               vvp_bot_line = int2Points(vvp,bot);
               i = int2Lines(tref_q_line,vvp_bot_line);
               i = i / i(3);
    %            i =  cross(cross(vvp,bot),(cross(tref,cross(van_line,cross(bref,bot)))));
    %%          Finding image of reference right for width
               van_line2 = int2Points(vy,vvp);
               van_line2 = van_line2/van_line2(3);
               llr_line = int2Points(lref,left);
               llr_line = llr_line/llr_line(3);
               M = int2Lines(van_line2,llr_line);
               M = M/M(3);
               rref_M_line = int2Points(rref,M);
               vx_left_line = int2Points(vx,left);
               N = int2Lines(rref_M_line,vx_left_line);
               N = N / N(3);

               %% finding image distance
               dpb = sqrt((vvp(1)-bot(1)).^2+(vvp(2)-bot(2)).^2);
               dib = sqrt((i(1)-bot(1)).^2+(i(2)-bot(2)).^2);
               dtb = sqrt((top(1)-bot(1)).^2+(top(2)-bot(2)).^2);

               %% Finding distances for width

               dvl = sqrt((vx(1)-left(1)).^2+(vx(2)-left(2)).^2);
               dNl = sqrt((N(1)-left(1)).^2+(N(2)-left(2)).^2);
               drl = sqrt((right(1)-left(1)).^2+(right(2)-left(2)).^2);


               %% building homography matrices for height and width

               H = [ref_height*(dpb-dib) 0;-dib dpb*dib];

               Hw = [ref_width*(dvl-dNl) 0;-dNl dvl*dNl];

               %% Compute Human Height and width

               s = H * [dtb;1];
               h(j) = abs(s(1)/s(2));

               s2 = Hw * [drl;1];
               w(j) = abs(s2(1)/s2(2));

               axes(imgAxes); cla;
               imgH=imagesc(img); hold on;
               axis off;
               mean_h = mean(h(h>0));
               if(abs(h(j)-mean_h)>0.4*mean_h && length(find(h))>5 || h(j)>ref_height)
                   h(j)=mean(h(h>0));
                   drawnow();
                   continue;
               end
                   rectangle('Position',rect,'EdgeColor','b','LineWidth',2);
        %            hline(cross(top,bot),'magenta');
                   plot([top(1) bot(1)],[top(2) bot(2)],'m-','LineWidth',2);
                   text(top(1),top(2),['\color{magenta}' num2str(h(j)) 'm'],'FontSize',20,'FontWeight','bold')
        %            hline(cross(left,right),'green');
                   plot([left(1) right(1)],[left(2) right(2)],'g-','LineWidth',2);
                   text(left(1),left(2),['\color{green}' num2str(w(j)) 'm'],'FontSize',20,'FontWeight','bold')
               drawnow()
               brects{j} = rect;

           end
    %        upd_img = getframe(imgH);
    %        saveas(imgH,[img_dir '\results\seq' num2str(seq) '_' sprintf('%04d.jpg',k)]);
       end

       j = j + 1;
    end
    
    heights{seq} = h;
    widths{seq} = w;
    rects{seq} = brects;
end

save('results.mat','heights','widths','rects');