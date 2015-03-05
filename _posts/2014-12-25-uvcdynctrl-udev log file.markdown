---
layout: post
modal-id: 1
date: 2015-03-05
img: 
alt: image-alt
project-date: March 2015
category: miscellaneous
type: blog
comments: "true"
publish: "true"
title: "Huge reduction in free disk space after running the cheese webcam app, or using camera packages for ROS under Ubuntu 14.04-64Bits?"
description: "Huge log file in /var/log folder, appearing after recently using camera packages for ROS, or running the cheese webcam application."
p_languages: ""
---

<hr>
<h2> Problem </h2>
<p style='text-align: justify;'>
I recently discovered that I was running out of free hard disk space after running the <a href="http://wiki.ros.org/usb_cam">usb_cam camera package for ROS</a> and 
using the <a href="https://apps.ubuntu.com/cat/applications/precise/cheese/">cheese webcam application</a> (which frequently crashed a lot) under XUbuntu 14.04-64Bits. I used the <a href="https://wiki.gnome.org/Apps/Baobab">baobab</a> 
application to analyze my disk usage, and found that it had a size of 15GB. I thought that was pretty weird, and I executed 
my file explorer (nautilus) with super-user privileges (sudo) and with the "show hidden folders and files" option. There, I 
found a HUGE (14.6GB) log 
file called <b>ucvdynctrl-udev.log</b>.
</p>


<br>
<em>Screenshot showing the <b>ucvdynctrl-udev.log</b> in my /var/log folder:</em>
[![](/posts_images/thumb.VarLogFile-uvcdynctrl.png)](/posts_images/VarLogFile-uvcdynctrl.png)

<br>
<hr>
<h2> Solution </h2>

<p style='text-align: justify;'>
After finding the <b>ucvdynctrl-udev.log</b> file in my PC, I did a little research, and found out that there would be no problem if
I erased it, as it only contained information from past executions of the camera drivers.
I decided to delete the file and I did so by introducing the following command in a terminal:
</p>

{% highlight bash %}
sudo rm /var/log/uvcdynctrl-udev.log
{% endhighlight %}

<br>
<hr>
<h2> The aftermath </h2>
<p style='text-align: justify;'>
I haven't had any problems since I deleted the file. The cheese webcam app isn't crashing as much as before, and
I suppose that it may be a positive consequence of erasing the uvcdynctrl-udev.log file.
</p>

