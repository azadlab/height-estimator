function cmap=draw_lines(lines1)

%         cmap = lines(size(lines1,1));
        cmap = distinguishable_colors(size(lines1,1));
        hold on;
        for l=1:size(lines1,1)
            line(lines1(l,1:2),lines1(l,3:4),'Color',cmap(l,:),'LineWidth',3);
        end
        hold off;

end