close all;
clear all;

img_dir = 'F:\burglary project\sequences';
load('results.mat');
startframes=[1,1,1,1,1,1,70];
endframes= [245,243,326,302,288,303,331];
bestframes= [66,72,120,126,87,114,86];
vidObj = VideoWriter('result');
vidObj.FrameRate = 30;
open(vidObj);


for seq=1:7

    h = heights{seq};
    w = widths{seq};
    h(abs(h)>2)=0;
    h(abs(w)>1)=0;
    
    brects = rects{seq};
    for k=startframes(seq):endframes(seq)

       img = imread([img_dir '\' num2str(seq) '\' sprintf('%04d.jpeg',k)]);

               j =  k-startframes(seq)+1;
               
             if(k == startframes(seq) && seq==1)
                 
                 imgH=imagesc(img); hold on;
                 truesize;
                 imgAxes = gca;
                 axis off;

             else
               axes(imgAxes); cla;
               imgH=imagesc(img); hold on;
               axis off;
             end
               
               
               if(j == bestframes(seq))
                   
                   rect = brects{j};
                    top = [rect(1)+rect(3)/2 rect(2)];
                    bot = [rect(1)+rect(3)/2 rect(2)+rect(4)];
                    left = [rect(1) rect(2)+rect(4)/2];
                    right = [rect(1)+rect(3) rect(2)+rect(4)/2];
%                    rectangle('Position',rect,'EdgeColor','b','LineWidth',2);
        %            hline(cross(top,bot),'magenta');
                   plot([top(1) bot(1)],[top(2) bot(2)],'m-','LineWidth',2);
                   text(top(1),top(2),['\color{magenta}' sprintf('%.1f  +/- %.2f',h(j)*100,var(h(h>0))*100) 'cm'],'FontSize',20,'FontWeight','bold')
        %            hline(cross(left,right),'green');
                   plot([left(1) right(1)],[left(2) right(2)],'g-','LineWidth',2);
                   text(left(1),left(2),['\color{green}' sprintf('%.1f  +/- %.1f',w(j)*100,var(w(w>0))*100) 'cm'],'FontSize',20,'FontWeight','bold')
                   drawnow()
                   for i=1:vidObj.FrameRate*2
                       
                       frame = getframe;
                       writeVideo(vidObj,frame);
                       
                   end
                   
               end
    j = j + 1;
    frame = getframe;
    writeVideo(vidObj,frame);
    end
   
end

close(vidObj);
