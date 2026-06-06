# SPI Controller (Master-Slave) using Verilog HDL

## Overview

This project implements a simple SPI (Serial Peripheral Interface) Controller using Verilog HDL. The design consists of an SPI Master and an SPI Slave communicating in full-duplex mode. Both modules are integrated in a top-level design and verified using a self-checking testbench.

## Features

* SPI Master with FSM-based control
* SPI Slave for serial data transfer
* Full-duplex communication
* Clock divider for SPI clock generation
* Bit-by-bit serial transmission and reception
* Self-checking testbench
* Synthesizable RTL design

## Master FSM

The SPI Master is implemented using four states:

* IDLE
* LOAD
* SHIFT
* DONE

State Flow:

```
IDLE --> LOAD --> SHIFT --> DONE --> IDLE
```

## Project Files

```
spi_master.v   
spi_slave.v       
spi_top.v         
spi_top_tb.v      
README.md         
```

## Simulation

### Test Data

* Master Transmit Data : A5
* Slave Transmit Data  : 3C

### Result

* Master Received Data : 3C
* Slave Received Data  : A5

```
MASTER TX DATA = A5
SLAVE  TX DATA = 3C
MASTER RX DATA = 3C
SLAVE  RX DATA = A5
PASS
```

## Design Verification

The design was verified through simulation in Vivado using a self-checking testbench. The SPI Master and SPI Slave successfully exchanged data, confirming correct full-duplex operation.

## Synthesis

The design is fully synthesizable and can be implemented on FPGA devices. During synthesis, Vivado may optimize internal logic, so the synthesized schematic can differ from the RTL structure while maintaining identical functionality.

## Tools Used

* Verilog HDL
* Xilinx Vivado
* RTL Simulation
* Synthesis

## Learning Outcomes

* RTL Design
* Finite State Machine (FSM) Design
* SPI Protocol
* Serial Communication
* Verilog HDL
* Functional Verification
* FPGA Design Flow
* Synthesis and Optimization Concepts

## Future Improvements

* Configurable SPI Modes (CPOL/CPHA)
* Variable Data Width
* Multi-Slave Support
* Configurable Clock Divider

---

This project was developed as part of my RTL Design learning journey to strengthen my understanding of digital design and communication protocols.
