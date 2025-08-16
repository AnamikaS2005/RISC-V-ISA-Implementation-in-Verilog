# RISC-V Processor Design in Verilog

## 📖 Overview
This project implements a **RISC-V processor** in Verilog with instruction-level simulation.  
The design supports **R, I, S, B, and J-type instructions** from the base RISC-V ISA and includes a  
basic **fetch–decode–execute pipeline** along with **hazard identification and handling mechanisms**.

The project was built as part of my learning in digital design, RTL simulation, and processor verification.

## ⚙️ Features
- **Instruction Support**: R, I, S, B, J type instructions
- **Processor Stages**: Instruction **Fetch → Decode → Execute**
- **Hazard Handling**:
  - Identifies data hazards
  - Implements simple stalling and forwarding techniques
- **RTL Modules**:
  - Register File
  - ALU
  - Branch Control Logic
  - Hazard Detection Unit
- Verification using **Verilog testbenches** and **waveform inspection** in ModelSim/Vivado

## 🛠️ Tools & Languages
- Verilog HDL  
- ModelSim / Vivado (simulation + waveform analysis)

## 📂 Repository Structure
