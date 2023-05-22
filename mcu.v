//Memory module
module memory #(parameter op_size=32,
                parameter mem_sz)   // Both width and size of the memory can be parameterized      
            (input clk,
            input [3:0] wr_en, //write enable signal
            input [op_size -1:0] addr,
            input [op_size -1:0] data_in1, 
            output reg [mem_sz -1:0] data_out0,
            output reg [mem_sz -1:0] data_out2,
            output reg [mem_sz -1:0] data_out3);

    reg [op_size -1:0] mem_arr [mem_sz -1:0];

    always @(posedge clk)begin

            case(wr_en) 
                7:begin
                    data_out3=mem_arr[addr];   //write a value to memory
                end
                8:begin
                    mem_arr[addr]=data_in1;   //Write a value directly to a memory location
                end


            endcase
             
    end        
    
 
endmodule



module mcu #(
      parameter op_sz = 32,
      parameter mem_sz
      ) (
      input wire clk, reset,
      input wire [mem_sz-1 : 0] op0,
      input reg [op_sz-1 : 0] op1,  //op1 can be input & output both 
      input wire [mem_sz-1 : 0] op2,
      input wire [3:0] op_code,
      output reg [op_sz-1 : 0] out,
      output wire op_err
      // output wire op_done
      );

/*-------------------instance of memory module------------------ */
memory mem (.clk(clk),.wr_en(op_code),.data_out0(op0),.data_out2(op2),.data_in1(op1));  

/*-----------------ALU & memory operations based on op_code---------------------------*/
  always @(posedge clk)begin
    if(reset==0)
      out=1;
    else begin 
      case(op_code)

            0: op1=op0+op2;  //If op_code=0 ->ADD the two operands and assign the result in op1
            1: op1=op0-op2;  //If op_code=1 ->SUB the two operands and assign the result in op1
            2: op1=op0*op2;  //If op_code=2 ->MUL the two operands and assign the result in op1
            3: op1=op0/op2;  //If op_code=3 ->DEVIDE the two operands and assign the result in op1 , op2!=0
            4: op1=op0&op2;  //If op_code=4 ->AND the two operands and assign the result in op1
            5: op1=op0|op2;  //If op_code=5 ->OR the two operands and assign the result in op1
            6: op1=op0^op2;  //If op_code=6 ->XOR the two operands and assign the result in op1
            7: memory mem (.clk(clk),.wr_en(op_code),.data_out0(op0),.data_out2(op2),.data_out3(out));  // in this case "out" port will be linked with "data_out3"
            8: memory mem (.clk(clk),.wr_en(op_code),.data_out0(op0),.data_out2(op2),.data_in1(out));   // // in this case "out" port will be linked with "data_in1"
        default : begin 
        		out=1;
        end 
      endcase
      
    end
    
  end
  
  
  
  
endmodule
