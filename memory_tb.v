module memory_tb();
  reg clk;
  wire [63:0]data;
  wire RDY;
  reg [22:0]addr;
  reg rw;
  reg ce;
  reg cs;
  reg [63:0]data_in;
  
  memory M1 (clk, data, addr, rw, cs, ce, RDY);
  
  initial begin
    cs=1;
    addr=0;
    clk=0;
    rw=0;
    ce=0;
    data_in=0;
    
    #10 rw=1; ce=1;
    #10 ce=0; addr=24'h000008;
    #10 rw=0; ce=1; data_in=64'h8888888888888888;
    #10 ce=0;
    #10 rw=1; ce=1;
    #10 ce=0;
    
    #10 cs=0;
    #10 rw=1; ce=1;
    #10 ce=0; addr=24'h000008;
    #10 rw=0; ce=1; data_in=64'h8888888888888888;
    #10 ce=0;
    #10 rw=1; ce=1;
    #10 ce=0;
  end
  
  assign data=(ce==1 && rw==0)?data_in:64'hz;
  
  always
    #5 clk=~clk;
    
    
endmodule
  
  
