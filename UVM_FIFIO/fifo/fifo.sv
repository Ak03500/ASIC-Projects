module fifo #(parameter DATA_WIDTH=8, parameter ADDR_WIDTH=4, parameter DEPTH = 16)(
    //write signals
    input logic clk_wrt,
    input logic rst_wrt,
    input logic wrt_en,
    input logic [DATA_WIDTH-1:0] data_wrt,
    output logic full,
    //read signals
    input logic clk_rd,
    input logic rst_rd,
    input logic rd_en,
    input logic [DATA_WIDTH-1:0] data_rd,
    output logic empty
);
//fifo creation
logic [DATA_WIDTH-1:0] fifo [DEPTH-1:0];

//pointers
logic [ADDR_WIDTH - 1:0] wrt_ptr_bin;
logic [ADDR_WIDTH - 1:0] wrt_ptr_gray;
logic [ADDR_WIDTH - 1:0] rd_ptr_bin;
logic [ADDR_WIDTH - 1:0] rd_ptr_gray;
logic [ADDR_WIDTH - 1:0] wrt_ptr_gray_sync;
logic [ADDR_WIDTH - 1:0] rd_ptr_gray_sync;

gray_counter #(ADDR_WIDTH) wrt_ptr (.clk(clk), .rst(rst_wrt), .en(wrt_en && !full), .bin(wrt_ptr_bin), .gray(wrt_ptr_gray)); //write pointer
gray_counter #(ADDR_WIDTH) rd_ptr (.clk(clk), .rst(rst_rd), .en(rd_en && !empty), .bin(rd_ptr_bin), .gray(rd_ptr_gray)); //read pointer
fifo_sync #(ADDR_WIDTH) wrt_ptr_sync(.clk_dst(clk_rd), .rst_dst(rst_rd), .gray_src(wrt_ptr_gray), .gray_dst(wrt_ptr_gray_sync)); //synchronize write with read
fifo_sync #(ADDR_WIDTH) wrt_ptr_sync(.clk_dst(clk_wrt), .rst_dst(rst_wrt), .gray_src(rd_ptr_gray), .gray_dst(rd_ptr_gray_sync)); //synchronize read with write

assign full = (wrt_ptr_gray == rd_ptr_gray_sync) && (wrt_ptr_bin[ADDR_WIDTH] != rd_ptr_bin[ADDR_WIDTH]);

assign empty = (rd_ptr_gray == wrt_ptr_gray_sync);

//memory logic
always_ff @(posedge clk_wrt)begin
    if (wrt_en && !full)begin
        mem[wrt_ptr_bin[ADDR_WIDTH - 1:0]] <= data_wrt;
    end
end

assign data_rd = mem[rd_ptr_bin[ADDR_WIDTH-1:0]]; //read memory

endmodule