module testcase(dff_if.TEST test_if);
    initial begin
        @(test_if.cb);

        test_if.sync_reset();
        test_if.load(1);
        test_if.load(0);
        test_if.load(1);
        test_if.load(1);

        #10;
        $finish;
    end
endmodule

module top();
    bit clk;

    always #10 clk = ~clk;

    dff_if IF(clk);
    dflip_flop RTL(IF);
    testcase TB(IF);
endmodule
