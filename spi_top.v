module spi_top(
    input clk,
    input reset,
    input tx_start,
    input [7:0] master_data_in,
    input [7:0] slave_data_in,

    output tx_done,
    output [7:0] master_data_out,
    output [7:0] slave_data_out
);

wire sclk_wire;
wire ss_wire;
wire mosi_wire;
wire miso_wire;

spi_master master(
    .clk(clk),
    .reset(reset),
    .tx_start(tx_start),
    .miso(miso_wire),
    .data_in(master_data_in),
    .ss(ss_wire),
    .mosi(mosi_wire),
    .tx_done(tx_done),
    .sclk(sclk_wire),
    .data_out(master_data_out)
);

spi_slave slave(
    .sclk(sclk_wire),
    .reset(reset),
    .ss(ss_wire),
    .mosi(mosi_wire),
    .miso(miso_wire),
    .data_in(slave_data_in),
    .data_out(slave_data_out)
);

endmodule