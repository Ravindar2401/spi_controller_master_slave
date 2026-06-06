module spi_master(
    input clk,
    input reset,
    input tx_start,
    input miso,
    input [7:0] data_in,

    output reg ss,
    output reg mosi,
    output reg tx_done,
    output reg sclk,
    output reg [7:0] data_out
);

parameter IDLE  = 2'b00,
          LOAD  = 2'b01,
          SHIFT = 2'b10,
          DONE  = 2'b11;

parameter DIV_VALUE = 5;

reg [$clog2(DIV_VALUE)-1:0] count;
reg [1:0] state, next_state;
reg [3:0] bit_count;

reg sclk_tick;

reg [7:0] shift_tx;
reg [7:0] shift_rx;

always @(posedge clk or negedge reset)
begin
    if(!reset)
    begin
        count     <= 0;
        sclk      <= 0;
        sclk_tick <= 0;
    end
    else if(state == SHIFT)
    begin
        if(count == DIV_VALUE-1)
        begin
            count     <= 0;
            sclk      <= ~sclk;
            sclk_tick <= 1;
        end
        else
        begin
            count     <= count + 1;
            sclk_tick <= 0;
        end
    end
    else
    begin
        count     <= 0;
        sclk      <= 0;
        sclk_tick <= 0;
    end
end

always @(posedge clk or negedge reset)
begin
    if(!reset)
    begin
        shift_tx  <= 8'd0;
        shift_rx  <= 8'd0;
        bit_count <= 4'd0;
        mosi      <= 1'b0;
        data_out  <= 8'd0;
    end
    else
    begin
        if(state == LOAD)
        begin
            shift_tx  <= data_in;
            shift_rx  <= 8'd0;
            bit_count <= 4'd0;
            data_out  <= 8'd0;
            mosi <= data_in[7];
        end

        else if(state == SHIFT && sclk_tick)
        begin

            if(sclk == 1)
            begin
                shift_rx <= {shift_rx[6:0], miso};
                data_out <= {shift_rx[6:0], miso};
                bit_count <= bit_count + 1'b1;
            end


            else
            begin
                shift_tx <= {shift_tx[6:0],1'b0};
                mosi     <= shift_tx[6];
            end
        end
    end
end

always @(posedge clk or negedge reset)
begin
    if(!reset)
        state <= IDLE;
    else
        state <= next_state;
end

always @(*)
begin
    case(state)

        IDLE :
            next_state = tx_start ? LOAD : IDLE;

        LOAD :
            next_state = SHIFT;

        SHIFT :
            next_state = (bit_count == 4'd8) ? DONE : SHIFT;

        DONE :
            next_state = IDLE;

        default :
            next_state = IDLE;

    endcase
end

always @(*)
begin
    ss      = (state == IDLE || state == DONE);
    tx_done = (state == DONE);
end

endmodule