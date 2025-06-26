
module gray2binary #(parameter addr_size = 4)(
    input  [addr_size:0] gray,
    output reg [addr_size:0] binary
);
    integer i;
    always @(*) begin
        binary[addr_size] = gray[addr_size];  // MSB is same
        for (i = addr_size - 1; i >= 0; i = i - 1)
            binary[i] = binary[i + 1] ^ gray[i];
    end
endmodule

