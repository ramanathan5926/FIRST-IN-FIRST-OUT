module fifo (
    input  wire        clk,
    input  wire        rst,
    input  wire        wr_en,
    input  wire        rd_en,
    input  wire [7:0]  buf_in,

    output reg  [7:0]  buf_out,
    output wire        buf_empty,
    output wire        buf_full,
    output reg  [6:0]  fifo_counter
);

    // FIFO memory (64 x 8)
    reg [7:0] buf_mem [0:63];

    // Read & Write pointers
    reg [5:0] rd_ptr;
    reg [5:0] wr_ptr;

    // Empty & Full flags
    assign buf_empty = (fifo_counter == 0);
    assign buf_full  = (fifo_counter == 64);

    // -------------------------
    // WRITE OPERATION
    // -------------------------
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            wr_ptr <= 0;
        end else if (wr_en && !buf_full) begin
            buf_mem[wr_ptr] <= buf_in;
            wr_ptr <= wr_ptr + 1;
        end
    end

    // -------------------------
    // READ OPERATION
    // -------------------------
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            rd_ptr  <= 0;
            buf_out <= 0;
        end else if (rd_en && !buf_empty) begin
            buf_out <= buf_mem[rd_ptr];
            rd_ptr  <= rd_ptr + 1;
        end
    end

    // -------------------------
    // FIFO COUNTER
    // -------------------------
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            fifo_counter <= 0;
        end else begin
            case ({wr_en && !buf_full, rd_en && !buf_empty})
                2'b10: fifo_counter <= fifo_counter + 1; // write only
                2'b01: fifo_counter <= fifo_counter - 1; // read only
                default: fifo_counter <= fifo_counter;   // both or none
            endcase
        end
    end

endmodule
