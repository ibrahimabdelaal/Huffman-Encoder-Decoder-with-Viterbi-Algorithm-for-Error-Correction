   function [codeword ,symbol]=Huff_Encoder(sympols,p)

 p=p;
 a=sympols;
p=round(p(1:end),4);

node = struct('left',[],'right',[],'value',0,'p',0.0,'s',0,'in',0);
for i=1:length(a)
    node(i).p=p(i);
    node(i).in=i;
    node(i).left=0;
    node(i).right=0;
    node(i).s=a(i);
    
end
sortTemp=node;
 [x,in]=sort([sortTemp.p]);
    sortTemp=sortTemp(in);
    index=(in);
    j=1;count=length(a)+1;
while ~isempty(sortTemp)
             [x,in]=sort([sortTemp.p]);
           sortTemp=sortTemp(in);
            index=index(in);
            
            node(index(j)).value=count;
            node(index(j+1)).value=count;
             if(node(index(j)).p< node(index(j+1)).p)
            node(count).left=index(j); node(count).right=index(j+1);
            else
               node(count).left=index(j+1); node(count).right=index(j);
            end
            
            node(count).p= round(sortTemp(j).p+ sortTemp(j+1).p,4);
            node(count).in=count;
            
            sortTemp=sortTemp(3:end);    
            
            index=index(3:end);
            if(~isempty(sortTemp))
               
                
            sortTemp=[ node(count)  sortTemp];  
            
             index=[count  index];

             
       
            else
                break;
                
            end
            count=count+1;
            i=i+2;
            
            
end
        
node(length(node)).value=0;






C={};
s=[];
[C s]=codewords(node,p);
codeword=C ;symbol=s;
 end