module PC(
  // alpha
  output reg alpha_k1 = 0, 
  output reg alpha_k2 = 0, 
  output reg alpha_k3 = 0, 
  output reg alpha_k4 = 0, 
  output reg alpha_k5 = 0, 
  output reg alpha_k_ind = 0,
  output reg alpha_k_i = 0,
  output reg alpha_k_esito = 0,
  output reg alpha_k_dataout = 0,
  output reg alpha_k_mem1 = 0,
  output reg alpha_k_mem2 = 0,
  output reg [2:0]alpha_alu2 = 0, 
  output reg [2:0]alpha_alu3 = 0, 
  output reg [2:0]alpha_alu4 = 0, 
  // betareg 
  output reg beta_hd = 0,
  output reg beta_ind = 0,
  output reg beta_i = 0,
  output reg beta_esito = 0,
  output reg beta_datain = 0,
  output reg beta_dataout = 0,
  output reg beta_rdyin = 0,
  output reg beta_ackout = 0,
  output reg beta_mem = 0,
  // variabili di condizionamento
  input clock, 
  input rdy, ack,
  input [2:0]op,
  input eq, // eq(I, N)
  input ge, // ge(HD, N) === segno(HD - N)
  input hd0,
  input or_hd,
  input or10_hd
);

  //TODO: derivare forme in SP delle variabili di controllo e aggiornarle all'interno di un assign
  always
  begin
    #2; // 2tp di ritardo per omegaPC

    // TEST
    if (rdy && op == 0)
    begin
      beta_mem <= 1; // abilita scrittura in memoria
      alpha_k_mem1 <= 0; // lettura di M[HD]
      alpha_alu3 <= 0; // (+)
      alpha_k3 <= 0; // HD
      beta_hd <= 1; // abilita scrittura di HD + 1 -> HD
      beta_dataout <= 1; // abilita scrittura di M[HD] in DATAOUT
    end
    // TEST
    else if (rdy == 0 && op == 1)
    begin
      beta_mem <= 0; // disabilita scrittura in memoria
      alpha_k_mem1 <= 0; // lettura di M[HD]
      alpha_alu3 <= 1; // (-)
      alpha_k3 <= 0; // HD
      beta_hd <= 1; // abilita scrittura di HD - 1 -> HD
      beta_dataout <= 1; // abilita scrittura di M[HD] in DATAOUT
    end
  end





endmodule
