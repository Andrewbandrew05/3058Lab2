//***********************************************************
// ECE 3058 Architecture Concurrency and Energy in Computation
//
// RISCV Processor System Verilog Behavioral Model
//
// School of Electrical & Computer Engineering
// Georgia Institute of Technology
// Atlanta, GA 30332
//
//  Module:     Flush_Control
//  Functionality:
//      Flush Controller for a 5 Stage RISCV Processor
//
//***********************************************************
import CORE_PKG::*;

module Flush_Control (
  input logic reset,
  input logic alu_valid,

  input pc_mux pc_mux_ip,

  output logic flush_en
);

  /*
    Task 4
    Add code for enabling a flush based on the inputs to this module
  */

endmodule
