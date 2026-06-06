module spi_slave(
    input  wire       sclk,
    input  wire       reset,
    input  wire       ss,
    input  wire       mosi,
    input  wire [7:0] data_in,

    output wire       miso,
    output reg [7:0]  data_out
);

reg [7:0] rx_shift;
reg [7:0] tx_shift;
reg [3:0] bit_count;

always @(negedge ss or negedge reset)
begin
    if(!reset)
        tx_shift <= 8'd0;
    else
        tx_shift <= data_in;
end

always @(posedge sclk or negedge reset)
begin
    if(!reset)
    begin
        rx_shift  <= 8'd0;
        data_out  <= 8'd0;
        bit_count <= 4'd0;
    end
    else if(!ss)
    begin
        rx_shift  <= {rx_shift[6:0], mosi};
        data_out  <= {rx_shift[6:0], mosi};  
        bit_count <= bit_count + 1'b1;
    end
    else
    begin
        bit_count <= 4'd0;
    end
end
always @(negedge sclk or negedge reset)
begin
    if(!reset)
        tx_shift <= 8'd0;
    else if(!ss)
        tx_shift <= {tx_shift[6:0],1'b0};
end

assign miso = tx_shift[7];

endmodule