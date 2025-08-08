interface fifo_wr_if (input logic clk_wr, input logic rst_wr_n);
  logic wr_en;
  logic [7:0] wr_data;
  logic full;
endinterface