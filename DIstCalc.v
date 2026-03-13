/*
# Team ID:          < 4513 >
# Theme:            < MazeSolver Bot >
# Author List:      < Parv Voraliya,Niraj Bailmare>
# Filename:         < Ultrasonic Distance Measurement >
# File Description: < This module will detect objects present in front of the range, and give the distance in mm. >
# Global variables: < None >
*/

/*
Module HC_SR04 Ultrasonic Sensor

This module will detect objects present in front of the range, and give the distance in mm.

Input:  clk_50M - 50 MHz clock
        reset   - reset input signal (Use negative reset)
        echo_rx - receive echo from the sensor

Output: trig    - trigger sensor for the sensor
        op     -  output signal to indicate object is present.
        distance_out - distance in mm, if object is present.
*/

// module Declaration
module t1b_ultrasonic(
    input clk_50M, reset, echo_rx,
    output reg trig,
    output op,
    output wire [15:0] distance_out
);

initial begin
    trig = 0;
end
//////////////////DO NOT MAKE ANY CHANGES ABOVE THIS LINE //////////////////
		// FSM States
		parameter IDLE = 2'b00;
		parameter TRIG_ON = 2'b01;
		parameter ECHO_COUNT = 2'b10;
		parameter WAIT_12MS = 2'b11;

		reg [31:0] counter = 0;
		integer distance_r = 0;
		reg [1:0] state, next_state;

		assign distance_out = (reset) ? distance_r[15:0] : 1'b0;
		assign op = (distance_out < 70)? 1 : 0 ;

		always @ (posedge clk_50M or negedge reset)
		begin

				if(!reset) 
				begin
						counter <= 0;
						trig <= 0;
						state <= IDLE;
				end

				else 
				begin
						counter <= counter + 1;
						case(state)
						   
							//---------------------------------------
							// 0) IDLE → wait 1 µs for sensor settle
                     //---------------------------------------
							IDLE: begin
							if(counter == 50) 
							begin
								state <= TRIG_ON;
								counter <= 0;
							end
							else
								state <= IDLE;
							end
							
							//---------------------------------------
							// 1) TRIGGER pulse high for 10 µs
						   //---------------------------------------							
							TRIG_ON: begin
							trig <= 1;
							if(counter == 500) 
							begin
								trig <= 0;
								state <= ECHO_COUNT;
								counter <= 0;
							end
							else 
								state <= TRIG_ON;
							end

							
							//---------------------------------------
							// 2) Count echo pulse high duration
							//---------------------------------------							 
							ECHO_COUNT: begin
							if(!echo_rx) 
							begin
								state <= WAIT_12MS;
								distance_r <= ((counter)*34)/10000 ;
							end
							else 
								state = ECHO_COUNT ;
							end

							//---------------------------------------
							// 3) Wait 12 ms before next trigger
							//---------------------------------------
							WAIT_12MS: begin
							if(counter < 600000) 
							begin
								state <= WAIT_12MS;
							end
							else
							begin 
								counter <= -1;
								state <= IDLE;
							end
							end
							default: state <= IDLE;
						endcase
				end
		end
		
		 // Next state logic
		 always @(*) begin
			  next_state = state;
			  case (state)
					IDLE: next_state = TRIG_ON;
					TRIG_ON: if (counter > 499 && echo_rx) next_state = ECHO_COUNT; // after 10 µs pulse
					ECHO_COUNT: if (!echo_rx) next_state = WAIT_12MS;
					WAIT_12MS: if (counter > 600000) next_state = IDLE; // 12 ms delay
					default: next_state = IDLE;
			  endcase
		 end

//////////////////DO NOT MAKE ANY CHANGES BELOW THIS LINE //////////////////

endmodule
