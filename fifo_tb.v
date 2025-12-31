`include "fifo.v"

module fifo_tb;

    reg clk;
    reg rst;
    reg wr_en;
    reg rd_en;
    reg [7:0] buf_in;

    wire [7:0] buf_out;
    wire buf_empty;
    wire buf_full;
    wire [6:0] fifo_counter;

    // DUT instantiation
    fifo dut (
        .clk(clk),
        .rst(rst),
        .buf_in(buf_in),
        .buf_out(buf_out),
        .wr_en(wr_en),
        .rd_en(rd_en),
        .buf_empty(buf_empty),
        .buf_full(buf_full),
        .fifo_counter(fifo_counter)
    );

    // Clock generation (10ns period)
    always #5 clk = ~clk;

    
    initial begin
        // Initial values
        clk = 0;
        rst = 1;
        wr_en = 0;
        rd_en = 0;
        buf_in = 0;

        // Reset
        #10 rst = 0;

        // WRITE 3 values into FIFO
        @(posedge clk);
        wr_en = 1; buf_in = 8'h11;

        @(posedge clk);
        buf_in = 8'h22;

        @(posedge clk);
        buf_in = 8'h33;

        @(posedge clk);
        wr_en = 0;

        // READ 3 values from FIFO
        @(posedge clk);
        rd_en = 1;

        @(posedge clk);
        @(posedge clk);
        @(posedge clk);

        rd_en = 0;

        // Simultaneous READ & WRITE
        @(posedge clk);
        wr_en = 1; rd_en = 1; buf_in = 8'h44;

        @(posedge clk);
        wr_en = 0; rd_en = 0;

        #20 $finish;
    end


    initial begin
        $monitor("TIME=%0t | wr=%b rd=%b in=%h out=%h | empty=%b full=%b count=%d",
                  $time, wr_en, rd_en, buf_in, buf_out,
                  buf_empty, buf_full, fifo_counter);
    end

    
    initial begin
        $dumpfile("fifo.vcd");
        $dumpvars(0, fifo_tb);
    end

endmodule
