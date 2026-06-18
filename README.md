# apb-watchdog-timer-systemverilog
APB-Based Watchdog Timer implemented in SystemVerilog with configurable timeout, interrupt/reset generation, APB communication, and a self-checking verification environment for reliable fault monitoring in SoC systems

## Overview
This project presents the design and verification of an APB-Based Watchdog Timer implemented using SystemVerilog. The watchdog timer is a fault-monitoring peripheral commonly used in embedded systems and System-on-Chip (SoC) architectures to detect software failures such as processor hangs, infinite loops, and delayed responses.
The design is integrated with the AMBA Advanced Peripheral Bus (APB) protocol, allowing processor-controlled configuration through memory-mapped registers. A layered SystemVerilog verification environment is developed to validate functionality and ensure reliable operation.

## Objectives
- Design an APB-compliant Watchdog Timer.
- Implement configurable timeout functionality.
- Generate interrupt and reset signals during timeout conditions.
- Support watchdog refresh operations.
- Develop a self-checking SystemVerilog verification environment.
- Validate functionality through simulation and waveform analysis.

## Key Features
- APB Slave Interface
- Configurable Timeout Value
- 32-bit Watchdog Down Counter
- Watchdog Refresh Mechanism
- Interrupt Generation (WDOGINT)
- Reset Generation (WDOGRES)
- Memory-Mapped Register Access
- Layered Verification Architecture
- Self-Checking Scoreboard-Based Verification

## System Architecture
The APB-Based Watchdog Timer consists of the following major blocks:
1. APB Interface
2. Load Register
3. Control Register
4. Interrupt Clear Register
5. 32-bit Down Counter
6. Interrupt Generation Logic
7. Reset Generation Logic

## Working Principle
1. The processor configures the watchdog through APB registers.
2. A timeout value is loaded into the watchdog counter.
3. The counter continuously decrements with every clock cycle.
4. The processor periodically refreshes the watchdog.
5. If refresh is not received before timeout:
   - WDOGINT is generated.
6. If the watchdog remains unrefreshed:
   - WDOGRES is generated.
7. The system recovers through reset operation.

## Verification Environment
A layered SystemVerilog verification environment is developed to validate watchdog functionality.

### Verification Components

- Interface
- Transaction Class
- Generator
- Driver
- Monitor
- Reference Model
- Scoreboard
- Environment
- Test

## Test Scenarios
The following test cases were verified:
- APB Register Write Operations
- APB Register Read Operations
- Watchdog Refresh Operation
- Counter Decrement Verification
- Timeout Detection
- Interrupt Generation
- Reset Generation
- Boundary Condition Testing

## Results

Simulation results confirmed:
- Correct APB Communication
- Successful Timeout Detection
- Proper Counter Operation
- Correct Refresh Functionality
- Interrupt Generation (WDOGINT)
- Reset Generation (WDOGRES)
- Reliable Fault Monitoring Behavior

The waveform analysis verified that the watchdog operates according to the expected two-stage timeout mechanism.

## Simulation

EDA Playground Link:

https://www.edaplayground.com/x/V_nJ

## Applications

- Embedded Systems
- System-on-Chip (SoC) Designs
- Automotive Electronics
- Industrial Automation
- Safety-Critical Systems
- IoT Devices

## Future Enhancements

- Window Watchdog Support
- FPGA Implementation
- UVM-Based Verification
- Programmable Clock Divider
- Advanced Fault Detection Mechanisms

## Tools Used

- SystemVerilog
- RTL Design
- Functional Verification
- AMBA APB Protocol
- EDA Playground

## Author

**V M Swathika**  
 GitHub: https://github.com/swathika0401

## Project Status

✅ RTL Design Completed  
✅ APB Interface Implemented  
✅ Verification Environment Developed  
✅ Simulation Completed  
✅ Waveform Analysis Completed  
✅ Documentation and IEEE Paper Prepared
