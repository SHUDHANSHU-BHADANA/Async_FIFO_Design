module binary2gray #(parameter addr_width=3)(
    input  [addr_width:0] data,
    output reg [addr_width:0] gray
);
    integer i;
    always @(*) begin
        gray[addr_width] = data[addr_width];
        for(i = addr_width; i > 0; i = i - 1)
            gray[i-1] = data[i] ^ data[i-1];
    end
endmodule

