module fifo_sync #(parameter ADDR_WIDTH = 4)(
    input logic clk_dst, //destination clock 
    input logic rst_dst, //active low for destination clock
    input logic [ADDR_WIDTH - 1:0] gray_src,
    output logic [ADDR_WIDTH - 1:0] gray_dst
);

logic [ADDR_WIDTH - 1:0] reg_sync;

always_ff(posedge clk or negedge rst_dst)begin
    if(!rst_dst)begin
        reg_sync = '0;
        gray_dst = '0;
    end
    else begin
        reg_sync <= gray_src;
        gray_dst <= reg_sync;
    end
end
endmodule