%%stateDiagram encoder
function [encoded_message]=Digram_encoder(state,message,s) 
%%switch =0 to get the convolunaional code
%switch =1 to get the input message
  
       message=(message);
       encoded_message="";
        current_state=state(1) ;  %knowng tht root node =1;
   if(s==0)
        i=1;
       while i<=length(message)
            if(message(i)=='0')   %%go right and get the output
                encoded_message=append(encoded_message,current_state.r_value);
                current_state=state(current_state.r_state+1);
               
            else
                  %%go leftt and get the output
               encoded_message=append(encoded_message,current_state.l_value);
               current_state=state(current_state.l_state+1);
            end
                
                
                i=i+1;
            end
            
   else
       
              i=1;
              message=char(message);
              
       while i<=length(message)
            if(message(i:i+2)==char(current_state.r_value))   %%go right and get the output
                encoded_message=append(encoded_message,"0");
                current_state=state(current_state.r_state+1);
               
            else
                  %%go leftt and get the output
               encoded_message=append(encoded_message,"1");
               current_state=state(current_state.l_state+1);
            end
                
                
                i=i+3;
            end
            
            
   end
            
end