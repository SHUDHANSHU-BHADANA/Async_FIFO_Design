module twoflopsync #(parameter addr_width=3) (input clk,rstn,input [addr_width:0] ptr,output reg [addr_width:0] q2);
  reg [addr_width:0] q1;

  always@(posedge clk or negedge rstn) begin
    
    if(!rstn) begin
      q2<=0;
      q1<=0;end
    else begin
      q1<=ptr;
      q2<=q1;
    end  
  end

endmodule
  
