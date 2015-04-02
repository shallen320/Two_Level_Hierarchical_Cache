module mmu(addr_a, addr_b);
  input [23:0] addr_a;
  output [23:0] addr_b;
  
  parameter mode = 1'b0;
  
  assign addr_b[13:0]=addr_a[13:0];  
  assign addr_b[23:14]= mode? {~addr_a[23:19], addr_a[18:14]}:{addr_a[23:19], ~addr_a[18:14]};
  
endmodule
