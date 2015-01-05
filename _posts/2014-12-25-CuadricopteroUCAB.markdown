---
layout: post
modal-id: 1
date: 2014-12-25
img: TesisCuadricoptero.png
alt: image-alt
project-date: January 2015
category: robotics
type: project
comments: true
title: "Cuadricoptero UCAB"
description: "Low-cost quadrotor platform developed as the undergraduate thesis project of me and Luis Vicens, another student at UCAB."
p_languages: "Arduino/Processing, Python, MATLAB"
---

For my (Bachellor) thesis I worked on the development of the electronics, state estimation, wireless communication, ROS-based ground 
station, and a PID control algorithm to stabilize and control a low-cost quadrotor platform. The main premise behind our project was
that the quadrotor platform could be built with components available in our country, Venezuela, like DC motors, low cost Arduino boards,
and common-use electronic components. We used a 9DoF-IMU to measure the quadrotor attitude, an ultrasonic sensor to measure its altitude,
XBEE modules to communicate with the quadrotor remotely, and two LiPo batteries: one to feed the motors (~16A consumption at their maximum 
throttle), and the other one to feed the Arduino, sensors and the quadrotor XBEE module.

The <b>communication protocol</b> developed was based on the protocol used by Shane Colton used on its <a href="http://www.instructables.com/id/PCB-Quadrotor-Brushless/">PCB Brushless Quadrotor</a>.
Every package was either scaled or divided in many char-size packages (8 bits). A simple XOR function was used to calculate each message
checksum for error verification. Tests were performed to measure the transmission rate of the protocol, and the communication delay produced
by each message was calculated for transmission frequencies of 38400bdps and 115200 (57600bdps frequency was discarded because of a <a href="http://scolton.blogspot.com/2011/09/great-xbee-576kbps-mystery-finally.html">transmission 
bug in the XBEE Series 1 modules</a>)

The ROS based ground station was composed of:
* A serial communication node, that manages the serial communication with the PC XBEE module, publishes telemetry messages and subscribes to 
users commands messages.
* A node to detect movement commands made with the Logitech Gamepad II controller.
* Two nodes to write the telemetry messages received into CSV files for future analysis.

The state estimation of the quadrotor was divided into:
* Angular rate: required re-scaling and filtering the gyroscope output.
* Angular position estimation (attitude): based on the Complementary Filter approach to fuse accelerometer and gyroscope readings.
* Altitude and altitude rate estimation: calculating distance to the floor and discrete derivative to approximate altitude rate, both based
on the ultrasonic sensor readings, and under the assumption that the attitude angles would be close to zero at any moment.
Use of the magnetometer to improve yaw angle measurement, and adjustment of the altitude calculation based on the quadrotor attitude were
discarded because of their dependency with the quadrotor's attitude measurements, which had a high level of uncertainty because of
mechanical vibrations.

The quadrotor electronics design was split in two parts:
* Building a simple PCB to integrate the Arduino, sensors and XBEE module in a single board.
* Developing a circuit to control the DC motors speed with the Arduino PWM. The circuit designed made use of opto-couplers to completely
isolate the logics/control circuit from the electrical interference that could be caused by the fast switching of the DC motors speed.
An exhaustive characterization of the response of the opto-couplers and the best-available N-channel MOSFETs was made, the final circuit was
designed taking into account the 3-cell LiPo batteries voltage so that the MOSFETs Gate voltage could be kept in an optimal range to ensure
maximum conductivity through the MOSFETs and maximum power consumption by the motors.

(((-----------------graficas de caracterizacion de los mosfets}}}}}}}


The PID controllers were designed to stabilize the quadrotor attitude and altitude around the horizontal hovering point and respond to remote 
non-aerobatic simple movement commands sent by the user. We simulated the control systems in MATLAB based on the linearization around the
hovering point of the Draganflyer V dynamic, kinematic, and motor response linear model developed in <a href="http://acikarsiv.atilim.edu.tr/browse/156/168.pdf">[Kivrak 2006]</a> 
(As students of Informatics Engineering we didn't have the knowledge to model the dynamics and kinematics of the quadrotor at the time 
we developed the project). The inertia parameters were calculated based on our quadrotor setup to adapt the dynamic model to our needs.

During the control systems simulations, performed with the Euler method, and based on the linearized system we obtained succesful (Tracking and
robustness) yet slow-convergence results, mainly due to the inertia of the quadrotor, which we unadvertedly increased by adding too much weight to it.

(((-----------------control systems simulation}}}}}}}

The PID algorithms designed were implemented and tested on the quadrotor platform. The Pitch and Roll angular position PIDs offered an irregular
performance due to the low-frequency vibrations on the Pitch and Roll axis. Moreover, the Arduino timers experimented resource contention because
of a design error on the control/logic PCB which rendered useless the ultrasonic sensor during flight.
Tests were performed with angular rate control only:


[![Alt text for your video](http://img.youtube.com/vi/rEZYg2zQfjA/0.jpg)](http://www.youtube.com/watch?v=rEZYg2zQfjA)

Finally, angular position on the Yaw axis was added:

(((-----------------quadrotor with angp yaw control}}}}}}}

During the development of this project, signal filtering was a major issue. Low-pass, high-pass, kalman and moving average filters were implemented,
being the moving average filters the ones that were more effective in filtering low-frequency vibrations. Just for a proof of concept the same
type of filters were implemented for the accelerometer. Below lies some images that describe that results obtained:


(((-----------------gyro signal-original and filtered}}}}}}}

(((-----------------accelerometer signal-original and filtered}}}}}}}






<b>All the code, schematics and documentation were released under the MIT license so that other people can work with it, and improve it. You can find all the files in <a href="https://github.com/YoshuaNava/TesisCuadricoptero">this GitHub repository</a> (It's in spanish) </b>
