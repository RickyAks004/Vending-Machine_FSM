// Code your testbench here
// or browse Examples

module test;

  // Inputs
  reg clock;
  reg reset;
  reg mode;
  reg button1;
  reg button2;
  reg button3;
  reg button4;

  // Output
  wire [7:0] leds;

  // FIXED: Corrected module instantiation syntax (added module name and instance label properly)
  votingMachine UUT(
      .clock(clock),
      .reset(reset),
      .mode(mode),
      .button1(button1),
      .button2(button2),
      .button3(button3),
      .button4(button4),
      .led(leds)   // FIXED: Added missing connection to output wire 'leds'
  );

  // FIXED: Corrected clock toggle operation (-clock to ~clock)
  initial begin
    clock = 0;
    forever #5 clock = ~clock;
  end

  initial begin
    // Initialization
    reset = 1; mode = 0; button1 = 0; button2 = 0; button3 = 0; button4 = 0;
    #10 reset = 0;   // FIXED: Added proper reset deassertion
    
    // Wait 100ns for global reset to finish
    #100;

    // Stimulus
    button1 = 1; #50; button1 = 0;
    button2 = 1; #50; button2 = 0;
    button3 = 1; #50; button3 = 0;
    button4 = 1; #50; button4 = 0;

    // Mode switch test
    #50 mode = 1;
    #100;

    $finish;
  end

  // FIXED: Typo 'intial' → 'initial'
  initial begin
    $dumpfile("dump.vcd");   // FIXED: Moved before $dumpvars for correct order
    $dumpvars(0, test);
  end

  // FIXED: Added missing 'begin-end' block correction and proper waveform variables
  initial begin
    $monitor($time, 
      " mode = %b, button1 = %b, button2 = %b, button3 = %b, button4 = %b, leds = %h", 
      mode, button1, button2, button3, button4, leds);
  end

endmodule

  
 