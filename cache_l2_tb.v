module cache_l2_tb  ; 
  reg   reset;
  reg    rw_hig   ; 
  wire  [31:0]  data_hig   ; 
  reg  [63:0]  data_low_in   ; 
  wire    ce_low   ; 
  wire  [63:0]  data_low_out   ; 
  reg    ce_hig   ; 
  reg  [2:0]  snoop_sig   ; 
  reg    clk   ; 
  wire [23:0]  addr_low;
  reg  [23:0]  addr_hig   ; 
  wire    rw_low   ; 
  wire [2:0] snoop_req   ; 
  wire [23:0] addr_sp_out;
  reg [23:0] addr_sp_in;
  reg     RDY_low;
  wire pro;
  
  cache_l2  
   CACHE_1  (
      .reset (reset), 
       .rw_hig (rw_hig ) ,
      .data_hig (data_hig ) ,
      .data_low_in (data_low_in ) ,
      .ce_low (ce_low ) ,
      .data_low_out (data_low_out ) ,
      .ce_hig (ce_hig ) ,
      .pro (pro ) ,
      .snoop_sig (snoop_sig ) ,
      .clk (clk ) ,
      .addr_hig (addr_hig ) ,
      .addr_low (addr_low) ,
      .rw_low (rw_low ) ,
      .addr_sp_out (addr_sp_out),
      .addr_sp_in (addr_sp_in),
      .RDY_hig (RDY_hig),
      .RDY_low(RDY_low),
      .snoop_req (snoop_req ) ); 
`define INVALID 2'b11
`define SHARED 2'b10
`define OWNED_CLEAN 2'b00
`define OWNED_DIRTY 2'b01
  reg [31:0]data_hig_in;

initial begin
    $readmemh("L2A_set0_cach",CACHE_1.C0.cach);
    $readmemh("L2A_set0_head",CACHE_1.C0.head);
    $readmemh("L2A_set1_cach",CACHE_1.C1.cach);
    $readmemh("L2A_set1_head",CACHE_1.C1.head);
    $readmemh("L2A_set2_cach",CACHE_1.C2.cach);
    $readmemh("L2A_set2_head",CACHE_1.C2.head);
    $readmemh("L2A_set3_cach",CACHE_1.C3.cach);
    $readmemh("L2A_set3_head",CACHE_1.C3.head);
    CACHE_1.C0.tag[14'h2000]<=`OWNED_DIRTY;
    CACHE_1.C3.tag[14'h0000]<=`INVALID;
    CACHE_1.C1.tag[14'h0460]<=`SHARED;
    CACHE_1.C2.tag[14'h06A4]<=`OWNED_DIRTY;
    CACHE_1.C3.tag[14'h10E8]<=`OWNED_CLEAN;  
end


initial begin
  RDY_low=0;
  snoop_sig=3'b000;
  reset=0;
  clk=0;
  addr_hig=24'hfe0004;
  //read fe0004     read hit
  #10 ce_hig=1; rw_hig=1;
  #10 ce_hig=0;
  //write abababab to f20000, write hit;
  #50 addr_hig=24'hf20000;
      ce_hig=1; rw_hig=0;
      data_hig_in=32'habababab;
  #10 ce_hig=0;
  //read f20000 read hit;
  #10 ce_hig=1; rw_hig=1;
  #10 ce_hig=0;
//  write 37373737 to D00004. write hit but invalid. replace and write to dirty;
  #10 ce_hig=1; rw_hig=0;
      addr_hig=24'hD00004; data_hig_in=32'h37373737;
  #20 RDY_low=1; data_low_in=64'h3344556677889900;
  #5 ce_hig=0;
  #5 RDY_low=0;    
  
  //read f50002 read miss; dirty write back first//
  #20 addr_hig=24'hf50002;      //7A 2000 2
      ce_hig=1; rw_hig=1;
  #20 RDY_low=1;
  #10 RDY_low=0;
  #10 RDY_low=1;  data_low_in=64'h2b2b2b2b2b2b2b2b;
  #10 RDY_low=0;                snoop_sig=3'b100;
  //#10 RDY_low=1;
  //#10 RDY_low=0;
  #5 ce_hig=0; 
  
  
  ///test snoop old block;
  #20 snoop_sig=3'b001;
      addr_sp_in=24'h342304;      //1A 460
  #5 snoop_sig=3'b000;          
  
  //test snoop new block when read,  dirty write back with priority
  #15 snoop_sig=3'b010;
      addr_sp_in=24'h343520;      //1A 6A4
  #5 snoop_sig=0;
  #10 RDY_low=1; //snoop_sig=3'b000;
  #10 RDY_low=0;
  
  //test snoop new block when write,
  #15 snoop_sig=3'b101;
      addr_sp_in=24'h348740;     //1A  10E8
  #5 snoop_sig=0;
     
end

  assign data_hig=(ce_hig==1&&rw_hig==0)?data_hig_in:32'hz;

  always
    #5 clk=~clk;
endmodule

