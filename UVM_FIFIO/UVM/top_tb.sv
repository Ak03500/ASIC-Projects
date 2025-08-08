`timescale 1ns/1ps
`include "uvm_pkg.sv"

module top_tb;
  import uvm_pkg::*;
  
  // Clocks and resets
  logic clk_wr;
  logic rst_wr_n;
  logic clk_rd;
  logic rst_rd_n;
  
  // Clock generation
  initial begin
    clk_wr = 0;
    forever #5ns clk_wr = ~clk_wr;
  end
  initial begin
    clk_rd = 0;
    forever #7ns clk_rd = ~clk_rd;
  end

  // Reset generation
  initial begin
    rst_wr_n = 0;
    rst_rd_n = 0;
    #100ns;
    rst_wr_n = 1;
    rst_rd_n = 1;
  end

  // DUT interfaces
  fifo_wr_if wr_vif(.clk_wr(clk_wr), .rst_wr_n(rst_wr_n));
  fifo_rd_if rd_vif(.clk_rd(clk_rd), .rst_rd_n(rst_rd_n));

  // DUT instantiation
  afifo dut (
    .clk_wr(wr_vif.clk_wr),
    .rst_wr_n(wr_vif.rst_wr_n),
    .wr_en(wr_vif.wr_en),
    .wr_data(wr_vif.wr_data),
    .full(wr_vif.full),
    .clk_rd(rd_vif.clk_rd),
    .rst_rd_n(rd_vif.rst_rd_n),
    .rd_en(rd_vif.rd_en),
    .rd_data(rd_vif.rd_data),
    .empty(rd_vif.empty)
  );

  // UVM Configuration Database
  initial begin
    uvm_config_db #(virtual fifo_wr_if)::set(null, "uvm_test_top.m_env.m_wr_agent.m_drv", "wr_vif", wr_vif);
    uvm_config_db #(virtual fifo_wr_if)::set(null, "uvm_test_top.m_env.m_wr_agent.m_mon", "wr_vif", wr_vif);
    uvm_config_db #(virtual fifo_rd_if)::set(null, "uvm_test_top.m_env.m_rd_agent.m_drv", "rd_vif", rd_vif);
    uvm_config_db #(virtual fifo_rd_if)::set(null, "uvm_test_top.m_env.m_rd_agent.m_mon", "rd_vif", rd_vif);
  end

  // Run the test
  initial begin
    run_test("fifo_base_test");
  end
endmodule