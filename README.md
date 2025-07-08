# Dynamic Serial Accumulator using ROM-Based Input Control on FPGA

## 📌 Project Overview

This project implements a **Dynamic Serial Accumulator** on a **Spartan-7 FPGA** using **Verilog HDL**. The accumulator performs serial addition of binary inputs stored in a pre-initialized ROM (Read-Only Memory), controlled by a user-interactive **Finite State Machine (FSM)** through push buttons. The final result is displayed on output LEDs.

## 🎯 Key Features

- 💡 **Serial Accumulation** – Bit-by-bit addition using a 1-bit full adder
- 📦 **ROM-Based Inputs** – Inputs loaded from a `.coe` initialized ROM (Vivado IP)
- 🎮 **FSM Control** – State machine handles IDLE, LOAD, ADD, READY, and DONE transitions
- 🖥️ **FPGA Platform** – Implemented on Boolean Board (Spartan-7 XC7S50)
- 🔁 **Modular Design** – Clock divider, accumulator, ROM, FSM, adder modules

## 🧩 Module Overview

| Module         | Description |
|----------------|-------------|
| `top_module.v` | Top-level module connecting all submodules |
| `clock_divider.v` | Generates a slow clock from system clock |
| `controller_fsm.v` | FSM that manages system flow using buttons |
| `accumulator.v` | Performs serial addition of current ROM input and accumulated sum |
| `adder.v` | 1-bit full adder (`assign {cout, sum} = a + b + cin`) |
| `input_rom.v` | ROM module created using Vivado Block Memory Generator IP |

## 📁 File Structure

```
├── src/
│   ├── top_module.v
│   ├── clock_divider.v
│   ├── controller_fsm.v
│   ├── accumulator.v
│   ├── adder.v
│   └── input_rom.v
├── input_data.coe          # ROM initialization data
├── constraints.xdc         # Pin mapping for Boolean Board
├── README.md
└── report/                 # Optional: Internship report and documentation
```

## 🚦 User Controls

| Button      | Function                      |
|-------------|-------------------------------|
| `load_btn`  | Loads next input from ROM     |
| `stop_btn`  | Terminates accumulation       |
| `reset`     | Resets FSM and accumulator    |

## 🔍 Output

- **sum_out[7:0]** → Displayed on 8 on-board LEDs
- **ready_led** → Indicates ready for next input
- **done_led** → Indicates accumulation completed

## 🛠️ Tools & Environment

- **Vivado Version:** 2024.1
- **HDL:** Verilog
- **FPGA:** Spartan-7 (XC7S50), Boolean Board
- **Simulation:** Vivado XSIM

## 📊 Sample ROM Input

```coe
memory_initialization_radix=2;
memory_initialization_vector=
00000101,
00100100,
00010110,
00001111,
00010011,
00010110,
00010000,
00001000,
00001010,
00000111;
```

## 🧠 Future Enhancements

- Add signed accumulation (2’s complement support)
- Extend to UART/ADC-based live inputs
- Display result on 7-segment or LCD
- Add UART logging or HDMI output

## 👨‍🏫 Guide

**Dr. Puli Kishore Kumar**  
Assistant Professor, Department of ECE  
NIT Andhra Pradesh (NIT-AP)

## 👤 Intern

**Ryali Sai Syam Naga Santhosh**  
B.Tech ECE, Vishnu Institute of Technology, Bhimavaram  
Summer Intern @ NIT Andhra Pradesh (May–June 2025)
