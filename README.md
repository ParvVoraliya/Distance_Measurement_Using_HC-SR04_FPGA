# FPGA Distance Measurement using HC-SR04 (Verilog)

## Overview
This project implements a **distance measurement system using the HC-SR04 ultrasonic sensor interfaced with an FPGA**. The design is written in **Verilog HDL** and measures the distance of an object by calculating the time taken for an ultrasonic wave to travel to the object and return.

## Working Principle
1. The FPGA generates a **10 µs trigger pulse** for the HC-SR04 sensor.
2. The sensor emits ultrasonic waves toward the object.
3. The waves reflect from the object and return to the sensor.
4. The **Echo pin stays HIGH for the round-trip travel time**.
5. The FPGA measures this pulse width using a clock-based counter.
6. The measured time is used to estimate the distance.

Distance is calculated using:

Distance = (Time × Speed of Sound) / 2

## Features
- Implemented using **Verilog HDL**
- **Trigger pulse generation** for HC-SR04
- **Echo signal measurement**
- **Clock cycle counting for time calculation**
- Suitable for **FPGA-based sensor interfacing projects**

## Hardware Requirements
- FPGA development board
- HC-SR04 Ultrasonic Sensor
- Jumper wires
- Power supply

## Applications
- Obstacle detection
- Robotics navigation
- Smart parking systems
- Distance measurement systems
