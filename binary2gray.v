module binary2gray #(parameter addr_size=4)(
    input  [addr_size:0] data,
    output reg [addr_size:0] gray
);
    integer i;
    always @(*) begin
        gray[addr_size] = data[addr_size];
        for(i = addr_size; i > 0; i = i - 1)
            gray[i-1] = data[i] ^ data[i-1];
    end
endmodule

