module fifomem #(parameter datawidth =8,parameter addr_width=3)
  (input [datawidth-1:0]wdata,input wlcken,wclk,input [addr_width-1:0]wadrr,raddr
   output  [addr_width-1:0] rdata);

  localparam fifo_depth=1<<addr_width;
  
  // ram having fifodepth no. of location with each location datawidth wide
  reg [datawidth-1:0]fifo_ram[0:fifo_depth-1];  

  always@(posedge wclk) begin
    if(wclken) fifo_ram[waddr]<=wdata;
  end

  assign rdata=fifo_ram[raddr];
endmodule

  

  
  
