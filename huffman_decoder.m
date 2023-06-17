function [message] = huffman_decoder(chars,code,bit_stream)
n=length(chars);
lengths=[];
for i=1:n
    len=length(char(code(i)));
    lengths=[lengths len];   %array of codeword lengths
end
max_len=max(lengths);    %get the maximum codeword length
message='';
stream_len=length(bit_stream);  %get the length of the bit stream
i=1;
while i<=stream_len    %take the bitstream char by char and check for matching
    j=0;
    while j<max_len    %search for matching of bits in all codewords until we reach maximum length of the codeword or match is found
        if (i+j>stream_len)
            break;
        end
        c=bit_stream(i:i+j);
       
        index=1;
        while (index<=n && ~isequal(char(code(index)),c))  %check if the codeword matches any of the characters
            index=index+1;
        end
        if index<=n
            message=[message char(chars(index))];    %array of message characters add one in each loop itiration
%            
            break;
        else
            j=j+1;
        end
       
    end
    i=i+j+1;
end