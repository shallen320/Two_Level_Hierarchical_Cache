module L1_L2_mem_tb();
  // signals for L1 cache
  reg clk_L1;
  reg reset;
  reg [23:0]addr_cpu_0;
  reg [7:0]data_cpu_in_0;
  wire [7:0]data_cpu_out_0;
  reg rw_cpu_0;
  reg ce_cpu_0;
  wire RDY_cpu_0;
  reg [23:0]addr_cpu_1;
  reg [7:0]data_cpu_in_1;
  wire [7:0]data_cpu_out_1;
  reg rw_cpu_1;
  reg ce_cpu_1;
  wire RDY_cpu_1;
  reg [23:0]addr_cpu_2;
  reg [7:0]data_cpu_in_2;
  wire [7:0]data_cpu_out_2;
  reg rw_cpu_2;
  reg ce_cpu_2;
  wire RDY_cpu_2;
  reg [23:0]addr_cpu_3;
  reg [7:0]data_cpu_in_3;
  wire [7:0]data_cpu_out_3;
  reg rw_cpu_3;
  reg ce_cpu_3;
  wire RDY_cpu_3;
  
  wire[23:0]addr_l1_0;
  wire[31:0]data_l1_out_0;
  wire[31:0]data_l1_in_0;
  wire rw_l1_0;
  wire ce_l1_0;
  wire RDY_l1_0;
  wire pro_l1_0;
  wire[23:0]addr_l1_1;
  wire[31:0]data_l1_out_1;
  wire[31:0]data_l1_in_1;
  wire rw_l1_1;
  wire ce_l1_1;
  wire RDY_l1_1;
  wire pro_l1_1;
  wire[23:0]addr_l1_2;
  wire[31:0]data_l1_out_2;
  wire[31:0]data_l1_in_2;
  wire rw_l1_2;
  wire ce_l1_2;
  wire RDY_l1_2;
  wire pro_l1_2;
  wire[23:0]addr_l1_3;
  wire[31:0]data_l1_out_3;
  wire[31:0]data_l1_in_3;
  wire rw_l1_3;
  wire ce_l1_3;
  wire RDY_l1_3;
  wire pro_l1_3;
 
  wire owned_0;
  wire [1:0] share_num;
  wire [23:0] addr_sp_out_0;
  wire [23:0] addr_sp_in;
  wire[2:0]snoop_in;
  wire [2:0]snoop_out_0;
  wire owned_1;
  wire [23:0] addr_sp_out_1;
  wire [2:0]snoop_out_1;
  wire owned_2;
  wire [23:0] addr_sp_out_2;
  wire [2:0]snoop_out_2;
  wire owned_3;
  wire [23:0] addr_sp_out_3;
  wire [2:0]snoop_out_3;  
  
  //L1 arbiter
  
  //signals from upper module  
  reg clk_L2;
  wire [23:0]addr_hig_1;
  wire [23:0]addr_hig_2;
  wire [31:0]data_hig_1;
  wire [31:0]data_hig_2;
  wire rw_hig_1;
  wire rw_hig_2;
  wire ce_hig_1;
  wire ce_hig_2;
  wire RDY_hig_1;
  wire RDY_hig_2;
  
  //signals to L2 arbiter
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
  
  `define INVALID 2'b11
  `define SHARED 2'b10
  `define OWNED_CLEAN 2'b00
  `define OWNED_DIRTY 2'b01
  
  cache_l1 CA_L1_0(
    .clk(clk_L1),
    .reset(reset),
    .addr_cpu(addr_cpu_0),
    .data_cpu_in(data_cpu_in_0),
    .data_cpu_out(data_cpu_out_0),
    .rw_cpu(rw_cpu_0),
    .ce_cpu(ce_cpu_0),
    .RDY_cpu(RDY_cpu_0),
    .addr_low(addr_l1_0),
    .data_low_out(data_l1_out_0),
    .data_low_in(data_l1_in_0),
    .rw_low(rw_l1_0),
    .ce_low(ce_l1_0),
    .RDY_low(RDY_l1_0),
    .pro(pro_l1_0),
    .owned(owned_0),
    .share_num(share_num),
    .addr_sp_out(addr_sp_out_0),
    .addr_sp_in(addr_sp_in),
    .snoop_sig(snoop_in),
    .snoop_req(snoop_out_0)
    );
  
  cache_l1 CA_L1_1(
    .clk(clk_L1),
    .reset(reset),
    .addr_cpu(addr_cpu_1),
    .data_cpu_in(data_cpu_in_1),
    .data_cpu_out(data_cpu_out_1),
    .rw_cpu(rw_cpu_1),
    .ce_cpu(ce_cpu_1),
    .RDY_cpu(RDY_cpu_1),
    .addr_low(addr_l1_1),
    .data_low_out(data_l1_out_1),
    .data_low_in(data_l1_in_1),
    .rw_low(rw_l1_1),
    .ce_low(ce_l1_1),
    .RDY_low(RDY_l1_1),
    .pro(pro_l1_1),
    .owned(owned_1),
    .share_num(share_num),
    .addr_sp_out(addr_sp_out_1),
    .addr_sp_in(addr_sp_in),
    .snoop_sig(snoop_in),
    .snoop_req(snoop_out_1)
    );
    
  cache_l1 CA_L1_2(
    .clk(clk_L1),
    .reset(reset),
    .addr_cpu(addr_cpu_2),
    .data_cpu_in(data_cpu_in_2),
    .data_cpu_out(data_cpu_out_2),
    .rw_cpu(rw_cpu_2),
    .ce_cpu(ce_cpu_2),
    .RDY_cpu(RDY_cpu_2),
    .addr_low(addr_l1_2),
    .data_low_out(data_l1_out_2),
    .data_low_in(data_l1_in_2),
    .rw_low(rw_l1_2),
    .ce_low(ce_l1_2),
    .RDY_low(RDY_l1_2),
    .pro(pro_l1_2),
    .owned(owned_2),
    .share_num(share_num),
    .addr_sp_out(addr_sp_out_2),
    .addr_sp_in(addr_sp_in),
    .snoop_sig(snoop_in),
    .snoop_req(snoop_out_2)
    );
    
  cache_l1 CA_L1_3(
    .clk(clk_L1),
    .reset(reset),
    .addr_cpu(addr_cpu_3),
    .data_cpu_in(data_cpu_in_3),
    .data_cpu_out(data_cpu_out_3),
    .rw_cpu(rw_cpu_3),
    .ce_cpu(ce_cpu_3),
    .RDY_cpu(RDY_cpu_3),
    .addr_low(addr_l1_3),
    .data_low_out(data_l1_out_3),
    .data_low_in(data_l1_in_3),
    .rw_low(rw_l1_3),
    .ce_low(ce_l1_3),
    .RDY_low(RDY_l1_3),
    .pro(pro_l1_3),
    .owned(owned_3),
    .share_num(share_num),
    .addr_sp_out(addr_sp_out_3),
    .addr_sp_in(addr_sp_in),
    .snoop_sig(snoop_in),
    .snoop_req(snoop_out_3)
    );
    
  arbiter_l1 ARBI_L1_0(
    .clk(clk_L2),
    .data_in_1(data_l1_out_0),
    .data_out_1(data_l1_in_0),
    .addr_1(addr_l1_0),
    .rw_1(rw_l1_0),
    .ce_1(ce_l1_0),
    .pro_1(pro_l1_0),
    .RDY_1(RDY_l1_0),
    .data_in_2(data_l1_out_1),
    .data_out_2(data_l1_in_1),
    .addr_2(addr_l1_1),
    .rw_2(rw_l1_1),
    .ce_2(ce_l1_1),
    .pro_2(pro_l1_1),
    .RDY_2(RDY_l1_1),
    .data_low(data_hig_1),
    .addr_low(addr_hig_1),
    .rw_low(rw_hig_1),
    .RDY_low(RDY_hig_1),
    .ce_low(ce_hig_1)
    );
    
  arbiter_l1 ARBI_L1_1(
    .clk(clk_L2),
    .data_in_1(data_l1_out_2),
    .data_out_1(data_l1_in_2),
    .addr_1(addr_l1_2),
    .rw_1(rw_l1_2),
    .ce_1(ce_l1_2),
    .pro_1(pro_l1_2),
    .RDY_1(RDY_l1_2),
    .data_in_2(data_l1_out_3),
    .data_out_2(data_l1_in_3),
    .addr_2(addr_l1_3),
    .rw_2(rw_l1_3),
    .ce_2(ce_l1_3),
    .pro_2(pro_l1_3),
    .RDY_2(RDY_l1_3),
    .data_low(data_hig_2),
    .addr_low(addr_hig_2),
    .rw_low(rw_hig_2),
    .RDY_low(RDY_hig_2),
    .ce_low(ce_hig_2)
    );  
  
  cache_l2 CA_L2_1 (
    .clk(clk_L2),
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
    .clk(clk_L2),
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
    .sp_in_0(snoop_out_0),
    .sp_in_1(snoop_out_1),
    .sp_in_2(snoop_out_2),
    .sp_in_3(snoop_out_3),
    .sp_out(snoop_in),
    .addr_sp_0(addr_sp_out_0),
    .addr_sp_1(addr_sp_out_1),
    .addr_sp_2(addr_sp_out_2),
    .addr_sp_3(addr_sp_out_3),
    .addr_sp_out(addr_sp_in),
    .owned_0(owned_0),
    .owned_1(owned_1),
    .owned_2(owned_2),
    .owned_3(owned_3),
    .share_num(share_num),
    
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
    $readmemh("L1A_set0_cach",CA_L1_0.C0.cach);
    $readmemh("L1A_set0_head",CA_L1_0.C0.head);
    $readmemh("L1A_set1_cach",CA_L1_0.C1.cach);
    $readmemh("L1A_set1_head",CA_L1_0.C1.head);
    $readmemh("L1A_set2_cach",CA_L1_0.C2.cach);
    $readmemh("L1A_set2_head",CA_L1_0.C2.head);
    $readmemh("L1A_set3_cach",CA_L1_0.C3.cach);
    $readmemh("L1A_set3_head",CA_L1_0.C3.head);
    $readmemh("L1B_set0_cach",CA_L1_1.C0.cach);
    $readmemh("L1B_set0_head",CA_L1_1.C0.head);
    $readmemh("L1B_set1_cach",CA_L1_1.C1.cach);
    $readmemh("L1B_set1_head",CA_L1_1.C1.head);
    $readmemh("L1B_set2_cach",CA_L1_1.C2.cach);
    $readmemh("L1B_set2_head",CA_L1_1.C2.head);
    $readmemh("L1B_set3_cach",CA_L1_1.C3.cach);
    $readmemh("L1B_set3_head",CA_L1_1.C3.head);
    $readmemh("L1C_set0_cach",CA_L1_2.C0.cach);
    $readmemh("L1C_set0_head",CA_L1_2.C0.head);
    $readmemh("L1C_set1_cach",CA_L1_2.C1.cach);
    $readmemh("L1C_set1_head",CA_L1_2.C1.head);
    $readmemh("L1C_set2_cach",CA_L1_2.C2.cach);
    $readmemh("L1C_set2_head",CA_L1_2.C2.head);
    $readmemh("L1C_set3_cach",CA_L1_2.C3.cach);
    $readmemh("L1C_set3_head",CA_L1_2.C3.head);
    $readmemh("L1D_set0_cach",CA_L1_3.C0.cach);
    $readmemh("L1D_set0_head",CA_L1_3.C0.head);
    $readmemh("L1D_set1_cach",CA_L1_3.C1.cach);
    $readmemh("L1D_set1_head",CA_L1_3.C1.head);
    $readmemh("L1D_set2_cach",CA_L1_3.C2.cach);
    $readmemh("L1D_set2_head",CA_L1_3.C2.head);
    $readmemh("L1D_set3_cach",CA_L1_3.C3.cach);
    $readmemh("L1D_set3_head",CA_L1_3.C3.head);
    
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
    CA_L1_3.C3.tag[12'hB4D]<=`INVALID;
    CA_L1_0.C1.tag[12'hF51]<=`INVALID;
    CA_L1_2.C2.tag[12'hF51]<=`OWNED_DIRTY;
    CA_L2_1.C0.tag[14'h2000]<=`OWNED_DIRTY;
    
    CA_L2_1.C2.tag[14'h27A8]<=`SHARED;
    CA_L2_2.C2.tag[14'h27A8]<=`SHARED;
    
    CA_L2_1.C1.tag[14'h0460]<=`SHARED;
    CA_L2_1.C2.tag[14'h06A4]<=`OWNED_DIRTY;
    CA_L2_1.C3.tag[14'h10E8]<=`OWNED_CLEAN;
    CA_L2_2.C0.tag[14'h0000]<=`SHARED;
    CA_L2_2.C3.tag[14'h15A6]<=`INVALID;  
  end
  
  initial begin
    reset=0;
    addr_cpu_0 = 24'h245678;
    //read 245678    91 59E    read hit
    #10 ce_cpu_0=1; rw_cpu_0=1;
    #10 ce_cpu_0=0;
    //write ab to f20000, write hit;    3C8  000
    #20 addr_cpu_1=24'hf20000;
      ce_cpu_1=1; rw_cpu_1=0;
      data_cpu_in_1=8'hab;
    #10 ce_cpu_1=0;
    //read f20000 read hit;
    #10 ce_cpu_1=1; rw_cpu_1=1;
    #10 ce_cpu_1=0;
    //  write 37 to 56AD34(15A  B4D)(2B 15A6) write hit but invalid. L2 also invalid replace and write to dirty;
    #10 ce_cpu_3=1; rw_cpu_3=0;
        addr_cpu_3=24'h56AD34; data_cpu_in_3=32'h37;
    #140 ce_cpu_3=0;
    
    // L1cache 0 read E73d47(73 27A8), invalid, L1cache 2 write back first.
    #20 addr_cpu_0=24'hE73D47;      //39C F51 3
      ce_cpu_0=1; rw_cpu_0=1;
    #300 ce_cpu_0=0;
  end
  
  
  
  initial begin
    clk_L1=0;
    clk_L2=0;
    clk_arbi=0;
    clk_mem=0;
  end
  
  always
    #5 clk_L1=~clk_L1;
    
  always
    #10 clk_L2=~clk_L2;
    
  always
    #20 clk_arbi=~clk_arbi;
    
  always
    #40 clk_mem=~clk_mem;  
      
endmodule
