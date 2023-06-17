
clear
clc
close all;
file = fopen('test.txt','r');  %open the file to read data
data = fscanf(file,'%c');   %scan the characters in the file
fclose(file);

%%
%(1)calculate probability
ascii = double(data);  %convert each characters into its ascii value 
length_data = length(ascii);   %get the length of the data 
occurence = zeros(1,128); %vector to count the occurence of each char
for i = 0 : 127  %for loop to count the frequency of each chatacter
    count = 0;
for j = 1 : length_data
    if(ascii(j) == i)
        count = count + 1;
    end
end
   occurence(i+1) = count;
end
index = find(occurence)-1;  %get the indices of non zero elements 
s=0:127;
s=s(index+1);
symbol_count = occurence(index+1); % array containing the frequency of the existing characters
symbol_probability = symbol_count / length_data;  %array of probabilities of each character existing in the data
len = length(symbol_probability); %length of probability array


%%
%(2)calculating the entropy

entropy = 0;
for  j = 1 : length(symbol_probability)   %looping over the length of the chars which equal to numbers of symbols
    entropy = entropy + (-symbol_probability(j)*log2(symbol_probability(j)));  % Calculating the Entropy
end
disp('The Entropy = ');
disp(entropy);

%%(3)fixed length code
%For fixed length code we need log2(M) ,M number of symbols

bits_per_symbol = ceil(log2(length(symbol_probability)));  %number of bits/symbols required to construct a fixed length code
efficiency = entropy / bits_per_symbol;  %calculate the code efficiancy
disp('the number of bits/symbol = ');
disp(bits_per_symbol);
disp('the fixed length code efficiency = ');
disp(efficiency);

%% (4)Huffman encoder
code = [];
ind = [];
[o,m]=sort(symbol_probability);
symbol_probability=symbol_probability(m);
s=s(m);
[code,symbols] =Huff_Encoder(s,symbol_probability);
%Display codes and indices.
disp('The characters and codes are:')
    for i = 1 : len
         disp ([char(symbols(i)) , code(1,i)]);
    end
%encode the file and create text file for the stream of bits
encoder = fopen('encoded_file1.txt','w'); %create a file to write in
for i = 1 : length(data)
    for j = 1 : length(symbols)
       if data(i) ==  char(symbols(j))
          fwrite(encoder,char(code(1,j))); %write the corresponding codeword in the file
          break;
       end
       
    end
end
fclose(encoder);

%% Channel Ecnoder
file_2 = fopen('encoded_file1.txt','r');
bitstream = fscanf(file_2,'%c');
fclose(file_2);
[channel_encoded,states ]=Conv_encoder(char(bitstream));



%% adding noise
SNR=0:2:15;BER_HUFF=[];BER_CH=[];
for counter=1:length(SNR)
channel_message=char(channel_encoded);
Huff_message=char(bitstream);
message_int1=[];
message_int2=[];
for i=1:length(channel_message)     %%convert message from char to numbers to add awgn
    message_int1(i)=str2num(channel_message(i))    ;
    if(i<=length(Huff_message))
    message_int2(i)=str2num(Huff_message(i))  ;
    end
end

ch_noisy_mssag=awgn((message_int1),SNR(counter),'measured');
Huff_noisy_mssag=awgn((message_int2),SNR(counter),'measured');

ch_noisy_message="";
Huff_noisy_mssage="";
for i=1:length(ch_noisy_mssag)         %%thresholds 
    if(ch_noisy_mssag(i)>0.500)
        ch_noisy_mssag(i)=1;
    else
        ch_noisy_mssag(i)=0;
        
    end
    if (i<=length(Huff_noisy_mssag))
     if(Huff_noisy_mssag(i)>0.500)
        Huff_noisy_mssag(i)=1;
    else
        Huff_noisy_mssag(i)=0;
        
    end
    end
    ch_noisy_message=append(ch_noisy_message,num2str(  ch_noisy_mssag(i)));
     if (i<=length(Huff_noisy_mssag))
    Huff_noisy_mssage=append( Huff_noisy_mssage,num2str( Huff_noisy_mssag(i)));
     end
end

%%converting back to char




%%


%first decoding the channel encoed message
rec_channel=Matrix_Decoder(char(ch_noisy_message),states);
orig_mss=Digram_encoder(states,char(rec_channel),1);

%%
orig_mss=char(orig_mss);
for i=1:length(orig_mss)     %%convert message from char to numbers to add awgn
%     disp(length(message));
    ch_int(i)=str2num(orig_mss(i))    ;
end
 wch_int=[];
noisy_message= char(Huff_noisy_mssage);
for i=1:length((noisy_message))     %%convert message from char to numbers to add awgn
    wch_int(i)=str2num(noisy_message(i))    ;
end
% t= huffman_decoder(symbols,code,char(noisy_message));
% disp('            recieved_textwithout channel');
% disp(t);
% text_message_huffman= huffman_decoder(symbols,code,char(noisy_message));
% disp('            recieved_textwithout channel');
% disp(text_message_huffman);
Text_msg_channel= huffman_decoder(symbols,code,char(orig_mss));
disp('            recieved_textwith channel');
disp(Text_msg_channel);
%comparing the two texts
char_error=[]; %%%to store chars tha recieved with error
error_index=[]; %% to store theie index
text_original=char(data);
for k=1: length(char(data))
    if(k<=length(Text_msg_channel))
     if (text_original(k)~=Text_msg_channel(k))
      
      char_error=[char_error text_original(k)];
      error_index=[error_index k];
     end
    else
       char_error=[char_error text_original(k)];
      error_index=[error_index k];
    end
  end

fprintf('SNR =%d ,NUmber of errors in recieved msg = %d.\n', [length(char_error),SNR(counter)]);
disp(' errors in chars :');
disp(char_error);
disp(error_index);




 [number1,ratio1] = biterr( message_int2, ch_int);
[number2,ratio2] = biterr( message_int2, wch_int);
BER_HUFF=[BER_HUFF ratio2 ];BER_CH=[BER_CH ratio1];
end
%%

figure()


semilogy((SNR),(BER_CH));
hold on
semilogy((SNR),(BER_HUFF));
ylim([10^-2 1])

ylabel('BER Error Ratio ');
xlabel('SNR');
title('BER Ratio vs SNR');
legend('CHANNELERORR','WITHOUTCHANNEL');
% disp('ratios : ');
%%
%comaring twotext files 



average_len = 0;
probabilities = sort(symbol_probability);
for i = 1 : len
    y=length(char(code(1,i))); %get the length of the codeword
    x = probabilities(i) * y; % multiplicate the probability with the codeword length
    average_len = average_len + x; %sum to get the average length
end

efficiency_huffman = entropy / average_len;  %calculate the code efficiancy of huffman
disp('the huffman code efficiency = ');
disp(efficiency_huffman);