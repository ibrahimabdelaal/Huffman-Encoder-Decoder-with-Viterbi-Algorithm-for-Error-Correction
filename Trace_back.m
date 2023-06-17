function [decoded_messages]=Trace_back(s,state)

%%funcion_to_trace the best road and decode the message
 [~,c]=size(s);
 last_coll=s(:,c);
 co=1;
 
  for k=1:4
      if (last_coll(k,1).created==1)
      d=last_coll(k,1);
      last_col(co,1)=d;
      co=co+1;
      end
      
      
      
  end
  min_cost=min([last_col.cost]);        %%gtting the node with the minimuum cost
%   disp(min_cost);
   cost_index= find([last_col.cost]==min_cost);
%    disp(cost_index)
   best_path=last_col(cost_index);      %%best path is the one with the minmum cost ((if more than one ,pick he firs one)
    best_path= best_path(1,1);
    child_state=cost_index(1,1);
%     disp(cost_index)
    s_node=best_path.parent;
%     disp(s_node);
    pnode=s(s_node,length(s(1,:))-1);
    current_column=length(s(1,:));
    decoded_message="";
    %Tracing pac through the mtrix
    while current_column>1
        if(state(s_node).r_state+1==child_state)
             decoded_message=append(state(s_node).r_value,(decoded_message));
        else
            decoded_message=append(state(s_node).l_value,(decoded_message));
        end
        child_state=s_node;
        current_column=current_column-1;
        s_node=s(s_node,current_column).parent;
        
        
        
        
        
        
        
    end
    decoded_messages=decoded_message;
end