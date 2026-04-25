// Testbench for Multiplexer Designs
`timescale 1ns/1ps

module mux_tb;

    // -------------------------------------------------------
    // 2:1 MUX testbench
    // -------------------------------------------------------
    reg  tb_i0, tb_i1, tb_sel_2;
    wire tb_out_2;

    mux2to1 uut_mux2 (
        .i0  (tb_i0),
        .i1  (tb_i1),
        .sel (tb_sel_2),
        .out (tb_out_2)
    );

    // -------------------------------------------------------
    // 4:1 MUX testbench
    // -------------------------------------------------------
    reg  tb_a0, tb_a1, tb_a2, tb_a3;
    reg  [1:0] tb_sel_4;
    wire tb_out_4;

    mux4to1 uut_mux4 (
        .i0  (tb_a0),
        .i1  (tb_a1),
        .i2  (tb_a2),
        .i3  (tb_a3),
        .sel (tb_sel_4),
        .out (tb_out_4)
    );

    // -------------------------------------------------------
    // 8:1 MUX testbench
    // -------------------------------------------------------
    reg  [7:0] tb_i_8;
    reg  [2:0] tb_sel_8;
    wire tb_out_8;

    mux8to1 uut_mux8 (
        .i   (tb_i_8),
        .sel (tb_sel_8),
        .out (tb_out_8)
    );

    integer pass_count;
    integer fail_count;

    task check;
        input expected;
        input actual;
        input [127:0] test_name;
        begin
            if (expected === actual) begin
                $display("PASS: %0s", test_name);
                pass_count = pass_count + 1;
            end else begin
                $display("FAIL: %0s | expected=%b, got=%b", test_name, expected, actual);
                fail_count = fail_count + 1;
            end
        end
    endtask

    initial begin
        pass_count = 0;
        fail_count = 0;

        $display("=== 2:1 MUX Tests ===");
        tb_i0 = 0; tb_i1 = 1; tb_sel_2 = 0; #10;
        check(1'b0, tb_out_2, "2:1 sel=0 i0=0");
        tb_i0 = 1; tb_i1 = 0; tb_sel_2 = 0; #10;
        check(1'b1, tb_out_2, "2:1 sel=0 i0=1");
        tb_i0 = 0; tb_i1 = 1; tb_sel_2 = 1; #10;
        check(1'b1, tb_out_2, "2:1 sel=1 i1=1");
        tb_i0 = 1; tb_i1 = 0; tb_sel_2 = 1; #10;
        check(1'b0, tb_out_2, "2:1 sel=1 i1=0");

        $display("=== 4:1 MUX Tests ===");
        tb_a0 = 1; tb_a1 = 0; tb_a2 = 0; tb_a3 = 0; tb_sel_4 = 2'b00; #10;
        check(1'b1, tb_out_4, "4:1 sel=00");
        tb_a0 = 0; tb_a1 = 1; tb_a2 = 0; tb_a3 = 0; tb_sel_4 = 2'b01; #10;
        check(1'b1, tb_out_4, "4:1 sel=01");
        tb_a0 = 0; tb_a1 = 0; tb_a2 = 1; tb_a3 = 0; tb_sel_4 = 2'b10; #10;
        check(1'b1, tb_out_4, "4:1 sel=10");
        tb_a0 = 0; tb_a1 = 0; tb_a2 = 0; tb_a3 = 1; tb_sel_4 = 2'b11; #10;
        check(1'b1, tb_out_4, "4:1 sel=11");

        $display("=== 8:1 MUX Tests ===");
        tb_i_8 = 8'b00000001; tb_sel_8 = 3'b000; #10;
        check(1'b1, tb_out_8, "8:1 sel=000");
        tb_i_8 = 8'b00000010; tb_sel_8 = 3'b001; #10;
        check(1'b1, tb_out_8, "8:1 sel=001");
        tb_i_8 = 8'b10000000; tb_sel_8 = 3'b111; #10;
        check(1'b1, tb_out_8, "8:1 sel=111");
        tb_i_8 = 8'b11111110; tb_sel_8 = 3'b000; #10;
        check(1'b0, tb_out_8, "8:1 sel=000 i[0]=0");

        $display("=== Summary: %0d passed, %0d failed ===", pass_count, fail_count);
        if (fail_count == 0)
            $display("All MUX tests PASSED.");
        else
            $display("Some MUX tests FAILED.");
        $finish;
    end

endmodule
