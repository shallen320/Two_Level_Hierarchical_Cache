//500K*16bytes memory chip
module memory(clk, data, addr, rw, cs, ce, RDY);
  input clk;
  input cs;   //chip select
  inout [63:0]data;
  input [22:0]addr;
  input rw;
  output reg RDY;
  input ce;
  
  reg [127:0] mem [2**19-1:0];
  reg [63:0] data_out;
  
                 
  always @(posedge clk)
    if(cs==1)begin
      if(ce==1)begin
        if(rw==1)begin    //read cycle
          data_out<=addr[3]==0?mem[addr[22:4]][63:0]:mem[addr[22:4]][127:64];
          RDY<=1;
        end
        else if (rw == 0) begin   //write cycle
          case (addr[3])
            1'b0: mem[addr[22:4]][63:0]<=data;
            1'b1: mem[addr[22:4]][127:64]<=data;
          endcase
          RDY<=1;
        end
        else
          RDY<=0;if(ce==1)begin
        if(rw==1)begin    //read cycle
          data_out<=addr[3]==0?mem[addr[22:4]][63:0]:mem[addr[22:4]][127:64];
          RDY<=1;
        end
        else if (rw == 0) begin   //write cycle
          case (addr[3])
            1'b0: mem[addr[22:4]][63:0]<=data;
            1'b1: mem[addr[22:4]][127:64]<=data;
          endcase
          RDY<=1;
        end
        else
          RDY<=0;
        end
      end
    end
      
  always @(negedge clk)
    RDY<=0;
  assign data=(cs==1 && ce==1 && rw==1)?data_out:64'hzzzzzzzzzzzzzzzz;
endmodule
