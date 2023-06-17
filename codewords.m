function [codeword ,symbol]=codewords(node,p)
          
          index=[];
         sortTemp=node;nn=[];
         [x,inn]=sort([sortTemp.left]);
         sortTemp=sortTemp(inn);
         sortTemp=sortTemp(1:length(p));
         disp(sortTemp);
         index=inn;s=[];
         index=index(1:length(p));
         i=1; C = cell(1,length(p));c=1;  %%left 0 ,right 1
         
         for j=1:length(p)
             s(length(s)+1)=sortTemp(j).s;
              pnode=sortTemp(j);temp=sortTemp(j).in;
              code='';
         while pnode.value~=0      %%stop when reachimg the root
               pnode=node(pnode.value); %% update the parent
             if(pnode.left==temp)
                 code=strcat('1',code);
             else
               code=strcat('0',code);
             end
            
             temp=(pnode.in);%%update temp
              
             
             
              
             
         end
%           nn=[nn code];
          C(1,j)={code};
         
         end
         codeword=C;symbol=s;
end
