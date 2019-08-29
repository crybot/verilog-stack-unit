module test_po();
  reg clock = 0;
  reg alpha_k1 = 0, alpha_k2 = 0, alpha_k3 = 0, alpha_k4 = 0, alpha_k5 = 0, alpha_k_ind = 0, alpha_k_i = 0;
  reg alpha_k_esito = 0;
  reg alpha_k_dataout = 0;
  reg alpha_k_mem1 = 0, alpha_k_mem2 = 0;
  reg [2:0]alpha_alu2 = 0, alpha_alu3 = 0, alpha_alu4 = 0;
  reg beta_hd = 0, beta_ind = 0, beta_i = 0, beta_esito = 0;
  reg beta_datain = 0, beta_dataout = 0;
  reg beta_mem = 0;
  reg [31:0]datain = 0;
  reg [9:0]n = 0;

  wire signed [31:0]po_out;

  PO parte_operativa(po_out, 
    clock, 
    alpha_k1, alpha_k2, alpha_k3, alpha_k4, alpha_k5, 
    alpha_k_ind, 
    alpha_k_i,
    alpha_k_esito,
    alpha_k_dataout,
    alpha_k_mem1, alpha_k_mem2,
    alpha_alu2, alpha_alu3, alpha_alu4, 
    beta_hd, beta_ind, beta_i, beta_esito, beta_datain, beta_dataout, beta_mem,
    datain,
    n
  );

  always
  begin
    if (clock == 0)
      #40 clock = 1;
    else 
      #1 clock = 0;
  end


  initial
  begin
    $dumpfile("test_po.vcd");
    $dumpvars;
    #20;
    alpha_k_mem1 <= 0; // HD
    beta_mem <= 1;
    datain <= 10;
    beta_datain <= 1;
    #80;
    datain = 20;
    #500;
    $finish;
  end
endmodule

