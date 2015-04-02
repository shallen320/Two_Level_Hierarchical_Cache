module cache_l1_tb  ; 


  reg    RDY_low   ; 
  wire  [7:0]  data_cpu_out   ; 
  wire   pro   ; 
  wire   ce_low   ; 
  reg  [31:0]  data_low_in   ; 
  reg  [23:0]  addr_cpu   ; 
  wire  [31:0]  data_low_out   ; 
  reg    reset   ; 
  wire  [23:0]  addr_low   ; 
  reg    rw_cpu   ; 
  reg  [2:0]  snoop_sig   ; 
  reg    clk   ; 
  wire   rw_low   ; 
  reg  [23:0]  addr_sp_in   ; 
  wire  [23:0]  addr_sp_out   ; 
  wire  [2:0]  snoop_req   ; 
  wire   RDY_cpu   ; 
  reg  [7:0]  data_cpu_in   ; 
  reg    ce_cpu   ; 
  
  `define INVALID 2'b11
  `define SHARED 2'b10
  `define OWNED_CLEAN 2'b00
  `define OWNED_DIRTY 2'b01
  cache_l1   
   CACHE_1  ( 
       .RDY_low (RDY_low ) ,
      .data_cpu_out (data_cpu_out ) ,
      .pro (pro ) ,
      .ce_low (ce_low ) ,
      .data_low_in (data_low_in ) ,
      .addr_cpu (addr_cpu ) ,
      .data_low_out (data_low_out ) ,
      .reset (reset ) ,
      .addr_low (addr_low ) ,
      .rw_cpu (rw_cpu ) ,
      .snoop_sig (snoop_sig ) ,
      .clk (clk ) ,
      .rw_low (rw_low ) ,
      .addr_sp_in (addr_sp_in ) ,
      .addr_sp_out (addr_sp_out ) ,
      .snoop_req (snoop_req ) ,
      .RDY_cpu (RDY_cpu ) ,
      .data_cpu_in (data_cpu_in ) ,
      .ce_cpu (ce_cpu ) ); 
  
  initial begin
    $readmemh("L1A_set0_cach",CACHE_1.C0.cach);
    $readmemh("L1A_set0_head",CACHE_1.C0.head);
    $readmemh("L1A_set1_cach",CACHE_1.C1.cach);
    $readmemh("L1A_set1_head",CACHE_1.C1.head);
    $readmemh("L1A_set2_cach",CACHE_1.C2.cach);
    $readmemh("L1A_set2_head",CACHE_1.C2.head);
    $readmemh("L1A_set3_cach",CACHE_1.C3.cach);
    $readmemh("L1A_set3_head",CACHE_1.C3.head);
    CACHE_1.C0.tag[12'hF51]<=`OWNED_DIRTY;
    CACHE_1.C3.tag[12'hB4D]<=`INVALID;
    CACHE_1.C2.tag[12'h8c1]<=`SHARED;
    CACHE_1.C2.tag[12'hD48]<=`OWNED_DIRTY;
    CACHE_1.C3.tag[12'h1D0]<=`OWNED_CLEAN;  
  end

  initial begin
    RDY_low=0;
    snoop_sig=0;
    reset=0;
    clk=0;
    addr_cpu = 24'h245678;
    //read 245678    91 59E    read hit
    #10 ce_cpu=1; rw_cpu=1;
    #10 ce_cpu=0;
    
    //write ab to f20000, write hit;    3C8  000
    #50 addr_cpu=24'hf20000;
      ce_cpu=1; rw_cpu=0;
      data_cpu_in=8'hab;
    #10 ce_cpu=0;
    
    //read f20000 read hit;
    #10 ce_cpu=1; rw_cpu=1;
    #10 ce_cpu=0;
    
    //  write 37 to 56AD34(15A  B4D) write hit but invalid. replace and write to dirty;
    #10 ce_cpu=1; rw_cpu=0;
        addr_cpu=24'h56AD34; data_cpu_in=32'h37;
    #20 RDY_low=1; data_low_in=32'h77889900;
    #10 RDY_low=0; ce_cpu=0;
  
     //read E73d47 read miss; dirty write back first//
    #20 addr_cpu=24'hE73D47;      //39C F51 3
      ce_cpu=1; rw_cpu=1;
    #20 RDY_low=1;
    #10 RDY_low=0;
    #10 RDY_low=1;  data_low_in=32'h2b2b2b2b;
    #10 RDY_low=0;                snoop_sig=3'b100;
    #10 ce_cpu=0; 
    
    ///test snoop old block;
    #25 snoop_sig=3'b001;
      addr_sp_in=24'h342304;      //D0  8C1
    #5 snoop_sig=3'b000;
    
    //test snoop new block when read,  dirty write back with priority
    #15 snoop_sig=3'b010;
      addr_sp_in=24'h343520;      //D0  D48
    #5 snoop_sig=0;
    #10 RDY_low=1; //snoop_sig=3'b000;
    #10 RDY_low=0;
    
    //test snoop new block when write,
    #15 snoop_sig=3'b101;
      addr_sp_in=24'h348740;     //D2  1D0
    #5 snoop_sig=0;
  end
  
  
  
  always
    #5 clk=~clk;
  
endmodule

