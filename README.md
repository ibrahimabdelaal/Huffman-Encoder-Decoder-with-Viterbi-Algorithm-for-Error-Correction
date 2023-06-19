# Huffman-Encoder-Decoder-with-Viterbi-Algorithm-for-Error-Correction

This repository contains an implementation of a Huffman Encoder-Decoder with Viterbi Algorithm for error correction in MATLAB. The system is designed to handle the transmission of messages through a noisy channel.

The workflow of the system is as follows:

Huffman Encoding: The input message in text format is encoded using the Huffman coding algorithm. 

Huffman coding assigns shorter codes to more frequently occurring characters, resulting in efficient encoding.

Noisy Channel Simulation: The encoded message is passed through a simulated noisy channel. The noisy channel introduces random errors into the transmitted message, simulating real-world transmission conditions.

Viterbi Algorithm: The Viterbi algorithm is employed to correct errors introduced by the noisy channel. The Viterbi algorithm uses a dynamic programming approach to find the most likely sequence of transmitted symbols given the received noisy sequence.

Huffman Decoding: The corrected sequence is decoded back into the original message using the Huffman decoding algorithm. Huffman decoding reverses the encoding process, reconstructing the original message from the encoded sequence.

This implementation provides a comprehensive solution for error correction in a noisy channel using Huffman encoding and the Viterbi algorithm. MATLAB is used as the programming language for this implementation.

To use the system, simply provide your input message in text format. The implementation will handle the encoding, transmission through the noisy channel, error correction using the Viterbi algorithm, and decoding to recover the original message.


Usage

provide the your message in .txt file.

Change the path of the message in huffman.m and run it  

![image](https://github.com/ibrahimabdelaal/Huffman-Encoder-Decoder-with-Viterbi-Algorithm-for-Error-Correction/assets/49596777/0936ed8d-4304-4c34-aed4-461fe2dce714)



