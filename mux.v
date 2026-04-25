// Multiplexer Designs
// Includes: 2:1 MUX, 4:1 MUX, 8:1 MUX

// 2:1 Multiplexer
// sel=0 -> out=i0, sel=1 -> out=i1
module mux2to1 (
    input  wire i0,
    input  wire i1,
    input  wire sel,
    output wire out
);
    assign out = sel ? i1 : i0;
endmodule

// 4:1 Multiplexer
// sel[1:0]=00 -> out=i0
// sel[1:0]=01 -> out=i1
// sel[1:0]=10 -> out=i2
// sel[1:0]=11 -> out=i3
module mux4to1 (
    input  wire i0,
    input  wire i1,
    input  wire i2,
    input  wire i3,
    input  wire [1:0] sel,
    output reg  out
);
    always @(*) begin
        case (sel)
            2'b00: out = i0;
            2'b01: out = i1;
            2'b10: out = i2;
            2'b11: out = i3;
            default: out = 1'bx;
        endcase
    end
endmodule

// 8:1 Multiplexer
// sel[2:0] selects one of the 8 inputs
module mux8to1 (
    input  wire [7:0] i,
    input  wire [2:0] sel,
    output reg  out
);
    always @(*) begin
        case (sel)
            3'b000: out = i[0];
            3'b001: out = i[1];
            3'b010: out = i[2];
            3'b011: out = i[3];
            3'b100: out = i[4];
            3'b101: out = i[5];
            3'b110: out = i[6];
            3'b111: out = i[7];
            default: out = 1'bx;
        endcase
    end
endmodule
