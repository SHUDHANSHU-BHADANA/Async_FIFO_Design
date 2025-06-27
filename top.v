module fifodesign #(parameter datawidth=8,addr_width=3)
  (input [datawidth-1:0] wdata,input,winc,wclk,rinc,rclk,wrst_n,rrst_n,
   output [datawidth-1:0] rdata,output wfull,rempty);

  wire [addr_width:0] wptr,rptr,wq2_rptr,rq2_wptr,b2gr,b2gw,g2br,g2bw;
  wire [addr_width-1:0] wadrr,raddr;

  assign wclken=winc&(!wfull);

  twoflopsync #(.addr_width(addr_width)) s1 (.clk(wclk),.rstn(wrst_n),.ptr(b2gw),.q2(g2bw));
  twoflopsync #(.addr_width(addr_width)) s2(.clk(rclk),.rstn(rrst_n),.ptr(b2gr),.q2(g2br));

  binary2gray #(.addr_width(addr_width)) s3(.data(wptr),.gray(b2gw));
  binary2gray #(.addr_width(addr_width)) s4(.data(rptr),.gray(b2gr));

  gray2binary #(.addr_width(addr_width)) s5(.gray(g2bw),.binary(rq2_wptr));
  gray2binary #(.addr_width(addr_width)) s8(.gray(g2br),.binary(wq2_rptr));

  rptr_and_empty #(.addr_width(addr_width)) s6(.rinc(rinc),.rclk(rclk),.rrst_n(rrst_n),.rq2_wptr(rq2_wptr),.rptr(rptr),.raddr(raddr),.rempty(rempty));
  wptr_and_full #(.addr_width(addr_width)) s7(.winc(winc),.wclk(wclk),.wrst_n(wrst_n),.wq2_rptr(wq2_rptr),.wptr(wptr),.wadrr(waddr),.wfull(wfull));

  fifomem #(.addr_width(addr_width),.datawidth(datawidth)) s9(.wdata(wdata),.wclk(wclk),.wclken(wclken),.waddr(waddr),.raddr(raddr),.rdata(rdata));
endmodule
