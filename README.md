FPGA Distance Measurement using HC-SR04 (Verilog)
Description

This project implements a distance measurement system on an FPGA using the HC-SR04 ultrasonic sensor, written in Verilog HDL. The design generates the required 10 µs trigger pulse, captures the echo signal, and measures its pulse width using a counter driven by the FPGA clock.

The echo pulse width corresponds to the time taken by the ultrasonic wave to travel to the object and return. Using this measured time, the system calculates the distance between the sensor and the object.

The project demonstrates sensor interfacing, precise timing measurement, and digital design using Verilog on FPGA.

Key Features

Verilog-based FPGA implementation

Trigger pulse generation for HC-SR04

Echo signal detection

Clock-based timing counter for distance calculation

Real-time distance measurement

Working Principle

FPGA sends a 10 µs trigger pulse to the sensor.

HC-SR04 emits ultrasonic waves.

Waves reflect from the object and return.

Echo pin remains HIGH for the round-trip travel time.

FPGA measures this time using a counter and computes the distance.

Distance is calculated using:

𝐷
𝑖
𝑠
𝑡
𝑎
𝑛
𝑐
𝑒
=
𝑇
𝑖
𝑚
𝑒
×
𝑆
𝑝
𝑒
𝑒
𝑑
 
𝑜
𝑓
 
𝑆
𝑜
𝑢
𝑛
𝑑
2
Distance=
2
Time×Speed of Sound
	​
