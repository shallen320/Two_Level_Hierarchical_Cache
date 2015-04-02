module mmu_tb();
  wire [23:0]addr1_a;
  wire [23:0]addr1_b;
  reg [23:0]addr1_a_in;
  reg [23:0]addr1_b_in;
  wire [23:0]addr0_a;
  wire [23:0]addr0_b;
  reg [23:0]addr0_a_in;
  reg [23:0]addr0_b_in;

  assign addr1_a=addr1_a_in;
  assign addr0_a=addr0_a_in;
  mmu #(1) M1(addr1_a, addr1_b);
  mmu #(0) M0(addr0_a, addr0_b);
  
  initial begin
    addr1_a_in=24'h000000;
    addr0_a_in=24'h000000;
    #20
    addr1_a_in=24'h232323;
    addr0_a_in=24'h232323;
  end
endmodule
