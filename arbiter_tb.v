module arbiter_tb  ; 
 
  reg [2:0]sp_in_0; 
  reg [2:0]sp_in_1; 
  reg [2:0]sp_in_2; 
  reg [2:0]sp_in_3;
  wire [2:0]sp_out;
  reg [23:0]addr_sp_0;
  reg [23:0]addr_sp_1;
  reg [23:0]addr_sp_2;
  reg [23:0]addr_sp_3;
  wire [23:0]addr_sp_out;
  reg owned_0;
  reg owned_1;
  reg owned_2;
  reg owned_3;
  wire [1:0]share_num;
 
  reg  [63:0]  data_in_1   ; 
  reg    rw_1   ; 
  reg  [63:0]  data_in_2   ; 
  wire  [23:0]  addr_low   ; 
  reg    rw_2   ; 
  wire   rw_low   ; 
  wire   RDY_1   ; 
  wire   RDY_2   ; 
  reg    ce_1   ; 
  wire  [63:0]  data_low   ; 
  reg    ce_2   ; 
  wire  [63:0]  data_out_1   ; 
  reg    pro_1   ; 
  reg    pro_2   ; 
  reg    clk   ; 
  wire  [63:0]  data_out_2   ; 
  reg  [23:0]  addr_1   ; 
  wire   ce_low   ; 
  reg  [23:0]  addr_2   ; 
  reg    RDY_low   ; 
  arbiter  
   DUT  (
      .sp_in_0(sp_in_0), 
      .sp_in_1(sp_in_1), 
      .sp_in_2(sp_in_2), 
      .sp_in_3(sp_in_3),
      .sp_out(sp_out),
      .addr_sp_0(addr_sp_0),
      .addr_sp_1(addr_sp_1),
      .addr_sp_2(addr_sp_2),
      .addr_sp_3(addr_sp_3),
      .addr_sp_out(addr_sp_out),
      .owned_0(owned_0),
      .owned_1(owned_1),
      .owned_2(owned_2),
      .owned_3(owned_3),
      .share_num(share_num),  
       .data_in_1 (data_in_1 ) ,
      .rw_1 (rw_1 ) ,
      .data_in_2 (data_in_2 ) ,
      .addr_low (addr_low ) ,
      .rw_2 (rw_2 ) ,
      .rw_low (rw_low ) ,
      .RDY_1 (RDY_1 ) ,
      .RDY_2 (RDY_2 ) ,
      .ce_1 (ce_1 ) ,
      .data_low (data_low ) ,
      .ce_2 (ce_2 ) ,
      .data_out_1 (data_out_1 ) ,
      .pro_1 (pro_1 ) ,
      .pro_2 (pro_2 ) ,
      .clk (clk ) ,
      .data_out_2 (data_out_2 ) ,
      .addr_1 (addr_1 ) ,
      .ce_low (ce_low ) ,
      .addr_2 (addr_2 ) ,
      .RDY_low (RDY_low ) ); 
  
   reg [63:0] data_low_out;
   assign data_low=(ce_low==1 && rw_low==1)?data_low_out:64'hz; 
  initial begin
    clk=0;
    data_in_1=0;
    addr_1=0;
    rw_1=0;
    ce_1=0;
    pro_1=0;
    
    data_in_2=0;
    addr_2=0;
    rw_2=0;
    ce_2=0;
    pro_2=0;

    RDY_low=0;
    addr_sp_0=24'h110000;
    addr_sp_1=24'h221111;
    addr_sp_2=24'h332222;
    addr_sp_3=24'h443333;
    owned_0=1;
    owned_1=0;
    owned_2=1;
    owned_3=0;
    
    #10 owned_1=1;  sp_in_2=3'b001;
    #10 owned_0=0; owned_2=0; sp_in_2=3'b000; sp_in_3=3'b011; 
    #10 owned_1=0;  sp_in_1=3'b010; 
    #1 sp_in_2=3'b100;
    
 /*   
    // cache_1 read
    #10 data_in_1 = 64'h2345689430983456;
        addr_1 = 24'h234562;
        rw_1=1;
    #10    ce_1=1;
    #20 RDY_low=1; ce_1=0; data_low_out = 64'h1111111111111111;
    #10 RDY_low=0;
    
    // cache_2 write
    #0 data_in_2=64'h2222222222222222;
        addr_2 = 24'h334455;
        rw_2=0;
    #10 ce_2=1;
    #20 RDY_low=1; ce_2=0;
    #10 RDY_low=0;
    
    // cache_1 read, cache_2 with a high priority write at the sametime.
    #10 ce_1=1; ce_2=1; pro_2=1;
        data_in_2=64'h5555;
        addr_1=24'h333300;
        addr_2=24'h444400;
    #20 RDY_low=1; ce_2=0;
    #10 RDY_low=0;
    #10 data_low_out=64'h2222;
    #10 RDY_low=1; ce_1=0;
    #10 RDY_low=0;
    
    //cache_2 read
    #0  addr_2 = 24'h444455;
        rw_2 = 1;
    #10 ce_2 =1;
    #20 RDY_low=1; ce_2=0; data_low_out=64'h3344;
    #10 RDY_low=0;
 */   
      
  end

  always
    #5 clk=~clk;
endmodule

