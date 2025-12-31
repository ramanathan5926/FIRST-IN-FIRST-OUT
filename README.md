# 🔁 Synchronous FIFO Design using Verilog

## 📌 Project Overview
This project implements a **Synchronous FIFO (First-In First-Out)** buffer using **Verilog HDL**.  
The FIFO is designed using **read and write pointers** along with a **counter-based status logic** and is fully verified through simulation.

---

## ⚙️ Features
- Synchronous FIFO (single clock domain)
- Data width: 8 bits
- Depth: 64 entries
- Separate read and write pointers
- Counter-based Full and Empty detection
- Supports simultaneous read and write
- Fully synthesizable RTL design

---

## 🔁 FIFO Architecture
- **Memory Array** stores FIFO data
- **Write Pointer** points to next write location
- **Read Pointer** points to next read location
- **Counter** tracks number of stored elements

---

## 🔌 Inputs & Outputs

### Inputs
- `clk` – System clock  
- `rst` – Asynchronous reset  
- `wr_en` – Write enable  
- `rd_en` – Read enable  
- `buf_in[7:0]` – Data input  

### Outputs
- `buf_out[7:0]` – Data output  
- `buf_empty` – FIFO empty flag  
- `buf_full` – FIFO full flag  
- `fifo_counter[6:0]` – Number of stored elements  

---

## 🧪 Verification
A Verilog testbench was developed to:
- Apply reset
- Write multiple data values into FIFO
- Read data back in FIFO order
- Verify empty and full conditions
- Validate simultaneous read and write operations

The design was verified using **GTKWave waveform analysis**, confirming correct FIFO behavior.

---

## 🛠 Tools Used
- Verilog HDL  
- Icarus Verilog  
- GTKWave  
- VS Code  

