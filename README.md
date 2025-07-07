# Advanced Voting Machine (Verilog)

This project simulates an **advanced voting machine** using Verilog HDL. It features:

- Password-protected voting access
- Five candidate options (A, B, C, D, E)
- Tie detection
- Seven-segment display output for winner
- FSM-based design
- Testbench for simulation

## Files

- `voting_machine_advanced.v`: Main Verilog module
- `voting_machine_advanced_tb.v`: Testbench to simulate voting scenario
- `README.md`: Project overview

## How It Works

1. **Reset** the machine.
2. **Start** the voting session.
3. **Authenticate** with the correct password.
4. **Vote** for any one of the five candidates.
5. **End voting** to calculate and display the winner.
6. Winner is shown via a **7-segment encoded output**.

## Simulation

Use a Verilog simulator like ModelSim, Icarus Verilog, or Vivado to run the testbench.

## Author

This is part of a digital systems project simulating secure voting mechanisms.

