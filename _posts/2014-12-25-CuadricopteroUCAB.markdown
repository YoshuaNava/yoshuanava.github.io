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
title: "<em>CuadricopteroUCAB</em>"
description: "Low-cost quadrotor platform developed as the undergraduate thesis project of me and Luis Vicens, another student at UCAB."
p_languages: "Arduino/Processing, Python, MATLAB"
---

<h2> Overview </h2>
<p style='text-align: justify;'>
For my undergraduate thesis I worked with <a href="https://www.linkedin.com/profile/view?id=136247154">Luis Vicens</a>, another student 
at UCAB, on the development of the electronics, state estimation, wireless communication, ROS-based ground station, and a PID control 
algorithm to stabilize and control a low-cost quadrotor platform.
</p>

<p style='text-align: justify;'>
The main premise behind our project was to continue previous developments of low-cost quadrotor platforms feasible to be built with 
components available in our country, Venezuela (like DC motors, low cost Arduino boards, and common-use electronic components). As sensors we
used a 9DoF-IMU to measure the quadrotor attitude and an ultrasonic sensor to measure its altitude. We also used XBEE modules to communicate with 
the quadrotor remotely, and two LiPo batteries: one to feed the motors (~16A consumption at maximum throttle), and the other one to 
feed the Arduino, sensors and the quadrotor XBEE module.
</p>

<br>

<em>The quadrotor:</em>

[![The quadrotor](/projects_images/thumb.CuadricopteroUCABfront.jpg)](/projects_images/CuadricopteroUCABfront.jpg)




<hr>
<h2> Electronics </h2>

The quadrotor electronics design was split in two parts:

<p style='text-align: justify;'>
<b>1)</b> Building a simple PCB to integrate the Arduino, sensors and XBEE module in a single board.
</p>

<br>

<em>Logic, sensors and communication circuit:</em>

[![Logic, sensors and communication circuit](/projects_images/thumb.CuadricopteroUCAB-LogicSensorsComCircuit.jpg)](/projects_images/CuadricopteroUCAB-LogicSensorsComCircuit.jpg)

<br>

<p style='text-align: justify;'>
<b>2)</b> Developing a circuit to control the DC motors speed with the Arduino PWM. 
The circuit designed made use of opto-couplers to completely isolate the logics/control circuit from the electrical interference that could be 
caused by the fast switching of the DC motors speed. An exhaustive characterization of the response of the opto-couplers and the best-available 
N-channel MOSFETs was made. 
</p>

<br>

<em>Motor control circuit PWM signals response:</em>

[![Motor control circuit PWM signals response](/projects_images/thumb.CuadricopteroUCAB-PWMsignals.png)](/projects_images/CuadricopteroUCAB-PWMsignals.png)


<br>

<em>MOSFETs current flow as a function of Vgs:</em>

[![MOSFETs current flow as a function of Vgs](/projects_images/thumb.CuadricopteroUCAB-MOSFETsCurrentFlow.png)](/projects_images/CuadricopteroUCAB-MOSFETsCurrentFlow.png)


<br>

<p style='text-align: justify;'>
The final circuit was designed taking into account the 3-cell LiPo batteries voltage so that the MOSFETs Gate voltage could be kept in an optimal range to ensure
maximum conductivity through the MOSFETs and maximum power consumption by the motors.
</p>


<br>

<em>Motor control circuit design:</em>

[![Motor control circuit design](/projects_images/thumb.CuadricopteroUCAB-CircuitDesign.png)](/projects_images/CuadricopteroUCAB-CircuitDesign.png)







<hr>
<h2> Quadrotor state estimation </h2>

The state estimation of the quadrotor was divided into:

<p style='text-align: justify;'>
<b>1) Angular rate and angular position estimation (attitude and attitude rate): </b>

To estimate the angular rate we used simple gyroscope readings, and to estimate the quadrotor attitude we followed the Complementary Filter 
approach to fuse accelerometer and gyroscope readings. But, with the motors on, the gyroscope, and specially, the accelerometer experienced 
low-frequency mechanical vibrations that rendered its readings almost useless for state estimation and real-time control.
</p>

<br>

<em>Accelerometer subject to mechanical vibrations:</em>

[![Accelerometer subject to mechanical vibrations](/projects_images/thumb.CuadricopteroUCAB-accVibrations.png)](/projects_images/CuadricopteroUCAB-accVibrations.png)

<br>

<p style='text-align: justify;'>
As mechanical vibrations are oscillatory phenomena, with almost constant mean and standard deviation values, and knowing that the value 
of the z axis reading  of the accelerometer should be equal to 1G (transmitted as 254) when the quadrotor is resting on a flat surface, 
a moving average filter was implemented as a proof of concept. The moving average filter essentialy let us obtain a cleaner signal, with 
Z values approaching 254 (~1G), but the effective frequency spectrum of the signal was too low to be used for real-time control of the 
quadrotor.
</p>

<br>

<em>Accelerometer signal after heavy (40-values window) moving-average filtering:</em>

[![Accelerometer signal after heavy (40-values window) moving-average filtering](/projects_images/thumb.CuadricopteroUCAB-accHeavyAvgFiltering.png)](/projects_images/CuadricopteroUCAB-accHeavyAvgFiltering.png)

<br>

<p style='text-align: justify;'>
Nonetheless, the moving average filter was used to reduce the effect of the mechanical vibrations on the gyroscope and improve
the angular rate estimation, together with an algorithm to compensate for the standard deviation in its readings introduced by the
fluctuation in the battery voltage.
</p>


------------gyro estimation image!!!!


<br>

<p style='text-align: justify;'>
<b>2) Altitude and altitude rate estimation: </b>
calculating an estimation of the distance to the floor, and its numerical derivative to approximate altitude rate, 
both based on the ultrasonic sensor readings, and under the assumption that the attitude angles would be close to zero at any moment. A kalman filter was implemented
to deal with minor sensor instability issues when the quadrotor was slightly tilted.
</p>

------------altitude estimation image!!!!

------------altitude rate estimation image!!!!

<br>

<p style='text-align: justify;'>
<b>Note:</b> Gyroscope and magnetometer sensor fusion (to improve yaw angle measurement), and adjustment of the altitude calculation based on 
the quadrotor attitude were not implemented because of their high dependency with the quadrotor's attitude measurements, which had a high 
level of uncertainty because of mechanical vibrations.
</p>

<br>

<hr>
<h2> Wireless communication protocol for telemetry and remote command </h2>
<p style='text-align: justify;'>
The <b>communication protocol</b> developed was based on the protocol used by Shane Colton used on its <a href="http://www.instructables.com/id/PCB-Quadrotor-Brushless/">PCB Brushless Quadrotor</a>.
Every package was either scaled or divided in many char-size packages (8 bits). A simple XOR function was used to calculate each message
checksum for error verification. Tests were performed to measure the transmission rate of the protocol, and the communication delay produced
by each message was calculated for transmission frequencies of 38400bdps and 115200 (57600bdps frequency was discarded because of a <a href="http://scolton.blogspot.com/2011/09/great-xbee-576kbps-mystery-finally.html">transmission 
bug in the XBEE Series 1 modules</a>)
</p>

<br>

<em>Wireless communication transmission rate:</em>

[![Wireless communication transmission rate](/projects_images/thumb.CuadricopteroUCAB-TransmissionRate.png)](/projects_images/CuadricopteroUCAB-TransmissionRate.png)

<br>


<hr>
<h2> ROS-based ground station </h2>
<p style='text-align: justify;'>
The ROS based ground station was composed of:

* A serial communication node, that manages the serial communication with the PC XBEE module, publishes telemetry messages and subscribes to 
users commands messages.

* A node to detect movement commands made with the Logitech Gamepad II controller.

* Two nodes to write the telemetry messages received into CSV files for future analysis.
</p>

<hr>
<h2> Control systems </h2>
<h3> Dynamical model </h3>
<p style='text-align: justify;'>
We based our work on the  dynamic, kinematic, and motor-response linear model of the Draganflyer V quadrotor developed in <a href="http://acikarsiv.atilim.edu.tr/browse/156/168.pdf">[Kivrak 2006]</a> 
(As students of Informatics Engineering we didn't have the knowledge to model the dynamics and kinematics of the quadrotor at the time 
we developed the project). The inertia parameters were calculated based on our quadrotor setup to adapt the dynamic model to our needs.
</p>

<br>

<h3> Simulation </h3>
<p style='text-align: justify;'>
We simulated the control systems in MATLAB based on the linearization around the hovering point of the Draganflyer V dynamical model. The PID controllers were designed to stabilize the quadrotor attitude and altitude around the horizontal hovering point and respond to remote 
non-aerobatic simple movement commands sent by the user. During the control systems simulations, performed with the Euler method, and based on the linearized system we obtained succesful (Tracking and
robustness) yet slow-convergence results, mainly due to the inertia of the quadrotor, which we unadvertedly increased by adding too much weight to it.
</p>

<br>

<em>Control systems simulation:</em>

[![Control systems simulation](/projects_images/thumb.CuadricopteroUCAB-PIDfullSimulation.png)](/projects_images/CuadricopteroUCAB-PIDfullSimulation.png)


<br>

<h3> Implementation</h3>
<p style='text-align: justify;'>
The PID algorithms designed were implemented and tested on the quadrotor platform. The Pitch and Roll angular position PIDs offered an irregular
performance due to the low-frequency vibrations on the Pitch and Roll axis. Moreover, the Arduino timers experimented resource contention because
of a design error on the control/logic PCB which rendered useless the ultrasonic sensor during flight.
</p>

<br>

First, tests were performed with angular rate control only:

<br>


<em>Quadrotor with angular rate control only:</em>

[![Alt text for your video](http://img.youtube.com/vi/rEZYg2zQfjA/0.jpg)](http://www.youtube.com/watch?v=rEZYg2zQfjA)

<b>(YouTube video. Click on the image to be redirected to YouTube)</b>


<br>

Finally, angular position on the Yaw axis was added:

<br>

<em>Pitch rate control system:</em>

[![Pitch rate control system](/projects_images/thumb.CuadricopteroUCAB-vPitchPID.png)](/projects_images/CuadricopteroUCAB-vPitchPID.png)

<br>


<em>Roll rate control system:</em>

[![Roll rate control system](/projects_images/thumb.CuadricopteroUCAB-vRollPID.png)](/projects_images/CuadricopteroUCAB-vRollPID.png)

<br>


<em>Yaw rate control system:</em>

[![Yaw rate control system](/projects_images/thumb.CuadricopteroUCAB-vYawPID.png)](/projects_images/CuadricopteroUCAB-vYawPID.png)

<br>


(((-----------------quadrotor with angp yaw control}}}}}}}




<hr>
<h2> General System diagram (in Spanish) </h2>

[![](/projects_images/thumb.CuadricopteroUCAB-SystemDiagram.png)](/projects_images/CuadricopteroUCAB-SystemDiagram.png)



<hr>


<b>All the code, schematics and documentation were released under the MIT license so that other people can freely work with it, and improve it. You can find all the files in <a href="https://github.com/YoshuaNava/TesisCuadricoptero">this GitHub repository</a> (It's in spanish) </b>
