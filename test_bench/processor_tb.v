module processor_tb();
  wire [23:0]addr;
  wire [7:0]data_out;
  reg [7:0]data_in;
  reg clk;
  wire read, write;
  reg RDY;
  integer i=0;
  
  processor P1(clk, addr, data_out, data_in, read, write, RDY);
  
  initial begin
    #0 RDY=1;
    #10 RDY=0;
    for(i=0;i<7;i=i+1)begin
      #10 RDY=1;
      #10 RDY=0;
    end
  end
  
  initial 
    clk=0;
  
  always
    #5 clk=~clk;
    
endmodule