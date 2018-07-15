function [op_time, sequence,pers] = changeover(products,time,demand)
x=perms(products);
x=[x,x(:,1)];
y=zeros(size(x,1),size(x,2)-1);
for i=1:size(x,1)
    for j=1:size(x,2)-1
        for k=1:length(products)
            for l=1:length(products)
                if x(i,j)==products(k) && x(i,j+1)==products(l)
                   y(i,j)=time(k,l);
                end
            end
        end
    end
end
op_time=min(sum(y,2));
s=0;
for i=1:size(y,1)
    if sum(y(i,:))==op_time
        s=i;
    end
end
sequence=string;
for w=1:length(products)+1
sequence{1,w}=x{s,w};
end
sequence(end)=[];        
perseq=zeros(1,length(sequence));
lcm=sum(sum(demand,2)./demand,2);
for u=1:length(perseq)
    for v=1:length(perseq)
        if sequence(u)== products(v)
            perseq(u)=floor(demand(v)/sum(demand,2)*lcm);
        end
    end
end
pers=zeros(1,length(perseq));
a=perseq(1);
for i=1:length(perseq)
    a=gcd(a,perseq(i));
end
for u=1:length(perseq)
    pers(u)=perseq(u)/a;
end
end


