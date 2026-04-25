// Testbench for Demultiplexer Designs
`timescale 1ns/1ps

module demux_tb;

    // -------------------------------------------------------
    // 1:2 DEMUX testbench
    // -------------------------------------------------------
    reg  tb_in_2, tb_sel_2;
    wire tb_out0_2, tb_out1_2;

    demux1to2 uut_demux2 (
        .in   (tb_in_2),
        .sel  (tb_sel_2),
        .out0 (tb_out0_2),
        .out1 (tb_out1_2)
    );

    // -------------------------------------------------------
    // 1:4 DEMUX testbench
    // -------------------------------------------------------
    reg        tb_in_4;
    reg  [1:0] tb_sel_4;
    wire [3:0] tb_out_4;

    demux1to4 uut_demux4 (
        .in  (tb_in_4),
        .sel (tb_sel_4),
        .out (tb_out_4)
    );

    // -------------------------------------------------------
    // 1:8 DEMUX testbench
    // -------------------------------------------------------
    reg        tb_in_8;
    reg  [2:0] tb_sel_8;
    wire [7:0] tb_out_8;

    demux1to8 uut_demux8 (
        .in  (tb_in_8),
        .sel (tb_sel_8),
        .out (tb_out_8)
    );

    integer pass_count;
    integer fail_count;

    task check1;
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

    task check_bus;
        input [7:0] expected;
        input [7:0] actual;
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

        $display("=== 1:2 DEMUX Tests ===");
        tb_in_2 = 1; tb_sel_2 = 0; #10;
        check1(1'b1, tb_out0_2, "1:2 sel=0 in=1 -> out0");
        check1(1'b0, tb_out1_2, "1:2 sel=0 in=1 -> out1=0");
        tb_in_2 = 1; tb_sel_2 = 1; #10;
        check1(1'b0, tb_out0_2, "1:2 sel=1 in=1 -> out0=0");
        check1(1'b1, tb_out1_2, "1:2 sel=1 in=1 -> out1");
        tb_in_2 = 0; tb_sel_2 = 0; #10;
        check1(1'b0, tb_out0_2, "1:2 sel=0 in=0 -> out0=0");
        tb_in_2 = 0; tb_sel_2 = 1; #10;
        check1(1'b0, tb_out1_2, "1:2 sel=1 in=0 -> out1=0");

        $display("=== 1:4 DEMUX Tests ===");
        tb_in_4 = 1; tb_sel_4 = 2'b00; #10;
        check_bus(8'd1, {4'b0, tb_out_4}, "1:4 sel=00 -> out[0]=1");
        tb_in_4 = 1; tb_sel_4 = 2'b01; #10;
        check_bus(8'd2, {4'b0, tb_out_4}, "1:4 sel=01 -> out[1]=1");
        tb_in_4 = 1; tb_sel_4 = 2'b10; #10;
        check_bus(8'd4, {4'b0, tb_out_4}, "1:4 sel=10 -> out[2]=1");
        tb_in_4 = 1; tb_sel_4 = 2'b11; #10;
        check_bus(8'd8, {4'b0, tb_out_4}, "1:4 sel=11 -> out[3]=1");
        tb_in_4 = 0; tb_sel_4 = 2'b10; #10;
        check_bus(8'd0, {4'b0, tb_out_4}, "1:4 sel=10 in=0 -> all zeros");

        $display("=== 1:8 DEMUX Tests ===");
        tb_in_8 = 1; tb_sel_8 = 3'b000; #10;
        check_bus(8'b00000001, tb_out_8, "1:8 sel=000");
        tb_in_8 = 1; tb_sel_8 = 3'b001; #10;
        check_bus(8'b00000010, tb_out_8, "1:8 sel=001");
        tb_in_8 = 1; tb_sel_8 = 3'b100; #10;
        check_bus(8'b00010000, tb_out_8, "1:8 sel=100");
        tb_in_8 = 1; tb_sel_8 = 3'b111; #10;
        check_bus(8'b10000000, tb_out_8, "1:8 sel=111");
        tb_in_8 = 0; tb_sel_8 = 3'b011; #10;
        check_bus(8'b00000000, tb_out_8, "1:8 sel=011 in=0 -> all zeros");

        $display("=== Summary: %0d passed, %0d failed ===", pass_count, fail_count);
        if (fail_count == 0)
            $display("All DEMUX tests PASSED.");
        else
            $display("Some DEMUX tests FAILED.");
        $finish;
    end

endmodule
