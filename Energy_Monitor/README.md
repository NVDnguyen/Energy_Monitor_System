# Energy Monitoring System

## Introduction
This project develops a smart energy monitoring system using either ESP8266 , connecting to Firebase to store and analyze consumed energy data. This system measures voltage, current, power, and frequency, and it is capable of alerting when power consumption exceeds predetermined thresholds.

## Key Components
- `get_power.h`: Defines functions to read values from energy sensors.
- `sim.h`: Defines functions for communication with the A7680C module, including sending SMS and making calls.
- `config.h`: Contains configuration definitions for the project, including network parameters and Firebase.

## Functionality
- Read and process energy parameters from sensors.
- Send data to Firebase Realtime Database for storage and analysis.
- Alert users via SMS when detected energy consumption exceeds the set thresholds.
- Automatically reset energy information or network connection through hardware buttons.

## Detailed Parameters

The system is designed to measure and monitor key energy parameters including:

- **Voltage (Volt):** Measuring range from 0V to 250V with an accuracy of ±1%.
- **Current (Ampere):** Measuring range from 0A to 100A, suitable for most residential and light industrial applications.
- **Power (Watt):** Power consumption calculated from voltage and current, providing data on instantaneous energy use.
- **Frequency (Hertz):** Measures the frequency of the power supply, typically 50Hz or 60Hz depending on the local electrical system.
- **Power Factor (PF):** Measures the power factor to analyze the efficiency of energy use.

### Alert Limits and Control
The system also includes alert and automatic control functions when parameters exceed preset thresholds:

- **Maximum Power Limit (Watt max):** The power alert threshold is set at 50W. When power consumption exceeds this limit, the system automatically sends an alert via SMS and can turn off devices to prevent overload.
- **Automatic Control:** In case of continuous power consumption exceeding allowed thresholds, the system is capable of automatically disconnecting to ensure safety.

## Installation and Usage
1. **Library Installation:** Ensure that necessary libraries for ESP8266, Firebase, and A7680C are installed in your Arduino development environment.
2. **Network and Firebase Configuration:** Update the parameters in `config.h` to match your WiFi network and Firebase information.
3. **Hardware Setup:** Connect the sensors and A7680C module to the ESP8266 according to the connection diagram.
4. **Upload and Run the Program:** Upload the program to the ESP8266 and monitor the operation through the Serial Monitor.

