%%shot#3
function [ recovered_message]=Matrix_Decoder(encoded_message,state)
s = struct('cost',0,'parent',0,'created',0);    %node to hold some infomaion
s=[];

s(1,1).cost=0;   s(1,1).parent=0;   s(1,1).created=1; %%root node (intial state)
c=1;        %colun counter
n=1;
while n<length(encoded_message)
    current_bits=encoded_message(n:n+2);
    
     for j=1:4            %%intiliaze the new nodes
        
        s(j,c+1).created=0;
         s(j,c+1).cost=0;
     end
   
    
 for i=1:length(s(:,c))
     
     parent_cost=s(i,c).cost;
     right_cost=cost_function(current_bits,state(i).r_value);
     left_cost=cost_function(current_bits,state(i).l_value);
     
     %creating right node
     if (s((state(i).r_state+1),(c+1)).created==1)        %%%check if another path ended on it
         if(parent_cost+right_cost<s(state(i).r_state+1,(c+1)).cost)   %%comparing cost of the two paths
              s(state(i).r_state+1,(c+1)).cost=parent_cost+right_cost;
              s(state(i).r_state+1,(c+1)).parent=i; 
               
         end
           
     else
        s((state(i).r_state+1),(c+1)).cost=parent_cost+right_cost;
        s(state(i).r_state+1,(c+1)).parent=i;
        s(state(i).r_state+1,(c+1)).created=1;
     end
     %creating left node
     if (s(state(i).l_state+1,(c+1)).created==1) 
         if(parent_cost+left_cost<s(state(i).l_state+1,(c+1)).cost)
              s(state(i).l_state+1,(c+1)).cost=parent_cost+left_cost;
              s(state(i).l_state+1,(c+1)).parent=i; 
             
         end
     else
          s(state(i).l_state+1,(c+1)).cost=parent_cost+left_cost;
          s(state(i).l_state+1,(c+1)).parent=i;
          s(state(i).l_state+1,(c+1)).created=1;
     end
    
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
    
 end   
   c=c+1;n=n+3;
end

% disp(s);
 recovered_message=Trace_back(s,state);
% recovered_message='122222';

end





