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
title: "PinguinoUCAB"
description: "Undergraduate communitary service: implementation of a small set of Pinguino control boards and sensor modules."
p_languages: "Pinguino C"
---

As part of my mandatory communitary service I worked with Jonathan Teixeira, another student, and the Educational Robotics Group 
at UCAB to implement a small set of <a href="http://pinguino.cc/">Pinguino control boards</a>. The Pinguino boards were choosen 
because their electronic components could be found in the Venezuelan market.

Based on the requirements of the group, the <a href="https://github.com/PinguinoBase/Pinguino-Base-4550">Pinguino Base 4550 board</a>
was choosen to be the first prototype. We built one (the board on the photo following this text), and tested it.

<img src="/projects_images/PinguinoBase4550.jpg" alt="Build Pinguino Base 4550 board" width="320">

We presented the Pinguino Base 4550 board to the Educational Robotics Group, and were asked to reduce the boards size if possible, so
as to diminish its overall cost and use of PCB. We modified the circuit schematics to reduce costs by decreasing its total size and 
removing the ICSP headers. The modified boards were called "PinguinoUCAB".

<img src="/projects_images/SizeComparisonPinguinoUCAB.jpg" alt="Size comparison between the Pinguino Base 4550 and the PinguinoUCAB boards" width="320">

Two prototypes of the PinguinoUCAB boards were built before a major economic unforeseen situation totally reduced the Educational Robotics
Group funds for the project.

<img src="/projects_images/BuiltPinguinoUCAB.jpg" alt="Built PinguinoUCAB board" width="320">

Without funds, we agreed with the Educational Robotics Group to dedicate our efforts recording a video tutorial describing the construction
process so that the boards could be easily reproduced by the members of the Educational Robotics Group.

<b>(YouTube video. Click on the following image to be redirected to YouTube)</b>
[![How to build PinguinoUCAB boards](http://img.youtube.com/vi/QoQYBjscoxM/0.jpg)](http://www.youtube.com/watch?v=QoQYBjscoxM)

A set of touch sensors, DC motor transistor-based control circuits and Light-Detection-Resistances was arranged on a PCB to test the Pinguino 
boards and serve as the first prototype of a low-cost learn-electronics-with-pinguino kit that is going to be developed in the future by the 
Educational Robotics Group. Finally, we wrote manuals for building and programming the boards,

<hr>

<b>All the code, schematics and documentation were released by the Educational Robotics Group at UCAB with the Creative Commons license. You can find all the files in <a href="https://github.com/YoshuaNava/GrupoRoboticaEducativaUCAB">this GitHub repository</a> (It's in spanish) </b>
