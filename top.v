module top #(parameter datawidth = 8, addr_width = 3)
(
  input  [datawidth-1:0] wdata,
  input  winc, wclk,
  input  rinc, rclk,
  input  wrst_n, rrst_n,
  output [datawidth-1:0] rdata,
  output wfull, rempty
);

  wire [addr_width:0] wptr, rptr;
  wire [addr_width:0] wq2_rptr, rq2_wptr;
  wire [addr_width:0] b2gr, b2gw;
  wire [addr_width:0] g2br, g2bw;
  wire [addr_width-1:0] waddr, raddr;
  wire wclken;

  assign wclken = winc & (~wfull);

  // Synchronize gray pointers across domains
  twoflopsync #(.addr_width(addr_width)) s1 (
    .clk(wclk), .rstn(wrst_n), .ptr(b2gw), .q2(g2bw)
  );

  twoflopsync #(.addr_width(addr_width)) s2 (
    .clk(rclk), .rstn(rrst_n), .ptr(b2gr), .q2(g2br)
  );

  // Binary to Gray
  binary2gray #(.addr_width(addr_width)) s3 (
    .data(wptr), .gray(b2gw)
  );

  binary2gray #(.addr_width(addr_width)) s4 (
    .data(rptr), .gray(b2gr)
  );

  // Gray to Binary
  gray2binary #(.addr_width(addr_width)) s5 (
    .gray(g2bw), .binary(rq2_wptr)
  );

  gray2binary #(.addr_width(addr_width)) s6 (
    .gray(g2br), .binary(wq2_rptr)
  );

  // Read and empty logic
  rptr_and_empty #(.addr_width(addr_width)) s7 (
    .rinc(rinc), .rclk(rclk), .rrst_n(rrst_n),
    .rq2_wptr(rq2_wptr), .rptr(rptr), .raddr(raddr), .rempty(rempty)
  );
  //write and full logic
  wptr_and_full #(.addr_width(addr_width)) s8 (
    .winc(winc), .wclk(wclk), .wrst_n(wrst_n),
    .wq2_rptr(wq2_rptr), .wptr(wptr), .waddr(waddr), .wfull(wfull)
  );

  // FIFO memory
  fifomem #(.addr_width(addr_width), .datawidth(datawidth)) s9 (
    .wdata(wdata), .wclken(wclken), .wclk(wclk),
    .waddr(waddr), .raddr(raddr), .rdata(rdata), .rempty(rempty)
  );

endmodule
