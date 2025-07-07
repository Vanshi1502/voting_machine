# Advanced Voting Machine (Verilog)

This project implements a digital voting machine using a Finite State Machine (FSM) in Verilog. It is designed for simulation in Vivado or any Verilog-compatible simulator and demonstrates advanced digital design concepts suitable for academic or professional portfolios.

FEATURES:
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
## Seven-Segment Display Encoding

| Winner | Displayed Letter | Seven-Segment Code (`abcdefg`) |
|--------|------------------|-------------------------------|
| A      | A                | 0001000                       |
| B      | b                | 0000011                       |
| C      | C                | 1000110                       |
| D      | d                | 0100001                       |
| E      | E                | 0001110                       |
| Tie    | -                | 1111110                       |


## Author

This is part of a digital systems project simulating secure voting mechanisms.

