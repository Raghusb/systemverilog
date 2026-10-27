interface dff_if(input clk);
logic rst;
logic d;
logic q;

clocking cb @(posedge clk);
default input #1 output #0;
output rst;
output d;
input q;
endclocking

modport DUT(input rst,input d, input clk, output q);

task sync_reset;
cb.rst <= 1'b1;
cb.d<= 1'b1;
repeat(2)
@(cb);
if(q!==1'b0)
$display("RESET NOT WORKING");
else
$display("RESET WORKING");
endtask

task load(input logic data);

cb.rst <=1'b0;
cb.d <= data;

repeat(2)
if(q!==data)
$display("Value is not loaded");
else
$display("Value is loaded");

endtask


modport TEST(clocking cb, import task sync_reset(), import task load(input logic data) );
endinterface


module dflip_flop(dff_if.DUT duf);

always@(posedge duf.clk)
begin
if(duf.rst)
duf.q <= 1'b0;
else
duf.q <= duf.d;
end

endmodule
