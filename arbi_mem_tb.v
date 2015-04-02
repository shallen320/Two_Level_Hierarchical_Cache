module arbi_mem_tb();
  reg clk_2;
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
  wire RDY_low_1;
  wire RDY_low_2;
  
  
  arbiter  
   AB1  ( 
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
      
  memory M1 (clk_2, data_low, addr_low[22:0], rw_low, ~addr_low[23], ce_low, RDY_low_1);
  memory M2 (clk_2, data_low, addr_low[22:0], rw_low, addr_low[23], ce_low, RDY_low_2); 
  
  assign RDY_low = RDY_low_1 | RDY_low_2;
  
  always
    #5 clk=~clk;
  
  always
    #10 clk_2=~clk_2;
  
  initial begin
    $readmemh("mem1.txt",M1.mem);
    $readmemh("mem2.txt",M2.mem);
  end
    
    
    
  initial begin
    clk=0;
    clk_2=0;
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
    
    // cache_1 read
    #10 data_in_1 = 64'h2345689430983456;
        addr_1 = 24'h000008;
        rw_1=1;
    #10 ce_1=1;
    #30 ce_1=0;
    
    // cache_2 write
    #0 data_in_2=64'h873452abce4fad35;
        addr_2 = 24'h000010;
        rw_2=0;
    #10 ce_2=1;
    #30 ce_2=0;
    
    // cache_1 read, cache_2 with a high priority write at the sametime.
    #10 ce_1=1; ce_2=1; pro_2=1;
        data_in_2=64'h5555;
        addr_1=24'h000018;
        addr_2=24'h000018;
    #30 ce_2=0; pro_2=0;
    #40 ce_1=0;
    
    //cache_2 read
    #0  addr_2 = 24'h000010;
        rw_2 = 1;
    #10 ce_2 =1;
    #30 ce_2=0;
    
    //cache_1 read 2nd memory
    #10 addr_1 = 24'h800008;
        rw_1 = 1;
    #10 ce_1=1;
    #20 ce_1=0;    
    
    
  end
endmodule
        
