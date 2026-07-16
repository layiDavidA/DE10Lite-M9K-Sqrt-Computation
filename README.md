# Sequential System Design With RAM  

State Diagram  
<img width="629" height="418" alt="Screenshot 2026-07-15 at 9 59 16 PM" src="https://github.com/user-attachments/assets/14b706e6-e2f5-4443-ab1a-389d332ffb54" />


Part I: RAM  
Part one of this lab focused on designing and implementing two 16x4 RAM modules using DE-LITE10 M9K Memory blocks. The code for a singular 16x4 RAM module was given in the lab document and later used to instantiate two 16x4 blocks. In the singular RAM code, [ /* synthesis ramstyle = "M9K" */ ]; this line made it so Quartus correctly used M9K blocks instead of using standard flip-flops. 

The design specifications for implementing two 16x4 RAM modules included only writing into one RAM module (RAM1 or RAM0) at a time, SW[8] determined which memory module will be written, a write operation will occur to the selected RAM module on a positive Clock transition when the Write Enable signal is active, Both RAM modules can be read to their respective 7-segment displays simultaneously, and the RAM output data must be clocked (synchronous) for Quartus to use M9K blocks.

In the design, SW[3:0] provides the 4-bit input data (Data_In), and SW[7:4] specifies the 4-bit memory address. KEY[0] acted as the system clock, while write enable (WE) is controlled by SW[9] and targeted to either RAM1 or RAM0 using the module select switch SW[8]. The current address is displayed on HEX3, the input data on HEX2, and the data outputs of RAM1 and RAM0 on HEX1 and HEX0, respectively.

To create two 16x4 RAM modules, two RAMs were instantiated to create RAM0 and RAM1. The RAMs had the same clock, address, and mdi, but had different Write enables and mdo. The write enable for the RAMs was respectively defined as mwr0 and mrw1. When SW[8] was high, that meant to write to RAM1, and when SW[8] was low, that meant to write to RAM0. The memory write enable for RAM0 was set high when (WE & !SW[8]). The memory write enable for RAM1 was set high when (WE & SW[8]). 

To test this design, a mif file was used to upload preset values to addresses in RAM0 and RAM1. The design was verified and had correct functionality for RAM0 and RAM1.  
  
<img width="448" height="118" alt="Screenshot 2026-07-15 at 10 00 11 PM" src="https://github.com/user-attachments/assets/3ae82399-42dd-478d-9a15-708eb95abe45" />  

The design used 2 M9K blocks as expected.



Part II: Integer Square Root Computation  

Part two of this lab focused on designing and implementing a circuit that can do square root computation. The design took in an 8-bit binary number (N) and used a custom memory, datapath, and FSM to compute square roots. Since division and multiplication are very complicated, the square root computation was done by the method of subtracting consecutive odd integers. The design had 4 main components, which included the register of N, the subtractor, the adder, and the FSM.  

[[subtracting consecutive odd integers EXAMPLE] sqrt27=6 ]  
<img width="622" height="40" alt="Screenshot 2026-07-15 at 10 00 53 PM" src="https://github.com/user-attachments/assets/96ed4195-a856-400a-a32e-8e70e470c380" />  



The N-block register was updated every positive clock edge. If the load signal was high (Load=1) it would load the initial value (N) into the register. If Su=1, it would load the subtracter output into the register.

The subtracter would simply subtract the number inside the register by the consecutive odd integers that were being updated from our Adder. Using concatenation, the subtracter would set a Borrow signal high to indicate overflow and let the design know that computation is done. 

The adder was updated every positive clock edge. The adder outputted a variable named IncAdder that held the values of the consecutive odd numbers that were subtracted from the N-block register. At the very beginning of the square root computation, IncAdder=1, and as long as the circuit was computing, then IncAdder would increment by two every iteration of subtraction, allowing the square root to be found via the method of subtracting consecutive odd integers. The final square root output is assigned to the variable SqrtV as the 3 most significant bits because of the mathematical property embedded within the odd-integer subtraction algorithm. 

The FSM was created using three states (S0, S1, and S2). In the starting state S0, the circuit would wait for a Start signal (St). If St=0, all outputs were 0. If St=1, the FSM would set a Load=1 and go to the second state (S1). In S1, if Borrow=0, then the circuit would stay in S1 and the design would set Su=1 and Inc=1; essentially, these two signals would allow the design to continuously do subtraction until the square root is found. As soon as Borrow=1, this tells us that computation is done, the design sets Su=0 and Inc=0, and the design goes to the third state (S2). In S2, the design sets our Done signal to 1 and outputs the square root result. In S2, as long as the St=1, the design will stay in S2, but when St=0, the FSM will reset IncAdder to 1 and go back to S0, and is ready to compute a new square root.

In a top-level file, the N-register, subtractor, adder, and FSM were connected together via wires and tested using the lab-provided testbench. The circuit’s outputs were observed via waveform and terminal, and it was verified that all outputs were correct and the design was functional.  
<img width="627" height="352" alt="Screenshot 2026-07-15 at 10 01 19 PM" src="https://github.com/user-attachments/assets/3366197f-bb6f-4859-8db0-5a837f01b6ac" />



To finish this design, the RAM module in Part I was changed from 16x4 to 16x8 and used with an MIF file to store test cases for our design. In another top level file, the Start signal (St) was connected to KEY[1], the Reset was connected to KEY[0], the Done signal was connected to LEDR[0], the input value (N) was connected to HEX 2 and HEX 1, the address value was connected to HEX5, and the final square root output was connected to HEX 0. The RAM’s output was wired to the square root’s input value. The RAM is incremented using the St and is connected to the Square root via the DE10-LITE clock.  
<img width="362" height="280" alt="Screenshot 2026-07-15 at 10 01 36 PM" src="https://github.com/user-attachments/assets/75f4a356-f9e8-4847-8cca-380bf4215b92" />  





PART II: Resource Utilization Report  
<img width="571" height="320" alt="Screenshot 2026-07-15 at 10 01 54 PM" src="https://github.com/user-attachments/assets/f5762986-7914-428a-a60e-7b69e63453ae" />  


In this design, 70 Total logic elements and 19 flip-flops were used.
Challenges/Conclusion
In this lab, the hardest part was writing, creating the data path, and implementing it with code. In this lab, we showed a sequential design on the DE10-Lite FPGA by implementing both behavioral memory modules and an efficient computation circuit. In Part I, the correct configuration and synthesis of dual 16x4 RAM modules verified the effective utilization and initialization of the FPGA's dedicated M9K memory blocks. Finally, the integration of these memory components with the custom datapath and Finite State Machine in Part II validated the hardware's capability to accurately compute and display integer square roots via consecutive odd-integer subtraction.

