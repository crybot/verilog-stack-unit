module PO(
  // output della rete
  output wire [ALU_SIZE-1:0]dataout_out,
  // variabili di condizionamento
  output wire rdy,
  output wire ack,
  output wire [2:0]op_out,
  output wire eq_out, // eq(I, N)
  output wire ge, // segno(HD - N)
  output wire hd0,
  output wire or_hd,
  output wire or10_hd,

  // clock
  input clock, 
  // alpha
  input alpha_k1, 
  input alpha_k2, 
  input alpha_k3, 
  input alpha_k4, 
  input alpha_k5, 
  input alpha_k_ind,
  input alpha_k_i,
  input alpha_k_esito,
  input alpha_k_dataout,
  input alpha_k_mem1, alpha_k_mem2,
  input [2:0]alpha_alu2, 
  input [2:0]alpha_alu3, 
  input [2:0]alpha_alu4, 
  // beta
  input beta_hd,
  input beta_ind,
  input beta_i,
  input beta_esito,
  input beta_datain,
  input beta_dataout,
  input beta_rdyin,
  input beta_ackout,
  input beta_mem,
  // altri input
  input [ALU_SIZE-1:0]datain_val,
  input [9:0]n_val,
  input [2:0]op_in,
  input rdy_in
);

  parameter ALU_SIZE = 32;
  parameter K1_SIZE = 32;
  parameter K2_SIZE = 32;
  parameter K3_SIZE = 11;
  parameter K4_SIZE = 11;
  parameter K5_SIZE = 11;
  parameter K_IND_SIZE = 10;
  parameter K_I_SIZE = 10;
  parameter K_ESITO_SIZE = 1;

  /******* CONNESSIONI ********/
  // registri
  wire [10:0]hd_out;
  wire [K_IND_SIZE-1:0]ind_out;
  wire [K_I_SIZE-1:0]i_out;
  wire [K_ESITO_SIZE-1:0]esito_out;
  wire [ALU_SIZE-1:0]datain_out;
  wire [9:0]n_out;

  // commutatori
  wire [K1_SIZE-1:0]k1_out;
  wire [K2_SIZE-1:0]k2_out;
  wire [K3_SIZE-1:0]k3_out;
  wire [K4_SIZE-1:0]k4_out;
  wire [K5_SIZE-1:0]k5_out;
  wire [K_IND_SIZE-1:0]k_ind_out;
  wire [K_I_SIZE-1:0]k_i_out;
  wire [K_ESITO_SIZE-1:0]k_esito_out;
  wire [ALU_SIZE-1:0]k_dataout_out;
  wire [10:0]k_mem1_out, k_mem2_out;

  // alu
  wire [ALU_SIZE-1:0]alu1_out, alu2_out, alu3_out, alu4_out;
  wire alu2_segno, alu3_segno, alu4_segno;

  // memoria
  wire [31:0]mem_out1, mem_out2;
  /****************************/


  /******* COMPONENTI *********/
  // registri
  REGISTRO#(11) hd(hd_out, alu3_out, clock, beta_hd);
  REGISTRO#(10) ind(ind_out, k_ind_out, clock, beta_ind);
  REGISTRO#(10) i(i_out, k_i_out, clock, beta_i);
  REGISTRO#(3) esito(esito_out, k_esito_out, clock, beta_esito);
  REGISTRO#(ALU_SIZE) datain(datain_out, datain_val, clock, 1'b1); // TODO: beta sempre = 1?
  REGISTRO#(ALU_SIZE) dataout(dataout_out, k_dataout_out, clock, beta_dataout);
  REGISTRO#(10) n(n_out, n_val, clock, 1'b1); //TODO: beta sempre = 1?
  REGISTRO#(3) op(op_out, op_in, clock, 1'b1); //TODO: beta sempre = 1?

  // commutatori
  COMMUTATORE2#(K1_SIZE) k1(k1_out, mem_out1, dataout_out, alpha_k1);
  COMMUTATORE2#(K2_SIZE) k2(k2_out, mem_out2, n_out, alpha_k2);
  COMMUTATORE2#(K3_SIZE) k3(k3_out, hd_out, ind_out, alpha_k3);
  COMMUTATORE2#(K4_SIZE) k4(k4_out, hd_out, i_out, alpha_k4);
  COMMUTATORE2#(K5_SIZE) k5(k5_out, 1, 2, alpha_k5);
  COMMUTATORE2#(K_IND_SIZE) k_ind(k_ind_out, alu4_out, alu3_out, alpha_k_ind);
  COMMUTATORE2#(K_I_SIZE) k_i(k_i_out, 1, alu4_out, alpha_k_i);
  COMMUTATORE2#(K_ESITO_SIZE) k_esito(k_esito_out, 0, 1, alpha_k_esito);
  COMMUTATORE2#(ALU_SIZE) k_dataout(k_dataout_out, mem_out1, alu2_out, alpha_k_dataout);

  COMMUTATORE2#(11) k_mem1(k_mem1_out, hd_out, alu3_out, alpha_k_mem1);
  COMMUTATORE2#(11) k_mem2(k_mem2_out, alu4_out, ind_out, alpha_k_mem2);

  // alu
  ALU#(ALU_SIZE) alu1(alu1_out, ge, hd_out, n_out, 1); // calcola segno(HD - N) === ge(HD, N)
  ALU#(ALU_SIZE) alu2(alu2_out, alu2_segno, k1_out, k2_out, alpha_alu2);
  ALU#(ALU_SIZE) alu3(alu3_out, alu3_segno, k3_out, 1, alpha_alu3);
  ALU#(ALU_SIZE) alu4(alu4_out, alu4_segno, k4_out, k5_out, alpha_alu4);

  // comparatore
  CONFRONTATORE_N#(K_I_SIZE) eq(eq_out, i_out, n_out);

  // memoria
  MEMORIA#(1024, 32) mem(mem_out1, mem_out2, datain_out, k_mem1_out, k_mem2_out, clock, beta_mem);

  // interfacce a transizione di livello
  TRANSIZIONE_LIVELLO ackout(ack, 1'b0, clock, beta_ackout); // in=0 trasforma ackout in un contatore modulo 2
  TRANSIZIONE_LIVELLO rdyin(rdy, rdy_in, clock, beta_rdyin);
  /****************************/


  /*****CALCOLO VARIABILI DI CONDIZIONAMENTO******/
  assign hd0 = hd_out[10]; // bit piu` significativo di HD
  assign or_hd = | hd_out; // or unario di HD
  assign or10_hd = | hd_out[10:1]; // or unario dei 10 bit piu` significativi di HD
  /***************************************/

endmodule
