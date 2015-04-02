module arbiter(input clk,
    
    input [2:0]sp_in_0, 
    input [2:0]sp_in_1, 
    input [2:0]sp_in_2, 
    input [2:0]sp_in_3,
    output reg [2:0]sp_out,
    input [23:0]addr_sp_0,
    input [23:0]addr_sp_1,
    input [23:0]addr_sp_2,
    input [23:0]addr_sp_3,
    output [23:0]addr_sp_out,
    input owned_0,
    input owned_1,
    input owned_2,
    input owned_3,
    output [1:0]share_num,
    
    input [63:0]data_in_1,
    output reg [63:0]data_out_1,
    input [23:0]addr_1,
    input rw_1,
    input ce_1, 
    input pro_1,
    output reg RDY_1,
    
    input [63:0]data_in_2,
    output reg [63:0]data_out_2,
    input [23:0]addr_2,
    input rw_2,
    input ce_2, 
    input pro_2,
    output reg RDY_2,
    
    inout [63:0]data_low, 
    output reg [23:0]addr_low, 
    output reg rw_low,
    input RDY_low, 
    output reg ce_low);

  reg [23:0]addr_que[3:0];    //address queue
  reg rw_que [3:0];
  reg [63:0]data_que [3:0];
  reg id [3:0];   //specify which cache the instruction comes from
  reg [63:0]data_low_out;
  reg [1:0] chan=0;
  
  assign share_num=owned_0+owned_1+owned_2+owned_3;
  assign addr_sp_out=(chan==0)?addr_sp_0:'bz,
         addr_sp_out=(chan==1)?addr_sp_1:'bz, 
         addr_sp_out=(chan==2)?addr_sp_2:'bz,
         addr_sp_out=(chan==3)?addr_sp_3:'bz;
         
         
  always@(sp_in_0)begin
    if(sp_in_0!=0)
      sp_out<=sp_in_0;
    if(sp_in_0==3'b001 || sp_in_0==3'b010 || sp_in_0==3'b101)
      chan<=0;
  end
      
  always@(sp_in_1)begin
    if(sp_in_1!=0)
      sp_out<=sp_in_1;
    if(sp_in_1==3'b001 || sp_in_1==3'b010 || sp_in_1==3'b101)
      chan<=1;
  end
  
  always@(sp_in_2)begin
    if(sp_in_2!=0)
      sp_out<=sp_in_2;
    if(sp_in_2==3'b001 || sp_in_2==3'b010 || sp_in_2==3'b101)
      chan<=2;
  end
  
  always@(sp_in_3)begin
    if(sp_in_3!=0)
      sp_out<=sp_in_3;
    if(sp_in_3==3'b001 || sp_in_3==3'b010 || sp_in_3==3'b101)
      chan<=3;
  end

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
  
  assign data_low=(ce_low==1 && rw_low==0)?data_low_out:64'hz;
  
endmodule