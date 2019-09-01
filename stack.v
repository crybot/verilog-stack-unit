module STACK(
  output [31:0]dataout, 
  output esito, 
  output ack,
  input rdy,
  input [2:0]op,
  input [31:0]datain,
  input [9:0]n,
  input clock
);

  // var. di controllo
  wire alpha_k1, alpha_k2, alpha_k3, alpha_k4, alpha_k5, alpha_k_ind, alpha_k_i;
  wire alpha_k_esito;
  wire alpha_k_dataout;
  wire alpha_k_mem1, alpha_k_mem2;
  wire [2:0]alpha_alu2, alpha_alu3, alpha_alu4;
  wire beta_hd, beta_ind, beta_i, beta_esito;
  wire beta_datain, beta_dataout;
  wire beta_rdyin, beta_ackout;
  wire beta_mem;

  // var. di condizionamento
  wire rdy_in;
  wire op_out;
  wire eq, ge, hd0, or_hd, or10_hd;

  PO parte_operativa(
    // output
    dataout,
    esito,
    rdy_in,
    ack,
    op_out,
    eq,
    ge,
    hd0,
    or_hd,
    or10_hd,
    // input
    clock, 
    alpha_k1, alpha_k2, alpha_k3, alpha_k4, alpha_k5, 
    alpha_k_ind, 
    alpha_k_i,
    alpha_k_esito,
    alpha_k_dataout,
    alpha_k_mem1, alpha_k_mem2,
    alpha_alu2, alpha_alu3, alpha_alu4, 
    beta_hd, beta_ind, beta_i, beta_esito, beta_datain, beta_dataout, 
    beta_rdyin, beta_ackout,
    beta_mem,
    datain,
    n,
    op,
    rdy
  );

  PC parte_controllo(
    // output
    alpha_k1, alpha_k2, alpha_k3, alpha_k4, alpha_k5, 
    alpha_k_ind, 
    alpha_k_i,
    alpha_k_esito,
    alpha_k_dataout,
    alpha_k_mem1, alpha_k_mem2,
    alpha_alu2, alpha_alu3, alpha_alu4, 
    beta_hd, beta_ind, beta_i, beta_esito, beta_datain, beta_dataout, 
    beta_rdyin, beta_ackout,
    beta_mem,
    // input
    clock, 
    rdy_in,
    ack,
    op,
    eq,
    ge,
    hd0,
    or_hd,
    or10_hd
  );

endmodule

