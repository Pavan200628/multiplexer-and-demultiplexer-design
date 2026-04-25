# Multiplexer and Demultiplexer Design

Verilog implementations of Multiplexer (MUX) and Demultiplexer (DEMUX) circuits.

## Files

| File | Description |
|------|-------------|
| `mux.v` | Multiplexer modules: 2:1, 4:1, 8:1 |
| `demux.v` | Demultiplexer modules: 1:2, 1:4, 1:8 |
| `mux_tb.v` | Testbench for all MUX modules |
| `demux_tb.v` | Testbench for all DEMUX modules |

## Multiplexer (MUX)

A multiplexer selects one of several input signals and forwards the selected input to a single output line.

### 2:1 MUX (`mux2to1`)

| sel | out |
|-----|-----|
| 0   | i0  |
| 1   | i1  |

### 4:1 MUX (`mux4to1`)

| sel[1:0] | out |
|----------|-----|
| 00       | i0  |
| 01       | i1  |
| 10       | i2  |
| 11       | i3  |

### 8:1 MUX (`mux8to1`)

| sel[2:0] | out  |
|----------|------|
| 000      | i[0] |
| 001      | i[1] |
| ...      | ...  |
| 111      | i[7] |

## Demultiplexer (DEMUX)

A demultiplexer takes a single input signal and routes it to one of several output lines based on select signals.

### 1:2 DEMUX (`demux1to2`)

| sel | out0 | out1 |
|-----|------|------|
| 0   | in   | 0    |
| 1   | 0    | in   |

### 1:4 DEMUX (`demux1to4`)

| sel[1:0] | active output |
|----------|---------------|
| 00       | out[0]        |
| 01       | out[1]        |
| 10       | out[2]        |
| 11       | out[3]        |

### 1:8 DEMUX (`demux1to8`)

| sel[2:0] | active output |
|----------|---------------|
| 000      | out[0]        |
| 001      | out[1]        |
| ...      | ...           |
| 111      | out[7]        |

## Simulation

Simulate using [Icarus Verilog](http://iverilog.icarus.com/):

```bash
# MUX testbench
iverilog -o mux_sim mux.v mux_tb.v && vvp mux_sim

# DEMUX testbench
iverilog -o demux_sim demux.v demux_tb.v && vvp demux_sim
```