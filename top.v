module fifodesign #(parameter datawidth=8,addr_width=3)
  (input [datawidth-1:0] wdata,input,winc,wclk,rinc,rclk,wrst_n,rrst_n,
   output [datawidth-1:0] rdata,output wfull,rempty);

  wire [addr_width:0] wptr,rptr,wq2_ptr,rq2_ptr;
  wire [addr_width-1:0] wadrr,raddr;

  assign wclken=winc&(!wfull);

  twoflopsync #(.addr_width(addr_width))(.clk(wclk),.rstn(wrst_n)
  
