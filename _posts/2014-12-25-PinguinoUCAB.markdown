---
layout: post
modal-id: 1
date: 2015-01-10
img: PinguinoUCAB.png
alt: image-alt
project-date: January 2015
category: embeddedsystems
type: project
comments: true
title: "<em>PinguinoUCAB</em>"
description: "Undergraduate communitary service: implementation of a small set of Pinguino control boards and sensor modules."
p_languages: "Pinguino C"
---
<h2> Overview </h2>
<p style='text-align: justify;'>
During my undergraduate studies, I worked with Jonathan Teixeira, another student at UCAB, and the 
<a href="http://w2.ucab.edu.ve/re_presentacion.html">Educational Robotics Group at UCAB</a> to implement a small set of electronic 
control boards like the Arduino UNO. The Pinguino boards were choosen mainly because they were very sturdy, easy to build, program and repair, 
and their electronic components were cheap and constantly available in the Venezuelan market.
</p>

<hr>
<h2> Project requirements and solution alternatives </h2>
At the start of the project we had an initial reunion with the UCAB Educational Robotics Group director in which we identified the following <b>technical requirements</b> for the 
control boards to be built (ordered by priority):

<br>

1. Preferably follow existing, tested and widely known Open Hardware projects.
2. Electronic components should be cheap and available in the Venezuelan market.
3. Installation and programming processes as simple as possible. Control boards should have a graphical tool for programming, 
like the Arduino IDE.
4. Easy construction process. No need for specialized machines to manufacture the PCB or solder the components.
5. Rather robust construction, as they were going to be used with kids.
6. Possibility of being fed with a commercial 9V battery.
7. As similar as possible to the Arduino UNO boards.

<br>

An investigation was conducted to identify existing Open Hardware control boards projects, propose two different solutions 
that satisfied the project requirements, and present them to the UCAB Educational Robotics Group. The solutions were:

<br>

1. To <b>build a small set of barebones <a href="http://arduino.cc/en/Main/arduinoBoardUno">Arduino UNO boards</a></b>, on one-sided PCB's, as in this <a href="http://www.instructables.com/id/How-to-make-your-own-Arduino-board/">Instructable</a>.
	* Pros: The Arduino platform is Open Hardware, highly developed, and has plenty of support <u>(Satisfies Req.#1)</u>. ATMEGA 328P and its
	other componentes are available in the Venezuelan market at a cheap price <u>(Satisfies Req.#2)</u>. Boards are really easy to build 
	<u>(Satisfies Req.#4)</u>,can be fed with a 9V battery (Satisfies Req.#6), sturdy <u>(Satisfies Req.#5)</u>, and are native-Arduino boards 
	<u>(Satisfies Req.#7)</u>.
	* Cons: As the ATMEGA 328P doesn't have an integrated USB interface, the group would need to have either a FTDI Serial-to-USB 
	board (like <a href="http://www.jameco.com/webapp/wcs/stores/servlet/Product_10001_10001_2117341_-1">this one</a>, another Arduino UNO
	board (to act as FTDI), which isn't simple enough to be used by the non-technical members of the group; or to modify the original
	Arduino UNO design by adding a MAX232 chip (difficult to find in Venezuela) to bridge the serial communication gap, as depicted 
	<a href="http://chuckontech.com/?p=147">here</a>. <u>(Doesn't satisfy Req.#3)</u>
2. To <b>build a small set of 8-bit <a href="http://wiki.pinguino.cc/index.php/Main_Page">Pinguino boards</a></b>, as the <a href="http://wiki.pinguino.cc/index.php/PIC18F2550_Pinguino">Pinguino 2550</a>, 
the <a href="http://wiki.pinguino.cc/index.php/PIC18F4550_Pinguino">Pinguino 4550</a> and the <a href="https://github.com/PinguinoBase/Pinguino-Base-4550">Pinguino Base 4550</a>.
	* Pros: The Pinguino project is an Open Hardware project, has a committed community of developers behind it, and has been experimenting
	constant growth <u>(Satisfies Req.#1)</u>. The required electronic components are really cheap and easy to find in Venezuela <u>(Satisfies Req.#2)</u>.
	Boards are really easy to build, and as sturdy as the barebones Arduino UNO, and can be easier to repair, as the integrated USB-interface 
	in the PIC 18F2550 and 18F4550 chips considerably reduce the number of integrated circuits on the board <u>(Satisfies Reqs.#4,5)</u>. The Pinguino
	2550 and 4550 microcontroller bootloaders can be programmed with PIC programmers available in UCAB Informatics and Telecommunicacion Engineering
	laboratories, both chips include an integrated USB interface that simplifies the process installing and programming the boards, and are
	compatible with the official Pinguino IDE, which greatly resembles the Arduino IDE, and includes features as code completion) <u>(Satisfies Req.#3)</u>.
	The boards can be easily fed by a 9V battery) <u>(Satisfies Req.#6)</u>. Finally, the Pinguino boards have many similarities with the Arduino UNO
	boards, as depicted <a href="http://wiki.pinguino.cc/index.php/Pic18f2550_vs_atmega328">here</a>. <u>(Satisfies Req.#7)</u>
	* Cons: The Pinguino IDE lacks a graphical interface to read data being received through the Serial port, and a third-party
	application like <a href="http://www.chiark.greenend.org.uk/~sgtatham/putty/">PuTTY</a> is required to stablish Serial communication 
	with the boards on Windows. The users and developers community is really small in comparisson with the community that supports the Arduino, 
	information about the boards is not as organized and homogeneous, and the Pinguino project isn't nearly as developed as the Arduino project. 
	Not all shields and peripherals built for the Arduino UNO are compatible with the Pinguino boards.
	

<br>
<p style='text-align: justify;'>
After presenting the two solution proposals, the director of the UCAB Educational Robotics Group chose the one that involved building a 
small set of Pinguino boards, because if satisfied all the project requirements, serial communication and additional peripherals where not a 
priority for them, and, as they would use the boards for teaching very basic electronics and robotics concepts to the kids, that would reduce the 
need of community support.
</p>


<br>
<hr>
<h2> The Pinguino control boards </h2>

<p style='text-align: justify;'>
Among the 8-bit Pinguino boards the <a href="https://github.com/PinguinoBase/Pinguino-Base-4550">Pinguino Base 4550 board</a> was 
selected because it includes a voltage regulator, and has more digital and analog ports than the Pinguino 2550 board. A prototype 
of the Pinguino Base 4550 was then built and tested:
</p>

<br>

<em>Built Pinguino Base 4550 board:</em>
[![Built Pinguino Base 4550 board](/projects_images/thumb.PinguinoUCAB-BuiltPBase4550.jpg)](/projects_images/PinguinoUCAB-BuiltPBase4550.jpg)

<br>
<p style='text-align: justify;'>
We presented the Pinguino Base 4550 board to the Educational Robotics Group, and were asked to reduce the boards size if possible, so
as to diminish its overall cost and use of PCB. We modified the circuit schematics to reduce costs by decreasing its total size and 
removing the ICSP headers. The modified boards were called "PinguinoUCAB".
</p>

<br>

<em>Size comparison between the Pinguino Base 4550 and the PinguinoUCAB boards:</em>
[![Size comparison between the Pinguino Base 4550 and the PinguinoUCAB boards](/projects_images/thumb.PinguinoUCAB-PinguinoBoardsSizeComparison.jpg)](/projects_images/PinguinoUCAB-PinguinoBoardsSizeComparison.jpg)

<br>
<p style='text-align: justify;'>
Two prototypes of the PinguinoUCAB boards were built before a major economic unforeseen situation totally reduced the Educational Robotics
Group funds for the project.
</p>


<em>Built PinguinoUCAB board:</em>
[![Built PinguinoUCAB board](/projects_images/thumb.PinguinoUCAB-BuiltPUCAB.jpg)](/projects_images/PinguinoUCAB-BuiltPUCAB.jpg)

<br>


<hr>
<h2> Boards construction video tutorial </h2>

<p style='text-align: justify;'>
Without funds, we agreed with the Educational Robotics Group to dedicate ourselves to produce a video tutorial describing the construction
process so that the boards could be easily reproduced by the members of the Educational Robotics Group.
</p>

<br>
<em>Boards construction tutorial:</em>

[![How to build PinguinoUCAB boards](http://img.youtube.com/vi/QoQYBjscoxM/0.jpg)](http://www.youtube.com/watch?v=QoQYBjscoxM)

<b>(YouTube video. Click on the image to be redirected to YouTube)</b>

<br>
<hr>
<h2> Motor control and sensors modules </h2>
<p style='text-align: justify;'>
A set of touch sensors, transistor-based DC motor control circuits and Light-Detection-Resistances was arranged on a PCB to test the Pinguino 
boards and serve as the first prototype of a low-cost learn-electronics-with-pinguino kit that is going to be developed in the future by the 
Educational Robotics Group. 
</p>


<em>Motor control and sensors module prototype:</em>
[![Motor control and sensors module prototype](/projects_images/thumb.PinguinoUCAB-MotorsSensorsModule.jpg)](/projects_images/PinguinoUCAB-MotorsSensorsModule.jpg)

<br>
<hr>

<h2> Miscellaneous videos </h2>

<em>LED blinking while waiting for a new program to be uploaded:</em>

[![LED blinking while waiting for a new program to be uploaded ](http://img.youtube.com/vi/WXtJsBcvUz4/0.jpg)](http://www.youtube.com/watch?v=WXtJsBcvUz4)

<br>
<br>
<em>Blink (1 second period) example :</em>

[![Blink (1 second period) example](http://img.youtube.com/vi/80TNpihYQI0/0.jpg)](http://www.youtube.com/watch?v=80TNpihYQI0)


<br>
<br>
<hr>

<b>All the code, schematics and documentation were released by the Educational Robotics Group at UCAB with the Creative Commons license. You can find all the files in <a href="https://github.com/YoshuaNava/GrupoRoboticaEducativaUCAB">this GitHub repository</a> (It's in spanish) </b>
