
module gray2binary #(parameter addr_width = 4)(
    input  [addr_width:0] gray,
    output reg [addr_width:0] binary
);
    integer i;
    always @(*) begin
        binary[addr_width] = gray[addr_width];  // MSB is same
        for (i = addr_width - 1; i >= 0; i = i - 1)
            binary[i] = binary[i + 1] ^ gray[i];
    end
endmodule

