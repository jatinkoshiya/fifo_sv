1010 Sequence Detection
The goal is to detect the binary sequence 1010 in a stream of bits. There are two styles of detection:

1. Non-Overlapping Detection
States: A → B → C → D
Transitions:
A: Wait for 1 → B
B: Wait for 0 → C
C: Wait for 1 → D
D: Wait for 0 → Output 1 and reset to A
Output: Only after full sequence 1010 is detected, and it resets to A to avoid overlap.
