module L2_arbi_mem_tb();
  //signals from upper module  
  reg clk_cache;
  reg reset;
  reg [23:0]addr_hig_1;
  reg [23:0]addr_hig_2;
  wire [31:0]data_hig_1;
  wire [31:0]data_hig_2;
  reg rw_hig_1;
  reg rw_hig_2;
  reg ce_hig_1;
  reg ce_hig_2;
  wire RDY_hig_1;
  wire RDY_hig_2;
  
  //signals to arbiter
  reg clk_arbi;
  wire [23:0]addr_arbi_1;
  wire [23:0]addr_arbi_2;
  wire [63:0]data_arbi_out_1;
  wire [63:0]data_arbi_out_2;
  wire [63:0]data_arbi_in_1;
  wire [63:0]data_arbi_in_2;
  wire rw_arbi_1;
  wire rw_arbi_2;
  wire ce_arbi_1;
  wire ce_arbi_2;
  wire RDY_arbi_1;
  wire RDY_arbi_2;
  wire pro_1;
  wire pro_2;
  
  //signals between L2 caches
  wire[23:0]addr_sp_1;
  wire[23:0]addr_sp_2;
  wire[2:0]snoop_1;
  wire[2:0]snoop_2;
  
  //signals between arbiter and memory
  reg clk_mem;
  wire[63:0]data_mem;
  wire[23:0]addr_mem;
  wire rw_mem;
  wire RDY_mem;
  wire ce_mem;
  wire RDY_mem_1;
  wire RDY_mem_2;
  
  reg [31:0]data_hig_in_1;
  reg [31:0]data_hig_in_2;
  `define INVALID 2'b11
  `define SHARED 2'b10
  `define OWNED_CLEAN 2'b00
  `define OWNED_DIRTY 2'b01
  cache_l2 CA_L2_1 (
    .clk(clk_cache),
    .reset(reset),
    .addr_hig(addr_hig_1),
    .data_hig(data_hig_1),
    .rw_hig(rw_hig_1),
    .ce_hig(ce_hig_1),
    .RDY_hig(RDY_hig_1),
    .addr_low(addr_arbi_1),
    .data_low_out(data_arbi_out_1),
    .data_low_in(data_arbi_in_1),
    .rw_low(rw_arbi_1),
    .ce_low(ce_arbi_1),
    .RDY_low(RDY_arbi_1),
    .pro(pro_1),
    .addr_sp_out(addr_sp_1),
    .addr_sp_in(addr_sp_2),
    .snoop_sig(snoop_1),
    .snoop_req(snoop_2)    
    );
    
  cache_l2 CA_L2_2 (
    .clk(clk_cache),
    .reset(reset),
    .addr_hig(addr_hig_2),
    .data_hig(data_hig_2),
    .rw_hig(rw_hig_2),
    .ce_hig(ce_hig_2),
    .RDY_hig(RDY_hig_2),
    .addr_low(addr_arbi_2),
    .data_low_out(data_arbi_out_2),
    .data_low_in(data_arbi_in_2),
    .rw_low(rw_arbi_2),
    .ce_low(ce_arbi_2),
    .RDY_low(RDY_arbi_2),
    .pro(pro_2),
    .addr_sp_out(addr_sp_2),
    .addr_sp_in(addr_sp_1),
    .snoop_sig(snoop_2),
    .snoop_req(snoop_1)
    );    
  
  arbiter ARBI2(
    .clk(clk_arbi),
    
    .data_in_1(data_arbi_out_1),
    .data_out_1(data_arbi_in_1),
    .addr_1(addr_arbi_1),
    .rw_1(rw_arbi_1),
    .ce_1(ce_arbi_1),
    .pro_1(pro_1),
    .RDY_1(RDY_arbi_1),
    
    .data_in_2(data_arbi_out_2),
    .data_out_2(data_arbi_in_2),
    .addr_2(addr_arbi_2),
    .rw_2(rw_arbi_2),
    .ce_2(ce_arbi_2),
    .pro_2(pro_2),
    .RDY_2(RDY_arbi_2),
    
    .data_low(data_mem),
    .addr_low(addr_mem),
    .rw_low(rw_mem),
    .RDY_low(RDY_mem),
    .ce_low(ce_mem)
    );
    
  memory M1 (clk_mem, data_mem, addr_mem[22:0], rw_mem, ~addr_mem[23], ce_mem, RDY_mem_1);
  memory M2 (clk_mem, data_mem, addr_mem[22:0], rw_mem, addr_mem[23], ce_mem, RDY_mem_2);
  
  assign RDY_mem = RDY_mem_1 | RDY_mem_2; 
  
  initial begin
    $readmemh("L2A_set0_cach",CA_L2_1.C0.cach);
    $readmemh("L2A_set0_head",CA_L2_1.C0.head);
    $readmemh("L2A_set1_cach",CA_L2_1.C1.cach);
    $readmemh("L2A_set1_head",CA_L2_1.C1.head);
    $readmemh("L2A_set2_cach",CA_L2_1.C2.cach);
    $readmemh("L2A_set2_head",CA_L2_1.C2.head);
    $readmemh("L2A_set3_cach",CA_L2_1.C3.cach);
    $readmemh("L2A_set3_head",CA_L2_1.C3.head);
    $readmemh("L2B_set0_cach",CA_L2_2.C0.cach);
    $readmemh("L2B_set0_head",CA_L2_2.C0.head);
    $readmemh("L2B_set1_cach",CA_L2_2.C1.cach);
    $readmemh("L2B_set1_head",CA_L2_2.C1.head);
    $readmemh("L2B_set2_cach",CA_L2_2.C2.cach);
    $readmemh("L2B_set2_head",CA_L2_2.C2.head);
    $readmemh("L2B_set3_cach",CA_L2_2.C3.cach);
    $readmemh("L2B_set3_head",CA_L2_2.C3.head);
    $readmemh("mem1.txt",M1.mem);
    $readmemh("mem2.txt",M2.mem);
    CA_L2_1.C0.tag[14'h2000]<=`OWNED_DIRTY;
    CA_L2_1.C3.tag[14'h0000]<=`INVALID;
    CA_L2_1.C1.tag[14'h0460]<=`SHARED;
    CA_L2_1.C2.tag[14'h06A4]<=`OWNED_DIRTY;
    CA_L2_1.C3.tag[14'h10E8]<=`OWNED_CLEAN;
    CA_L2_2.C0.tag[14'h0000]<=`SHARED;
    CA_L2_2.C3.tag[14'h2000]<=`OWNED_DIRTY;  
  end
  
  assign data_hig_1=(ce_hig_1==1&&rw_hig_1==0)?data_hig_in_1:32'hz;
  assign data_hig_2=(ce_hig_2==1&&rw_hig_2==0)?data_hig_in_2:32'hz;
  
  initial begin 
    clk_cache=0;
    clk_arbi=0;
    clk_mem=0;
    //cache 1 read fe0004     read hit
    addr_hig_1=24'hfe0004;
    #10 ce_hig_1=1; rw_hig_1=1;
    #10 ce_hig_1=0;
    
    //cache 2 write abababab to f20000, write hit;
    #50 addr_hig_2=24'hf20000;
        ce_hig_2=1; rw_hig_2=0;
        data_hig_in_2=32'habababab;
    #10 ce_hig_2=0;
    
    //chache 2 read f20000 read hit;
    #10 ce_hig_2=1; rw_hig_2=1;
    #10 ce_hig_2=0;
    
    
    //cache 1  write 37373737 to D00004. write hit but invalid. replace and write to dirty;
    #10 ce_hig_1=1; rw_hig_1=0;
      addr_hig_1=24'hD00004; data_hig_in_1=32'h37373737;
    #75 ce_hig_1=0;
    
    //read f50002 read miss; dirty write back first//
    #25 addr_hig_1=24'hf50002;      //7A 2000 2
      ce_hig_1=1; rw_hig_1=1;
    #220 ce_hig_1=0;
  end
  
  initial begin
    reset=0;
    ce_hig_1=0;
    ce_hig_1=0;
  end
  
  
  
  always
    #5 clk_cache=~clk_cache;
  
  always
    #10 clk_arbi=~clk_arbi;
    
  always
    #20 clk_mem=~clk_mem;
   
  endmodule
  
