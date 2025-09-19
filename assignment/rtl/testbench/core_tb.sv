`timescale 1ns / 1ns

module Core_tb;

  // clock and reset signals
  logic clk = 1;
  logic reset;

  // Loop variable for loading instructions
  integer i;

  // https://www.cs.sfu.ca/%7Eashriram/Courses/CS295/assets/notebooks/RISCV/RISCV_CARD.pdf
  // https://luplab.gitlab.io/rvcodecjs/
  // http://www.eg.bucknell.edu/~csci206/riscv-converter/

  // Use the links above to add RISC-V instructions to the provided array in hex format.
  // Remember, these resources are may be incorrect for some instruction types, so make sure to verify them with your RISC-V greencard
  //Basic test
  /**
	bit [31:0] test_instructions [] = {
        32'h00000000, // NOP (keep as first instruction for simulation to work)
        32'hfec10493,  
		32'h00c58533, 
		32'h00002403, 
		32'h40618a33, 
		32'h01392ab3,  
		32'h014005ef
    };
  **/
  //Task 1
  /**
  bit [31:0] test_instructions [] = {
        32'h00000000, // NOP (keep as first instruction for simulation to work)
        32'h00002483,
        32'h002480b3,
        32'h00402403, 
        32'h006401b3  
    };
	**/
  /**
	//Task 2
	bit [31:0] test_instructions [] = {
        32'h00000000, // NOP (keep as first instruction for simulation to work)
        32'hffb00413,
		32'h00500433,
		32'h408304b3,
		32'h00002483,
		32'h008484b3,
		32'h408484b3,
		32'h00848633,
		32'h009425b3,
		32'h40b00133 
    };
    **/
    //complex forwarding
    /**
    bit [31:0] test_instructions [] = {
        32'h00000000,    
        32'h00000000,    
        32'h00000000,   
        32'h00210133,    
        32'h00210133,    
        32'h00210133,    
        32'h00210133,    
        32'h00210133,    
        32'h00210133,    
        32'h00210133,    
        32'h00210133,    
        32'h00210133,    
        32'h00210133,    
        32'h01080833,    
        32'h00000000,    
        32'h01080833,    
        32'h00000000,    
        32'h01080833,    
        32'h00000000,    
        32'h00000000,    
        32'h01080833,    
        32'h41010733,    
        32'h41070633,    
        32'h00000000,    
        32'h41070633,    
        32'h410604b3,    
        32'h002481b3,    
        32'h00002483,    
        32'h00348233,    
        32'h40348233,    
        32'hfec10113,    
        32'h00402083  
    };
    **/
    //flush 1
    /**
    bit [31:0] test_instructions [] = {
        32'h00000000,
        32'h002282b3,
        32'h40760233,
        32'hff9ff56f,
        32'h405202b3,
        32'h00c20313 
    };
  **/
  //flush 2
  bit [31:0] test_instructions [] = {
        32'h00000000,
        32'h00002783, 
        32'h00178793, 
        32'h0080056f, 
        32'h00a182b3, 
        32'h00a782b3, 
        32'h004005ef, 
        32'h0040066f, 
        32'h00c582b3, 
        32'h003282b3, 
        32'h00c006ef, 
        32'h003a8a33, 
        32'hfd9ff76f, 
        32'h00402683 
    };
  initial
  begin
    // dump waveform signals into a vcd waveform file
    $dumpfile("Core_Simulation.vcd");
    $dumpvars(0, Core_tb);
    
    reset = 1'b1;
    
    #1
    // Loop over the array of instructions
    for (i = 0; i < $size(test_instructions); i++)
    begin
    
      // Now load each byte in to memory manually
      rv32_core.InstructionFetch_Module.InstructionMemory.instr_RAM[i * 4 + 0] = test_instructions[i][31:24];
      rv32_core.InstructionFetch_Module.InstructionMemory.instr_RAM[i * 4 + 1] = test_instructions[i][23:16];
      rv32_core.InstructionFetch_Module.InstructionMemory.instr_RAM[i * 4 + 2] = test_instructions[i][15:8];
      rv32_core.InstructionFetch_Module.InstructionMemory.instr_RAM[i * 4 + 3] = test_instructions[i][7:0];
    end
    
    #3 reset = 1'b0;
    
    
    // end simulation after (# of instructions * 4ns(clk period))
    //#($size(test_instructions) * 4) $finish;
  end


always
    #2 clk <= ~clk;



  // instantiate the RISC-V core
  Core rv32_core (
         .clock(clk),
         .reset(reset),
         .mem_en(1'b1)
       );

endmodule
