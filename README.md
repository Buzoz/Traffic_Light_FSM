# Traffic_Light_FSM
This is a digital logic project I built using SystemVerilog. It's a traffic light controller that includes a pedestrian crossing system, designed to be simulated and deployed on a Real Digital Boolean Board (Spartan-7 FPGA).
How It Works
The core of the system is a Finite State Machine (FSM) that manages the traffic flow. By default, the traffic light stays green for cars. When a pedestrian wants to cross and flips the "walk" switch, the system safely transitions the car traffic light from green to yellow, and then to red.

While the cars have a red light, a blue LED turns on to signal to pedestrians that it's safe to cross. Right before the crossing time is over, this blue LED flashes to warn pedestrians that the light is about to change. Once the cycle is complete, the system automatically resets to the green state.

## Module Breakdown

* **Traffic_Light_FSM: It is a standard state machine that cycles through the Green, Yellow, Red, and Flash states. It decides when to change lights based on the pedestrian "walk" signal and a "timer_done" flag.

* **ROM: A simple read-only memory block used as a look-up table. Depending on the current state of the FSM (fed as a 3-bit input), it outputs the specific number of clock cycles that state should last.

* **Countdown_Timer: A counter that tracks how long a state has been active. When loaded with a duration value from the ROM, it counts down to zero and flags the "timer_done" signal to tell the FSM it is time to move to the next state.

* **Change_Detector: A module that keeps an eye on the FSM's outputs. Whenever the state changes, it generates a quick pulse that lasts exactly one clock cycle. This pulse triggers the timer to load the new duration from the ROM.

* **MUX: A simple multiplexer used to handle the pedestrian light. It routes either a solid signal or the clock signal to the blue LED, which creates the blinking effect during the warning phase.

* **Traffic_Light: This is the main wrapper for the core logic. It wires the FSM, ROM, Timer, Change Detector, and Mux together into a single, fully functional traffic light unit.

* **CLK_Delay: Because the FPGA runs on a very fast 100MHz clock, the state transitions would happen way too fast to see. This module uses a 32-bit counter to divide the clock, picking the 28th bit to act as a much slower, human-readable clock signal.

* **TOP: The final wrapper built specifically for the physical board. It maps the hardware inputs and outputs, routes the fast FPGA clock through the CLK_Delay module, and feeds that slowed-down clock into the main Traffic_Light module.
