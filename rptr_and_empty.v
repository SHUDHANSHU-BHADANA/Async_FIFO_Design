module rptr_and_empty #(parameter addr_width = 3)
(
  input rinc,
  input rclk,
  input rrst_n,
  input [addr_width:0] rq2_wptr,  // synchronized wptr from write clock domain

  output reg [addr_width:0] rptr,
  output reg [addr_width-1:0] raddr,
  output rempty
);

  // Calculate next rptr
  wire [addr_width:0] rptr_next = rptr + 1;

  // FIFO is empty if rptr equals synchronized write pointer
  assign rempty = (!rrst_n) || (rq2_wptr == rptr);

  always @(posedge rclk or negedge rrst_n) begin
    if (!rrst_n) begin
      rptr <= 0;
      raddr <= 0;
    end else begin
      if (rinc && !rempty)
        rptr <= rptr_next;

      raddr <= rptr[addr_width-1:0];
    end
  end

endmodule
