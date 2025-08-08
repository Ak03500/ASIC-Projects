interface fifo_rd_if (input logic clk_rd, input logic rst_rd_n);
  logic rd_en;
  logic [7:0] rd_data;
  logic empty;
endinterface