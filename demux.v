// Demultiplexer Designs
// Includes: 1:2 DEMUX, 1:4 DEMUX, 1:8 DEMUX

// 1:2 Demultiplexer
// sel=0 -> out0=in, out1=0
// sel=1 -> out0=0,  out1=in
module demux1to2 (
    input  wire in,
    input  wire sel,
    output wire out0,
    output wire out1
);
    assign out0 = (~sel) & in;
    assign out1 =   sel  & in;
endmodule

// 1:4 Demultiplexer
// sel[1:0] routes input to one of 4 outputs
module demux1to4 (
    input  wire       in,
    input  wire [1:0] sel,
    output reg  [3:0] out
);
    always @(*) begin
        out = 4'b0000;
        case (sel)
            2'b00: out[0] = in;
            2'b01: out[1] = in;
            2'b10: out[2] = in;
            2'b11: out[3] = in;
        endcase
    end
endmodule

// 1:8 Demultiplexer
// sel[2:0] routes input to one of 8 outputs
module demux1to8 (
    input  wire       in,
    input  wire [2:0] sel,
    output reg  [7:0] out
);
    always @(*) begin
        out = 8'b00000000;
        case (sel)
            3'b000: out[0] = in;
            3'b001: out[1] = in;
            3'b010: out[2] = in;
            3'b011: out[3] = in;
            3'b100: out[4] = in;
            3'b101: out[5] = in;
            3'b110: out[6] = in;
            3'b111: out[7] = in;
        endcase
    end
endmodule
