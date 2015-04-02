module cache_l1(input clk, input reset,
  input [23:0]addr_cpu,   //cpuh level address in
  input [7:0]data_cpu_in,   //cpuh level data in
  output reg [7:0]data_cpu_out,
  input rw_cpu,
  input ce_cpu,
  output reg RDY_cpu,   // read/write complete signal to cpuh level
  
  output reg [23:0]addr_low,
  output reg [31:0]data_low_out,
  input [31:0]data_low_in,
  output reg rw_low,
  output reg ce_low,
  input RDY_low,
  output reg pro=0,       //priority
  
  output reg owned,     //owned=1 when old block is shared
  input [1:0] share_num,  //sum of owned signal from 4 L1 chips
  output reg [23:0]addr_sp_out,
  input [23:0]addr_sp_in,
  input [2:0]snoop_sig,   //snoop signal, 001: snoop old block 010:snoop new block when read: 011snoop complete  
                          // 100 snoop complete with SHARED state 101:snoop new block when write
  output reg [2:0]snoop_req
  );
  
  `define INVALID 2'b11
  `define SHARED 2'b10
  `define OWNED_CLEAN 2'b00
  `define OWNED_DIRTY 2'b01
  
  reg [1:0] rep_set;      //record which set to replace
  
  parameter WORD=2;
  parameter DEPTH=12;
  /*states*/
  parameter SP_OLD_BLK=4'b0100;   //snoop old block
  parameter SP_NEW_BLK_RD=4'b0101;   //snoop new block when read
  parameter SP_NEW_BLK_WT=4'b0111;   //snoop new block when write
  parameter READY=4'b0000;        //ready state;
  parameter DIRTY_WT_BCK=4'b0001;   //write back when dirty 
  parameter REPLACE=4'b0010;    //state replace block;
  parameter WR_TO_DIRTY=4'b0011;    //write to make it dirty
  parameter READ=4'b0110;        //read after replace the block
  
  reg [3:0] state=0; 
  reg [3:0] sp_state=0;

  /*four way set associative cache*/
  cache_set #(4,12,2) C0(addr_cpu);
  cache_set #(4,12,2) C1(addr_cpu);
  cache_set #(4,12,2) C2(addr_cpu);
  cache_set #(4,12,2) C3(addr_cpu);
  
  integer i;
  integer j=0;

  always @ (posedge clk or posedge reset) begin
    if(reset==1)begin
      state<=READY;
      sp_state<=READY;
    end
    else
      case (state)
        READY: 
          if(ce_cpu==1)begin
            if(C0.hit(addr_cpu) && C0.rtn_tag(addr_cpu)==`INVALID)begin
              C0.counter_incr(addr_cpu);
              rep_set=0;
              state<=REPLACE;
            end
            else if(C1.hit(addr_cpu) && C1.rtn_tag(addr_cpu)==`INVALID)begin
              C1.counter_incr(addr_cpu);
              rep_set=1;
              state<=REPLACE;
            end
            else if(C2.hit(addr_cpu) && C2.rtn_tag(addr_cpu)==`INVALID)begin
              C2.counter_incr(addr_cpu);
              rep_set=2;
              state<=REPLACE;
            end
            else if(C3.hit(addr_cpu) && C3.rtn_tag(addr_cpu)==`INVALID)begin
              C3.counter_incr(addr_cpu);
              rep_set=3;
              state<=REPLACE;
            end  
            else if(not_hit(addr_cpu)) begin
              rep_set = replace_algri(addr_cpu);
              if(read_tag(addr_cpu)!=`INVALID)begin
                addr_sp_out<=cal_addr(addr_cpu);
                snoop_req=3'b001;
              end
              if(get_tag(addr_cpu)==`OWNED_DIRTY)
                state<=DIRTY_WT_BCK;     
              else
                state<=REPLACE;
            end
          end
        DIRTY_WT_BCK: begin
          if(RDY_low==1)
            state<=REPLACE;
        end
        REPLACE: begin
          if(RDY_low==1)
            if(rw_cpu==1)   //read
              state<=READ;
            else if(rw_cpu==0) //write
              state<=WR_TO_DIRTY;
            else;
        end
        WR_TO_DIRTY: begin
            state<=READY;
        end
        READ:
          if(snoop_sig==3'b011 || snoop_sig==3'b100)
            state<=READY;
        SP_OLD_BLK: begin
          state<=READY;
        end
        SP_NEW_BLK_RD: begin
        end
        SP_NEW_BLK_WT: begin
        end
      endcase
  end
        
  always @ (snoop_sig)   
   if(snoop_sig==3'b001 || snoop_sig==3'b010 ||snoop_sig==3'b101)
      case(snoop_sig)
        3'b001:    //snoop old block
          sp_state <= SP_OLD_BLK;
        3'b010:     //snoop new block
          sp_state <= SP_NEW_BLK_RD;
        3'b101:
          sp_state <= SP_NEW_BLK_WT;
      endcase


  always @ (posedge clk) begin
    if(state==READY)
      if(ce_cpu==1)begin
        if(rw_cpu==1)begin  //read cycle
          if(C0.hit(addr_cpu)&&C0.rtn_tag(addr_cpu)!=`INVALID) begin
            data_cpu_out<=C0.readbyte(addr_cpu);
            C0.counter_incr(addr_cpu);
            RDY_cpu<=1;
          end
          else if(C1.hit(addr_cpu)&&C1.rtn_tag(addr_cpu)!=`INVALID) begin
            data_cpu_out<=C1.readbyte(addr_cpu);
            C1.counter_incr(addr_cpu);
            RDY_cpu<=1;
          end
          else if(C2.hit(addr_cpu)&&C2.rtn_tag(addr_cpu)!=`INVALID) begin
            data_cpu_out<=C2.readbyte(addr_cpu);
            C2.counter_incr(addr_cpu);
            RDY_cpu<=1;
          end
          else if(C3.hit(addr_cpu)&&C3.rtn_tag(addr_cpu)!=`INVALID) begin
            data_cpu_out<=C3.readbyte(addr_cpu);
            C3.counter_incr(addr_cpu);
            RDY_cpu<=1;
          end
          else begin
            data_cpu_out<=32'hXXXXXXXX;
            
          end
        end
        else if (rw_cpu==0) begin//write cycle
          if(C0.hit(addr_cpu))
            case(C0.rtn_tag(addr_cpu))
              `SHARED:begin
                C0.writebyte(addr_cpu,data_cpu_in);
                C0.tag[addr_cpu[DEPTH+WORD-1:WORD]]<=`OWNED_DIRTY;
                C0.counter_incr(addr_cpu);
                RDY_cpu<=1;
                snoop_req=3'b101;
                addr_sp_out=addr_cpu;
              end
              `OWNED_CLEAN:begin
                C0.writebyte(addr_cpu,data_cpu_in);
                C0.counter_incr(addr_cpu);
                C0.tag[addr_cpu[DEPTH+WORD-1:WORD]]<=`OWNED_DIRTY;
                RDY_cpu<=1;
              end
              `OWNED_DIRTY:begin
                C0.writebyte(addr_cpu,data_cpu_in);
                C0.counter_incr(addr_cpu);
                RDY_cpu<=1;
              end
              `INVALID:begin
                state<=REPLACE;
              end
            endcase
          else if(C1.hit(addr_cpu))
            case(C1.rtn_tag(addr_cpu))
              `SHARED:begin
                C1.writebyte(addr_cpu,data_cpu_in);
                C1.tag[addr_cpu[DEPTH+WORD-1:WORD]]<=`OWNED_DIRTY;
                C1.counter_incr(addr_cpu);
                RDY_cpu<=1;
                snoop_req=3'b101;
                addr_sp_out=addr_cpu;
              end
              `OWNED_CLEAN:begin
                C1.writebyte(addr_cpu,data_cpu_in);
                C1.counter_incr(addr_cpu);
                C1.tag[addr_cpu[DEPTH+WORD-1:WORD]]<=`OWNED_DIRTY;
                RDY_cpu<=1;
              end
              `OWNED_DIRTY:begin
                C1.writebyte(addr_cpu,data_cpu_in);
                C1.counter_incr(addr_cpu);
                RDY_cpu<=1;
              end
              `INVALID:begin
                state<=REPLACE;
              end
            endcase
          else if(C2.hit(addr_cpu)) 
            case(C2.rtn_tag(addr_cpu))
              `SHARED:begin
                C2.writebyte(addr_cpu,data_cpu_in);
                C2.tag[addr_cpu[DEPTH+WORD-1:WORD]]<=`OWNED_DIRTY;
                C2.counter_incr(addr_cpu);
                RDY_cpu<=1;
                snoop_req=3'b101;
                addr_sp_out=addr_cpu;
              end
              `OWNED_CLEAN:begin
                C2.writebyte(addr_cpu,data_cpu_in);
                C2.counter_incr(addr_cpu);
                C2.tag[addr_cpu[DEPTH+WORD-1:WORD]]<=`OWNED_DIRTY;
                RDY_cpu<=1;
              end
              `OWNED_DIRTY:begin
                C2.writebyte(addr_cpu,data_cpu_in);
                C2.counter_incr(addr_cpu);
                RDY_cpu<=1;
              end
              `INVALID:begin
                state<=REPLACE;
              end
            endcase
          else if(C3.hit(addr_cpu))
            case(C3.rtn_tag(addr_cpu))
              `SHARED:begin
                C3.writebyte(addr_cpu,data_cpu_in);
                C3.tag[addr_cpu[DEPTH+WORD-1:WORD]]<=`OWNED_DIRTY;
                C3.counter_incr(addr_cpu);
                RDY_cpu<=1;
                snoop_req=3'b101;
                addr_sp_out=addr_cpu;
              end
              `OWNED_CLEAN:begin
                C3.writebyte(addr_cpu,data_cpu_in);
                C3.counter_incr(addr_cpu);
                C3.tag[addr_cpu[DEPTH+WORD-1:WORD]]<=`OWNED_DIRTY;
                RDY_cpu<=1;
              end
              `OWNED_DIRTY:begin
                C3.writebyte(addr_cpu,data_cpu_in);
                C3.counter_incr(addr_cpu);
                RDY_cpu<=1;
              end
              `INVALID:begin
                state<=REPLACE;
              end
            endcase
        end
      end
  end
  
  always@(negedge clk)begin
    RDY_cpu<=0;
    if(snoop_req==3'b001 || snoop_req==3'b010 || snoop_req==3'b101)
      if(state!= SP_OLD_BLK && RDY_low==0 && state!=SP_NEW_BLK_RD && 
           state!=REPLACE && state!=SP_NEW_BLK_WT && state!=DIRTY_WT_BCK)
        snoop_req<=0;
      else if(state == REPLACE && snoop_req!=0)begin
        j=j+1;
        if(j==2)begin
          j=0;
          snoop_req<=0;
        end
      end
      else if(state == DIRTY_WT_BCK && snoop_req!=0)begin
        j=j+1;
        if(j==2)begin
          j=0;
          snoop_req<=0;
        end
      end
  end
  
  always@(state)
    case(state)
      DIRTY_WT_BCK:begin
        dirty_write_back;
      end
      REPLACE:begin
        case (rw_cpu)
          1: snoop_req=3'b010;      //snoop new block when read
          0: snoop_req=3'b101;      //snoop new block when write
        endcase
        addr_sp_out=addr_cpu;
        addr_low=addr_cpu;
        rw_low=1;
        ce_low=1;
        wait(RDY_low==0);
        wait(RDY_low);
        ce_low=0;
        replace_block(data_low_in);
      end
      WR_TO_DIRTY:begin
        write_to_dirty(data_cpu_in);
        RDY_cpu=1; 
      end
      READ:begin
        data_cpu_out=read_block(addr_cpu);
        wait(snoop_sig==3'b011 || snoop_sig==3'b100);
        if (snoop_sig==3'b100)
          write_tag(addr_cpu,`SHARED);
        else
          write_tag(addr_cpu, `OWNED_CLEAN);
        wait(clk);
        RDY_cpu=1;
      end
    endcase

  always @(sp_state)
    case (sp_state)
      SP_NEW_BLK_RD:begin
        if(search_tag(`OWNED_DIRTY))begin
          data_low_out=read_line(addr_sp_in);
          addr_low=addr_sp_in;
          rw_low=0;
          pro=1;
          ce_low=1;
          wait(RDY_low);
          pro=0;
          ce_low=0;
          write_tag(addr_sp_in, `SHARED);
          snoop_req=3'b100;
          sp_state=READY;
        end
        else if(search_tag(`OWNED_CLEAN))begin
          write_tag(addr_sp_in, `SHARED);
          snoop_req=3'b100;
          wait(clk==0);
          wait(clk==1);
          sp_state=READY;
        end
        else begin
          //snoop_req=3'b011;
          wait(clk==0);
          wait(clk==1);
          sp_state=READY;
        end
      end
      SP_NEW_BLK_WT:begin
        if(search_tag(`OWNED_DIRTY))begin
          data_low_out=read_line(addr_sp_in);
          addr_low=addr_sp_in;
          rw_low=0;
          pro=1;
          ce_low=1;
          wait(RDY_low);
          pro=0;
          ce_low=0;
          write_tag(addr_sp_in, `INVALID);
          snoop_req=3'b011;
          sp_state=READY;
        end
        else if(search_tag(`OWNED_CLEAN))begin
          write_tag(addr_sp_in, `INVALID);
          snoop_req=3'b011;
          wait(clk==0);
          wait(clk==1);
          sp_state=READY;
        end
        else if(search_tag(`SHARED))begin
          write_tag(addr_sp_in, `INVALID);
          snoop_req=3'b011;
          wait(clk==0);
          wait(clk==1);
          sp_state=READY;
        end
      end
      SP_OLD_BLK:begin
        if(search_tag(`SHARED))begin
          owned=1;
          if(share_num==2'b01)begin
            write_tag(addr_sp_in, `OWNED_CLEAN);
            snoop_req=3'b011;
          end
            wait(clk==0);
            wait(clk==1);
            sp_state=READY;
        end
        else
          owned=0;
          sp_state=READY;
      end
    endcase
  
  function [1:0]replace_algri;
    input [23:0]func_addr;
    reg[2:0] counter0, counter1, counter2, counter3;
    reg[2:0] min1, min2;
    reg com1, com2;
    begin
      counter0=C0.counter[func_addr[WORD+DEPTH-1:WORD]];
      counter1=C1.counter[func_addr[WORD+DEPTH-1:WORD]];
      counter2=C2.counter[func_addr[WORD+DEPTH-1:WORD]];
      counter3=C3.counter[func_addr[WORD+DEPTH-1:WORD]];
      com1=counter0>counter1;   //com1==0, counter0 is minimal; com1==1, counter1 is minimal
      min1=com1?counter1:counter0;
      com2=counter2>counter3;   //com2==0, counter2 is minimal; com2==1, counter3 is minimal
      min2=com2?counter3:counter2;
      replace_algri={min1>min2,min1<=min2?com1:com2};
    end
  endfunction
    
  function [1:0]get_tag;
    input [23:0]func_addr;
    case (rep_set)
      2'b00:  get_tag=C0.tag[func_addr[WORD+DEPTH-1:WORD]];
      2'b01:  get_tag=C1.tag[func_addr[WORD+DEPTH-1:WORD]];
      2'b10:  get_tag=C2.tag[func_addr[WORD+DEPTH-1:WORD]];
      2'b11:  get_tag=C3.tag[func_addr[WORD+DEPTH-1:WORD]];
    endcase
  endfunction
  
  function not_hit;
    input[23:0]func_addr;
    not_hit= ~(C0.hit(func_addr) || C1.hit(func_addr) || C2.hit(func_addr) || C3.hit(func_addr));
  endfunction
  
  task dirty_write_back;
    case(rep_set)
      2'b00:begin
        data_low_out<=C0.read(addr_cpu);
        addr_low<={C0.head[addr_cpu[DEPTH+WORD-1:WORD]],addr_cpu[DEPTH+WORD-1:WORD],2'b00};
        rw_low<=0;
        ce_low=1;
        wait(RDY_low);
        ce_low=0;
      end
      2'b01:begin
        data_low_out<=C1.read(addr_cpu);
        addr_low<={C1.head[addr_cpu[DEPTH+WORD-1:WORD]],addr_cpu[DEPTH+WORD-1:WORD],2'b00};
        rw_low<=0;
        ce_low=1;
        wait(RDY_low);
        ce_low=0;
      end
      2'b10:begin
        data_low_out<=C2.read(addr_cpu);
        addr_low<={C2.head[addr_cpu[DEPTH+WORD-1:WORD]],addr_cpu[DEPTH+WORD-1:WORD],2'b00};
        rw_low<=0;
        ce_low=1;
        wait(RDY_low);
        ce_low=0;
      end
      2'b11:begin
        data_low_out<=C3.read(addr_cpu);
        addr_low<={C3.head[addr_cpu[DEPTH+WORD-1:WORD]],addr_cpu[DEPTH+WORD-1:WORD],2'b00};
        rw_low<=0;
        ce_low=1;
        wait(RDY_low);
        ce_low=0;
      end
    endcase
  endtask
  
  task replace_block;
    input [63:0]data;
    case (rep_set)
      2'b00:  begin
        C0.write(addr_cpu,data);
        C0.chg_head(addr_cpu);
        C0.counter_clr(addr_cpu);
      end
      2'b01:  begin
        C1.write(addr_cpu,data);
        C1.chg_head(addr_cpu);
        C1.counter_clr(addr_cpu);
      end
      2'b10:  begin
        C2.write(addr_cpu,data);
        C2.chg_head(addr_cpu);
        C2.counter_clr(addr_cpu);
      end
      2'b11:  begin
        C3.write(addr_cpu,data);
        C3.chg_head(addr_cpu);
        C3.counter_clr(addr_cpu);
      end
    endcase
  endtask
  
  task write_tag;
    input [23:0]task_addr;
    input [1:0]task_tag;
    case (rep_set)
      2'b00:  C0.change_tag(task_addr,task_tag);
      2'b01:  C1.change_tag(task_addr,task_tag);
      2'b10:  C2.change_tag(task_addr,task_tag);
      2'b11:  C3.change_tag(task_addr,task_tag);
    endcase
  endtask
  
  function [1:0]read_tag;
    input [23:0]func_addr;
    case (rep_set)
      2'b00:  read_tag=C0.rtn_tag(func_addr);
      2'b01:  read_tag=C1.rtn_tag(func_addr);
      2'b10:  read_tag=C2.rtn_tag(func_addr);
      2'b11:  read_tag=C3.rtn_tag(func_addr);
    endcase
  endfunction
  
  task write_to_dirty;
    input [31:0]data;
    case (rep_set)
      2'b00: begin
        C0.writebyte(addr_cpu,data);
        C0.change_tag(addr_cpu,`OWNED_DIRTY);
      end
      2'b01: begin
        C1.writebyte(addr_cpu,data);
        C1.change_tag(addr_cpu,`OWNED_DIRTY);
      end
      2'b10: begin
        C2.writebyte(addr_cpu,data);
        C2.change_tag(addr_cpu,`OWNED_DIRTY);
      end
      2'b11: begin
        C3.writebyte(addr_cpu,data);
        C3.change_tag(addr_cpu,`OWNED_DIRTY);
      end
    endcase
  endtask
  
  function search_tag;
    input [1:0]func_tag;
    if(C0.tag[addr_sp_in[DEPTH+WORD-1:WORD]]==func_tag && C0.head[addr_sp_in[DEPTH+WORD-1:WORD]]==addr_sp_in[23:DEPTH+WORD])begin
      search_tag=1;
      rep_set=2'b00;
    end
    else if(C1.tag[addr_sp_in[DEPTH+WORD-1:WORD]]==func_tag && C1.head[addr_sp_in[DEPTH+WORD-1:WORD]]==addr_sp_in[23:DEPTH+WORD])begin
      search_tag=1;
      rep_set=2'b01;
    end
    else if(C2.tag[addr_sp_in[DEPTH+WORD-1:WORD]]==func_tag && C2.head[addr_sp_in[DEPTH+WORD-1:WORD]]==addr_sp_in[23:DEPTH+WORD])begin
      search_tag=1;
      rep_set=2'b10;      
    end
    else if(C3.tag[addr_sp_in[DEPTH+WORD-1:WORD]]==func_tag && C3.head[addr_sp_in[DEPTH+WORD-1:WORD]]==addr_sp_in[23:DEPTH+WORD])begin
      search_tag=1;
      rep_set=2'b11;
    end
    else
      search_tag=0;
  endfunction 
  
  function [31:0] read_block;
    input [23:0]func_addr;
    case (rep_set)
      2'b00: begin
        read_block=C0.readbyte(func_addr);
      end
      2'b01: begin
        read_block=C1.readbyte(func_addr);
      end
      2'b10: begin
        read_block=C2.readbyte(func_addr);
      end
      2'b11: begin
        read_block=C3.readbyte(func_addr);
      end
    endcase
  endfunction
  
  function [63:0] read_line;      //read a line from cache
    input [23:0]func_addr;
    case (rep_set)
      2'b00: begin
        read_line=C0.read(func_addr);
      end
      2'b01: begin
        read_line=C1.read(func_addr);
      end
      2'b10: begin
        read_line=C2.read(func_addr);
      end
      2'b11: begin
        read_line=C3.read(func_addr);
      end
    endcase
  endfunction
  
  function [23:0] cal_addr;      //calculate the address of old block to be replaced
    input [23:0]func_addr;
    case (rep_set)
      2'b00: begin
        cal_addr={C0.head[func_addr[DEPTH+WORD-1:WORD]],func_addr[DEPTH+WORD-1:WORD],2'b0};
      end
      2'b01: begin
        cal_addr={C1.head[func_addr[DEPTH+WORD-1:WORD]],func_addr[DEPTH+WORD-1:WORD],2'b0};
      end
      2'b10: begin
        cal_addr={C2.head[func_addr[DEPTH+WORD-1:WORD]],func_addr[DEPTH+WORD-1:WORD],2'b0};
      end
      2'b11: begin
        cal_addr={C3.head[func_addr[DEPTH+WORD-1:WORD]],func_addr[DEPTH+WORD-1:WORD],2'b0};
      end
    endcase
  endfunction
  
endmodule
