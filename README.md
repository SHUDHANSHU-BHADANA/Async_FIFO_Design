# Asynchronous FIFO (First-In-First-Out) in Verilog

This project implements an **asynchronous FIFO** that allows safe data transfer between two different clock domains (write and read clocks). The FIFO uses Gray code for pointer synchronization and includes all essential modules such as memory, synchronizers, full/empty detectors, and a testbench.

---

## 🧠 Key Concepts

- ✅ Dual Clock Domain Support (Asynchronous FIFO)
- ✅ Two-Flip-Flop Synchronizers to prevent metastabiltiy
- ✅ Binary ↔ Gray Code Conversion to reduce data incoherency
- ✅ Pointer-based Full/Empty Detection
- ✅ Parameterized Design (Data Width, Address Width reconfigurable)

---

## 🔧 Modules Description

| File              | Description                                                   |
|-------------------|---------------------------------------------------------------|
| `fifodesign.v`     | Top-level module connecting all submodules                   |
| `fifomem.v`        | Memory to store FIFO data                                    |
| `wptr_and_full.v`  | Maintains write pointer and detects full condition           |
| `rptr_and_empty.v` | Maintains read pointer and detects empty condition           |
| `binary2gray.v`    | Converts binary to Gray code                                 |
| `gray2binary.v`    | Converts Gray code to binary                                 |
| `twoflopsync.v`    | Synchronizes pointer across clock domains                    |
| `tb.v`             | Testbench to verify FIFO functionality                       |

---

## 📐 Parameters

- `datawidth`: Width of each data word (default: 8 bits)
- `addr_width`: Width of FIFO address pointer (default: 3 bits = 8-depth FIFO)

- 
## Block diagram
<img width="1280" height="805" alt="image" src="https://github.com/user-attachments/assets/7954ba26-adc0-4fe9-aadb-ce299fbfacf4" />

## Schematic
<img width="1496" height="307" alt="image" src="https://github.com/user-attachments/assets/e46bf303-689e-480b-bfd7-8ab084bd92eb" />

## Simulation
<img width="1479" height="633" alt="image" src="https://github.com/user-attachments/assets/56018b8a-6b3a-4b8e-abd8-e09da9666eb1" />





📚 License:
This project is open-source and free to use for academic and commercial purposes under the MIT License.
