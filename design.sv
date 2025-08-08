//mealy non overlap 1011
module seq_detector_1011(clk, rst_n, x, z);
  input clk, rst_n, x;
  output z;

  reg [3:0] state, next_state;
  reg z;

  // State encoding
  parameter A = 4'h1,
            B = 4'h2,
            C = 4'h3,
            D = 4'h4;

  // State register
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
      state <= A;
    else
      state <= next_state;
  end

  // Next-state logic and Mealy output
  always @(state or x) begin
    z = 0;  // Default output
    case (state)
      A: begin
        if (x) next_state = B;
        else   next_state = A;
      end
      B: begin
        if (x) next_state = B;
        else   next_state = C;
      end
      C: begin
        if (x) next_state = D;
        else   next_state = A;
      end
      D: begin
        if (x) begin
          next_state = A; // Non-overlap → reset to start
          z = 1; // Output when pattern 1011 ends
        end
        else begin
          next_state = C;
          z = 0;
        end
      end
      default: next_state = A;
    endcase
  end
endmodule
