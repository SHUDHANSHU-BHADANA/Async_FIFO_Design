`timescale 1ns / 1ps

module tb;

  parameter DATAWIDTH = 8;
  parameter ADDR_WIDTH = 3;

  reg                   wclk = 0, rclk = 0;
  reg                   wrst_n = 0, rrst_n = 0;
  reg                   winc = 0, rinc = 0;
  reg  [DATAWIDTH-1:0]  wdata;
  wire [DATAWIDTH-1:0]  rdata;
  wire                  wfull, rempty;
  wire [ADDR_WIDTH:0]   wptr, rptr;

  // Instantiate the FIFO
  top #(
    .datawidth(DATAWIDTH),
    .addr_width(ADDR_WIDTH)
  ) uut (
    .wdata(wdata),
    .winc(winc),
    .wclk(wclk),
    .rinc(rinc),
    .rclk(rclk),
    .wrst_n(wrst_n),
    .rrst_n(rrst_n),
    .rdata(rdata),
    .wfull(wfull),
    .rempty(rempty),
    .wptr(wptr),
    .rptr(rptr)
  );

  // Clock generation
  always #5 wclk = ~wclk;
  always #6.5 rclk = ~rclk;

  integer i;

  initial begin
    $dumpfile("fifo_dump.vcd");
    $dumpvars(0, tb);

    $monitor("Time=%0t | wdata=%0d | rdata=%0d | wptr=%b | rptr=%b | winc=%b | rinc=%b | wfull=%b | rempty=%b",
             $time, wdata, rdata, wptr, rptr, winc, rinc, wfull, rempty);

    // Reset
    wrst_n = 0; rrst_n = 0;
    winc = 0; rinc = 0;
    wdata = 0;

    #20;
    wrst_n = 1; rrst_n = 1;

    // Write to FIFO
    for (i = 0; i < 5; i = i + 1) begin
      @(posedge wclk);
      if (!wfull) begin
        wdata <= i + 1;
        winc <= 1;
        @(posedge wclk);
        winc <= 0;
      end
    end

    #50;

    // Read from FIFO
    for (i = 0; i < 5; i = i + 1) begin
      @(posedge rclk);
      if (!rempty) begin
        rinc <= 1;
        @(posedge rclk);
        rinc <= 0;
        $display("Read at %0t: %0d", $time, rdata);
      end
    end

    #50;
    $finish;
  end

endmodule

