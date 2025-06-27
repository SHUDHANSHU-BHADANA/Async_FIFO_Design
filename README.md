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

## 🧪 Simulation
![Screenshot 2025-06-28 000443](https://github.com/user-attachments/assets/e43171d7-a549-4525-99ab-7934b4df9fde)
![Screenshot 2025-06-28 000152](https://github.com/user-attachments/assets/1e3a89a6-8545-4806-8dfd-593f9daef7f2)
![Screenshot 2025-06-27 230433](https://github.com/user-attachments/assets/3df45475-3f4c-4287-ad93-246e03713d86)


📚 License
This project is open-source and free to use for academic and commercial purposes under the MIT License.
