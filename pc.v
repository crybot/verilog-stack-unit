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

  wire y_out;
  reg y_new;

  REGISTRO#(1) y(y_out, y_new, clock, 1'b1);

  // aggiorna le variabili di controllo quando le variabili di condizionamento cambiano
  always @(y_out or rdy or ack or op or ge or hd0 or or_hd or or10_hd or eq)
  begin
    #2; // 2tp di ritardo per omegaPC e sigmaPC

    // stato successivo
    y_new <= (~y_out & rdy & op[2] & ge) + (y_out & eq);

    /*************** ALPHA *************/
    // alu2
    alpha_alu2[0] <= ~y_out & rdy & ~op[2] & op[1] & op[0] & or10_hd;
    alpha_alu2[1] <= y_out & ~eq;
    alpha_alu2[2] <= y_out & ~eq;

    //alu3
    alpha_alu3[0] <= ~(~y_out & rdy & ~op[2] & ~op[1] & ~op[0] & ~hd0);
    alpha_alu3[1] <= 1'b0;
    alpha_alu3[2] <= 1'b0;

    //alu4
    alpha_alu4[0] <= ~(y_out & eq);
    alpha_alu4[1] <= 1'b0;
    alpha_alu4[2] <= 1'b0;

    //k_esito
    alpha_k_esito <= (~y_out & ~op[2] & ~op[1] & ~op[0] & hd0) 
                     + (~y_out & rdy & ~op[2] & ~op[1] & op[0] & ~or_hd)
                     + (~y_out & rdy & ~op[2] & op[1] & ~or10_hd) 
                     + (~y_out & rdy & op[2] & ~op[1] & ~op[0] & ~ge);

    // k_dataout
    alpha_k_dataout <= (~y_out & rdy & ~op[2] & op[1] & ~op[0] & or10_hd) 
                       + (~y_out & rdy & ~op[2] & op[1] & op[0] & or10_hd) + y_out;

    // k_mem1
    alpha_k_mem1 <= ~(~y_out & rdy & ~op[2] & ~op[1] & ~op[0] & ~hd0);

    // k_mem2
    alpha_k_mem2 <= y_out & eq;

    // k1-5
    alpha_k1 <= y_out;
    alpha_k2 <= y_out & ~eq;
    alpha_k3 <= y_out & eq;
    alpha_k4 <= y_out & eq;
    alpha_k5 <= (~y_out & rdy & ~op[2] & op[1] & ~op[0] & or10_hd) 
                + (~y_out & rdy & ~op[2] & op[1] & op[0] & or10_hd) 
                + (~y_out & rdy & op[2] & ~op[1] & ~op[0] & ge);

    // k_ind
    alpha_k_ind <= y_out & eq;
    alpha_k_i <= y_out & eq;
    /***********************************/

    /*************** BETA **************/
    // hd
    beta_hd <= (~y_out & rdy & ~op[2] & ~op[1] & ~op[0] & ~hd0)
               + (~y_out & rdy & ~op[2] & ~op[1] & op[0] & or_hd);

    // ind
    beta_ind <= (~y_out & rdy & op[2] & ~op[1] & ~op[0] & ge) + (y_out & eq);
    // i
    beta_i <= (~y_out & rdy & op[2] & ~op[1] & ~op[0] & ge) + (y_out & eq);

    // esito
    beta_esito <= ~((~y_out & rdy & op[2] & ~op[1] & ~op[0] & ge) + (y_out & eq) + (~y_out & ~rdy));
    // rdyin
    beta_rdyin <= ~((~y_out & rdy & op[2] & ~op[1] & ~op[0] & ge) + (y_out & eq) + (~y_out & ~rdy));
    // ackout
    beta_ackout <= ~((~y_out & rdy & op[2] & ~op[1] & ~op[0] & ge) + (y_out & eq) + (~y_out & ~rdy));

    // dataout
    beta_dataout <=  ~((~y_out & ~rdy) 
                     + (~y_out & rdy & ~op[2] & ~op[1] & ~op[0] & hd0) 
                     + (~y_out & rdy & ~op[2] & ~op[1] & op[0] & ~or_hd) 
                     + (~y_out & rdy & ~op[2] & op[1] & ~or10_hd) 
                     + (~y_out & rdy & op[2] & ~op[1] & ~op[0] & ~ge));

    // mem
    beta_mem <= ~y_out & rdy & ~op[2] & ~op[1] & ~op[0] & ~hd0;
    /***********************************/

  end

endmodule
