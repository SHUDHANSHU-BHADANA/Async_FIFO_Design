module fifomem #(parameter datawidth = 8, parameter addr_width = 3)
(
  input  [datawidth-1:0] wdata,
  input                  wclken,
  input                  wclk,
  input                  rempty,
  input  [addr_width-1:0] waddr,
  input  [addr_width-1:0] raddr,
  output [datawidth-1:0] rdata
);

  localparam fifo_depth = 1 << addr_width;

  // RAM having 'fifo_depth' locations, each 'datawidth' wide
  reg [datawidth-1:0] fifo_ram [0:fifo_depth-1];

  // Write logic
  always @(posedge wclk) begin
    if (wclken)
      fifo_ram[waddr] <= wdata;
  end

  // Combinational read
  assign rdata = rempty?0:fifo_ram[raddr];

endmodule
