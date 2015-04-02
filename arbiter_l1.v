
module arbiter_l1(input clk,
  
    input [31:0]data_in_1,
    output reg [31:0]data_out_1,
    input [23:0]addr_1,
    input rw_1,
    input ce_1, 
    input pro_1,
    output reg RDY_1,
    
    input [31:0]data_in_2,
    output reg [31:0]data_out_2,
    input [23:0]addr_2,
    input rw_2,
    input ce_2, 
    input pro_2,
    output reg RDY_2,
    
    inout [31:0]data_low, 
    output reg [23:0]addr_low, 
    output reg rw_low,
    input RDY_low, 
    output reg ce_low);

  reg [23:0]addr_que[3:0];    //address queue
  reg rw_que [3:0];
  reg [31:0]data_que [3:0];
  reg id [3:0];   //specify which cache the instruction comes from
  reg [31:0]data_low_out;

  integer i=0;  // FIFO pointer
  integer j=0; //read pointer
  
  always@(posedge clk)begin
    RDY_1=0;
    RDY_2=0;
    if(i==0)begin
      if(pro_2==1 && ce_2==1)begin
        addr_que[i]<=addr_2;
        data_que[i]<=data_in_2;
        rw_que[i]<=rw_2;
        id[i]<=1;
        i=i+1;
      end
      if(ce_1==1)begin
        addr_que[i]<=addr_1;
        data_que[i]<=data_in_1;
        rw_que[i]<=rw_1;
        id[i]<=0;
        i=i+1;
      end
      if(ce_2==1 && pro_2==0)begin
        addr_que[i]<=addr_2;
        data_que[i]<=data_in_2;
        rw_que[i]<=rw_2;
        id[i]<=1;
        i=i+1;
      end
    end  
  end
  
  always@(negedge clk)begin
    if(i!=0)begin
      addr_low<=addr_que[j];
      data_low_out<=data_que[j];
      rw_low<=rw_que[j];
      ce_low<=1;
      wait(RDY_low);
      case (id[j])
        0: begin
          RDY_1<=1;
          RDY_2<=0;
          if(rw_que[j]==1)  //if it is read
            data_out_1<=data_low;
        end
        1: begin
          RDY_1<=0;
          RDY_2<=1;
          if(rw_que[j]==1)  ////if it is read
            data_out_2<=data_low; 
        end
        default: begin
          RDY_1<=0;
          RDY_2<=0;
        end
      endcase
      j=j+1;
      if(j==i)begin
        j=0;
        i=0;
      end
      wait(RDY_low==0);
      ce_low=0;
    end
  end
  
  assign data_low=(ce_low==1 && rw_low==0)?data_low_out:32'hz;
  
endmodule