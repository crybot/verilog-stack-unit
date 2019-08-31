/*
* Registro impulsato da N bit
*/
module REGISTRO(output [N-1:0]out, input [N-1:0]in, input clock, input beta);
  parameter N = 32;
  reg [N-1:0]val = 0;

  // Si scrive nel registro durante il fronte di alzata per evitare stati metastabili
  // all'avvio del programma, per esempio:
  // in un'interfaccia a transizione di livello il registro interno S ha il beta=1 costante.
  // Questo implica che all'avvio della simulazione venga scritto nel registro il valore della linea
  // di ingresso (per esempio la linea rdy). Se questa linea impiega un tempo t > 0 per stabilizzare, nel
  // registro viene scritto all'avvio della simulazione (perche` clock = 0 al tempo t=0 viene interpretato
  // come un negedge del segnale di clock) un valore instabile che dura fino al prossimo impulso del clock.
  // Utilizzando posedge ed avendo l'accortezza di inizializzare il registro a 0 (in cima, val = 0) e di
  // generare il segnale di clock partendo dal basso( ____|¯¯|____|¯¯|_) si evita questo problema, purche` al
  // prossimo impulso di clock l'ingresso del registro sia stabile.
  always @(posedge clock)
  begin
    if (beta)
      val <= in;
  end

  assign out = val;
endmodule
