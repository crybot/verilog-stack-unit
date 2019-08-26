/*
* Commutatore a 4 vie ciascuna da N bit
*/
module COMMUTATORE4(out, x1, x2, x3, x4, alpha);
  parameter N = 32;

  output [N-1:0]out;
  input [N-1:0]x1, x2, x3, x4;
  input [1:0]alpha;

  wire [N-1:0] k1out, k2out;

  COMMUTATORE2 #(N) k1(k1out, x1, x2, alpha[0]);
  COMMUTATORE2 #(N) k2(k2out, x3, x4, alpha[0]);
  COMMUTATORE2 #(N) k3(out, k1out, k2out, alpha[1]);

endmodule
