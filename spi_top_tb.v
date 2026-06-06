module spi_top_tb;

reg clk;
reg reset;
reg tx_start;
reg [7:0] master_data_in;
reg [7:0] slave_data_in;

wire tx_done;
wire [7:0] master_data_out;
wire [7:0] slave_data_out;

spi_top dut (
    .clk(clk),
    .reset(reset),
    .tx_start(tx_start),
    .master_data_in(master_data_in),
    .slave_data_in(slave_data_in),
    .tx_done(tx_done),
    .master_data_out(master_data_out),
    .slave_data_out(slave_data_out)
);

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    reset = 0;
    tx_start = 0;
    master_data_in = 8'hA5;
    slave_data_in = 8'h3C;

    #20;
    reset = 1;

    #20;
    tx_start = 1;
    #10;
    tx_start = 0;

    #6000;

    $display("MASTER TX DATA = %h", master_data_in);
    $display("SLAVE  TX DATA = %h", slave_data_in);
    $display("MASTER RX DATA = %h", master_data_out);
    $display("SLAVE  RX DATA = %h", slave_data_out);
    $display("TX_DONE        = %b", tx_done);
    
    $finish;
end

endmodule