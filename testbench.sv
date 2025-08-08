module testbench;
  bit clk;
  bit rst_n;
  bit x;
  wire z;
  integer count = 0;

  // Instantiate the FSM
  seq_detector_1011 dut (
    .clk(clk),
    .rst_n(rst_n),
    .x(x),
    .z(z)
  );

  // Clock generation
  initial clk = 0;
  always #5 clk = ~clk;

  // Monitor detection
  always @(posedge clk) begin
    if (z) begin
      count++;
      $display(">>> 1011 detected at time %0t (Count = %0d)", $time, count);
    end
  end

  // Stimulus generation
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, dut);

    // Reset the FSM
    x = 0;
    rst_n = 0;
    @(posedge clk); 
    @(posedge clk); rst_n = 1;

  
   
   // First 1011 detection
   @(posedge clk); x = 1;
   @(posedge clk); x = 0;
   @(posedge clk); x = 1;
   @(posedge clk); x = 1; // should detect here

  // Non-overlapping → insert gap
   @(posedge clk); x = 0; // allows FSM to reset

   // Second 1011 detection
   @(posedge clk); x = 1;
   @(posedge clk); x = 0;
   @(posedge clk); x = 1;
   @(posedge clk); x = 1; // should detect again


    // Random noise
    @(posedge clk); x = 1;
    @(posedge clk); x = 1;
    @(posedge clk); x = 0;

    #20;
    $display("Time:%0d === Total Sequences Detected: %0d ===", $time,count);
    $finish;
  end
  
  initial begin
    $monitor("Time:%0d X: %0d Z:%0d",$time,x,z); 
  end
endmodule
