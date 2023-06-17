
 function [encoded_messge,states ]=Conv_encoder(text)
%%%circuit_logic 
%%we have four possible states 



s0="00";
s1="10";
s2="01";
s3="11";
s=[s0 s1 s2 s3];

%%%output generator polynomials are u1,u2,u3 ->such that 
%u1 is modulo2addition for all the 3 bits(he current one and elder 2)
%u2 is the modul2addition for the first bit and the last one
%u3 is he modulo2addition for the las 2bits

statee='00' ; % which s0
%generating the state digrame 
state = struct('r_state',0,'l_state',0,'r_value',"",'l_value',"",'state_value',0);
i=1; case1='0';case2='1';
while i<=4
     statee=char(s(i));
     state(i).state_value=i-1;
    %case 1 currentbit=0
%     state=['0' state(1:2)]
    tempu1=xor(0,str2num(statee(1)));
    u1=xor(str2num(statee(2)), tempu1);
    u2=xor(0, str2num(statee(2)));
    u3=xor(str2num(statee(1)), str2num(statee(2)));
    state(i).r_value = convertCharsToStrings([ num2str(u1) num2str(u2) num2str(u3)]);
%    state(i).r_value = convertCharsToStrings([ num2str(u1) num2str(u2)]);
    temp1=['0' statee(1)];
    for(j=1:length(s))
        if(s(j)==temp1)
             state(i).r_state=j-1;
             break;
        end
    end
     %currentbit=1
    
    tempu1=xor(1,str2num(statee(1)));
    u1=xor(str2num(statee(2)), tempu1);
    u2=xor(1, str2num(statee(2)));
    u3=xor(str2num(statee(1)), str2num(statee(2)));
    state(i).l_value = convertCharsToStrings([ num2str(u1) num2str(u2) num2str(u3)]);
    temp2=['1' statee(1)];
    for  j=1:length(s)
        if(s(j)==temp2)
             state(i).l_state=j-1;
             break;
        end
    end
    i=i+1;
    
end
% text='111';
encoded_messge=char(Digram_encoder(state,text,0));
states=state;
% [ recovered_message]=Matrix_Decoder(encoded_messge,state);
% orig_mss=Digram_encoder(states,char(recovered_message),1);
 end

