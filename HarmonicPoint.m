function d=HarmonicPoint(a,b,c,o)

%     o = [randi(10,2,1);1];
    p = (o+c)/2;
    
    
    oa = int2Points(o,a);
    ob = int2Points(o,b);
    pa = int2Points(p,a);
    pb = int2Points(p,b);
    ab = int2Points(a,b);
    
    ahat = int2Lines(pb,oa);
    bhat = int2Lines(pa,ob);
    ahbh = int2Points(ahat,bhat);
    d = int2Lines(ahbh,ab);
    d = d/d(3);
end