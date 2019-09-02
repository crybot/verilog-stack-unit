module test_stack();
  // segnale di clock
  reg clock;

  // ingressi
  reg [31:0]datain = 0;
  reg [9:0]n = 0;
  reg [2:0]op = 0;
  reg rdy_in = 0; // linea a transizione di livello

  wire signed [31:0]dataout;
  wire esito;
  wire ack;
  
  integer i;

  STACK stack(dataout, esito, ack, rdy_in, op, datain, n, clock);
  
  // generazione segnale di clock
  always
  begin
    if (clock == 0)
      #50 clock = 1;
    else 
      #1 clock = 0;
  end


  initial
  begin
    $dumpfile("test_stack.vcd");
    $dumpvars;
    #2;
    //PUSH (1023)
    datain <= 1023;
    rdy_in <= 1;
    op <= 0;
    
    //POP
    #102;
    rdy_in <= 0;
    op <= 1;

    //PUSH (111)
    #102;
    datain <= 111;
    rdy_in <= 1;
    op <= 0;

    //POP
    #102;
    rdy_in <= 0;
    op <= 1;

    //PUSH (500)
    #102;
    datain <= 500;
    op <= 0;
    rdy_in <= 1;

    //PUSH (750)
    #102;
    datain <= 750;
    op <= 0;
    rdy_in <= 0;

    //SOMMA (750 + 500)
    #102;
    op <= 2;
    rdy_in <= 1;

    //SOTTRAZIONE (750 - 500)
    #102;
    op <= 3;
    rdy_in <= 0;

    //PUSH (1200)
    #102;
    datain <= 1200;
    op <= 0;
    rdy_in <= 1;

    //PUSH (300)
    #102;
    datain <= 300;
    op <= 0;
    rdy_in <= 0;

    //MEDIA: (1200 + 300 + 750 + 500)/4
    #102;
    op <= 4;
    n <= 4;
    rdy_in <= 1;

    // CLEAR stack
    for (i=0; i<1024; i++)
    begin
      //POP
      #102;
      op <= 1;
      rdy_in <= ~rdy_in;
    end

    // FILL stack
    for (i=0; i<=1024; i++)
    begin
      //PUSH (i)
      #102;
      datain <= i;
      op <= 0;
      rdy_in <= ~rdy_in;
    end


    #1000;
    $finish;
  end
endmodule

