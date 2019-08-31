module test_po();
  // segnale di clock
  reg clock;

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
  wire rdy, ack;
  wire op_out;
  wire eq, ge, hd0, or_hd, or10_hd;

  // ingressi
  reg [31:0]datain = 0;
  reg [9:0]n = 0;
  reg [2:0]op = 0;
  reg rdy_in = 0;

  wire signed [31:0]po_out;

  PO parte_operativa(
    // output
    po_out,
    rdy,
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
    rdy_in
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
    rdy,
    ack,
    op,
    eq,
    ge,
    hd0,
    or_hd,
    or10_hd
  );

  always
  begin
    if (clock == 0)
      #25 clock = 1;
    else 
      #1 clock = 0;
  end


  initial
  begin
    $dumpfile("test_po.vcd");
    $dumpvars;
    datain <= 1023;
    rdy_in <= 1;
    #26 datain--;
    #26 datain--;
    #26 datain--;
    #26 datain--;
    #26 datain--;
    #100;
    rdy_in <= 0;
    op <= 1;

    #1000;
    $finish;
  end
endmodule

