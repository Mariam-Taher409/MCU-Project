module mcu;
parameter clk_prd = 10 ns,
parameter op_sz =32,
parameter mem_sz;
reg clk_tb = 0;
always #(clk_prd/2) clk_tb = ~clk_tb;

       wire clk, reset,
       wire [mem_sz-1 : 0] op0_tb,
       reg [op_sz-1 : 0] op1_tb,  
       wire [mem_sz-1 : 0] op2_tb,
       wire [3:0] op_code,
       reg [op_sz-1 : 0] out_tb, 

mcu dut(
    .clk(clk_tb),
    .reset(reset),
    .op0(op0_tb),
    .op1(op1_tb),
    .op2(op2_tb),
    .op_code(op_code),
    .out(out_tb)
);

task add(
       wire [mem_sz-1 : 0] operand_0,  
       wire [mem_sz-1 : 0] operand_2
);
    op0_tb=operand_0;
    op2_tb=operand_2;
    op_code=0;
    #(clk_prd);
    op0_tb=0;
    op2_tb=0;
    out_tb=0;
$display("the output of mcu = %d",op1_tb);

endtask

task OR(
       wire [mem_sz-1 : 0] operand_0,  
       wire [mem_sz-1 : 0] operand_2
);
    op0_tb=operand_0;
    op2_tb=operand_2;
    op_code=5;
    #(clk_prd);
    op0_tb=0;
    op2_tb=0;
    out_tb=0;
$display("the output of mcu = %d",op1_tb);

endtask

task memory_write(
      input [op_sz-1 : 0] value_in
);
    out_tb=value_in;
    op_code=8;
    #(clk_prd);
    op0_tb=0;
    op2_tb=0;
    out_tb=0;
$display("the output of mcu = %d",op1_tb);

endtask


initial begin 

 add(200,220) ;  
 OR(200,220) ;

    


end
  
endmodule