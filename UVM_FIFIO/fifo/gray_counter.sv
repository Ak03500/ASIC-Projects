module gray_counter #(
    parameter ADDR_WIDTH = 4;
)(
    input logic clk,
    input logic rst, //active low
    input logic enable,
    output logic [ADDR_WIDTH - 1:0] bin, 
    output logic [ADDR_WIDTH - 1:0] gray
);
logic [ADDR_WIDTH - 1:0] nextBin;

always_ff @( posedge clk or negedge rst ) begin 
    if(!rst)begin
        bin <= 0;
    end
    else if(en)begin
        bin <= nextBin;
    end
end
assign nextBin = bin + 1;
assign gray = (bin >> 1)^bin; //generates gray code 

endmodule