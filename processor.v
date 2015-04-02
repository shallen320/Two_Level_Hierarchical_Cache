module processor(clk, addr, data_out, data_in, rw, ce, RDY);
  output reg [23:0]addr;
  output reg [7:0]data_out;
  input [7:0]data_in;
  input clk;
  output reg ce, rw;
  input RDY;
  
  reg [23:0] addr_reg [255:0];    //instruction memory: address field
  reg rw_reg [255:0];     //instruction memory: rw field read:1, write:0
  reg [7:0] data_reg [255:0];   //instruction memory: data field
  integer i=0;
  
  initial begin
    $readmemh("addr_reg.txt",addr_reg);
    $readmemh("rw_reg.txt",rw_reg);
    $readmemh("data_reg.txt",data_reg);
  end
  
  always @(posedge clk)
  begin
      addr = addr_reg[i];
      rw = rw_reg[i];
      ce = 1;
      if(rw_reg[i]==0)
        data_out = data_reg[i];
      wait(RDY==1);
      wait(RDY==0);
      ce = 0;
      i=i+1;
  end
    
  endmodule
        