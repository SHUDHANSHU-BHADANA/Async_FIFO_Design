module wptr_and_full #(parameter addr_width = 3)
(
  input winc,
  input wclk,
  input wrst_n,
  input [addr_width:0] wq2_rptr,  // Synchronized read pointer (Gray code) from read domain

  output reg [addr_width:0] wptr,
  output reg [addr_width-1:0] waddr,
  output wfull
);

  // Compute next write pointer
  wire [addr_width:0] wptr_next = wptr + 1;

  // FIFO is full when wrap around
  assign wfull = (wq2_rptr=={~wptr[addr_width],wptr[addr_width-1:0]});

  always @(posedge wclk or negedge wrst_n) begin
    if (!wrst_n) begin
      wptr  <= 0;
      waddr <= 0;
    end else begin
      if (winc && !wfull)
        wptr <= wptr_next;

      waddr <= wptr[addr_width-1:0];
    end
  end

endmodule

