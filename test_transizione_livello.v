module test_transizione_livello();

  reg clock = 0;
  reg beta_rdyin = 0;
  reg beta_rdyout = 0;
  wire rdy_out;
  wire rdy_in;

  TRANSIZIONE_LIVELLO rdyout(rdy_out, 1'b0, clock, beta_rdyout);
  TRANSIZIONE_LIVELLO rdyin(rdy_in, rdy_out, clock, beta_rdyin);

  always
  begin
    if (clock == 0)
      #6 clock = 1;
    else 
      #1 clock = 0;
  end

  initial
  begin
    $dumpfile("test_transizione_livello.vcd");
    $dumpvars;
    // Notifica invio messaggio (set RDYout)
    #9 beta_rdyout = 1;
    #7 beta_rdyout = 0;

    // Ricezione messaggio (reset RDYin)
    #12 beta_rdyin = 1;
    #6 beta_rdyin = 0;

    // Notifica invio messaggio (set RDYout)
    #12 beta_rdyout = 1;
    #6 beta_rdyout = 0;

    // Ricezione messaggio (reset RDYin)
    #12 beta_rdyin = 1;
    #6 beta_rdyin = 0;

    #200;
    $finish;
  end
  
endmodule

