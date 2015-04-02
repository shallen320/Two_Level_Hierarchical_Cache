module cache_set(
    input [23:0]addr
    );
  `define INVALID 2'b11
  `define SHARED 2'b10
  `define OWNED_CLEAN 2'b00
  `define OWNED_DIRTY 2'b01
  
  parameter WIDTH = 4;    //2**2==4
  parameter DEPTH = 12;   
  parameter WORD = 2;
  
  reg [WIDTH*8-1:0] cach [2**DEPTH-1:0];
  reg [1:0] tag [2**DEPTH-1:0];
  reg [2:0] counter [2**DEPTH-1:0];
  reg [24-DEPTH-WORD-1:0] head [2**DEPTH-1:0];
  integer i=0;
  
  initial begin
    for(i=0;i<2**DEPTH;i=i+1)begin
      tag[i]<=2'b00;
      counter[i]<=3'b000;
    end
  end
  
  function hit;
    input [23:0]func_addr;  
    hit = (func_addr[23:DEPTH+WORD]==head[func_addr[DEPTH+WORD-1:WORD]])?1:0;
  endfunction
  
  task chg_head;
    input [23:0]task_addr;
    head[task_addr[DEPTH+WORD-1:WORD]]=task_addr[23:DEPTH+WORD];
  endtask
  
  function [WIDTH*8-1:0]read;
    input [23:0]func_addr;
    read = cach[func_addr[DEPTH+WORD-1:WORD]];
  endfunction
  
  task write;
    input [23:0]func_addr;
    input [WIDTH*8-1:0] func_data;
    cach[func_addr[DEPTH+WORD-1:WORD]]=func_data;
  endtask

  function [31:0]readword;
    input [23:0]func_addr;
    case (func_addr[2])
      1'b0: readword = cach[func_addr[DEPTH+WORD-1:WORD]][31:0];
      1'b1: readword = cach[func_addr[DEPTH+WORD-1:WORD]][63:32];
    endcase
  endfunction
  
  task writeword;
    input [23:0]task_addr;
    input [31:0] task_data;
    case (task_addr[2])
      1'b0: cach[task_addr[DEPTH+WORD-1:WORD]][31:0]=task_data;
      1'b1: cach[task_addr[DEPTH+WORD-1:WORD]][63:32]=task_data;
    endcase
  endtask
  
  function [7:0]readbyte;
    input [23:0]func_addr;
    case (func_addr[1:0])
      2'b00: readbyte = cach[func_addr[DEPTH+WORD-1:WORD]][7:0];
      2'b01: readbyte = cach[func_addr[DEPTH+WORD-1:WORD]][15:8];
      2'b10: readbyte = cach[func_addr[DEPTH+WORD-1:WORD]][23:16];
      2'b11: readbyte = cach[func_addr[DEPTH+WORD-1:WORD]][31:24];
    endcase
  endfunction
  
  task writebyte;
    input [23:0]task_addr;
    input [7:0] task_data;
    case (task_addr[1:0])
      2'b00: cach[task_addr[DEPTH+WORD-1:WORD]][7:0]=task_data;
      2'b01: cach[task_addr[DEPTH+WORD-1:WORD]][15:8]=task_data;
      2'b10: cach[task_addr[DEPTH+WORD-1:WORD]][23:16]=task_data;
      2'b11: cach[task_addr[DEPTH+WORD-1:WORD]][31:24]=task_data;
    endcase
  endtask
  
  task counter_clr;
    input [23:0]task_addr;
    counter[task_addr[DEPTH+WORD-1:WORD]]<=0;
  endtask
  
  task counter_incr;
    input [23:0]task_addr;
    if(counter[task_addr[DEPTH+WORD-1:WORD]]<7)
      counter[task_addr[DEPTH+WORD-1:WORD]]<=counter[task_addr[DEPTH+WORD-1:WORD]]+1;
  endtask
  
  function [1:0]rtn_tag;
    input [23:0]func_addr;
    rtn_tag=tag[func_addr[DEPTH+WORD-1:WORD]];
  endfunction
  
  task change_tag;
    input [23:0]task_addr;
    input [1:0]task_tag;
    tag[task_addr[DEPTH+WORD-1:WORD]]=task_tag;
  endtask
  
  
endmodule
