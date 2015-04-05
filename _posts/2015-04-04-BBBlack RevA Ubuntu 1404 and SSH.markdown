---
layout: post
modal-id: 1
date: 2015-04-04
img: 
alt: image-alt
project-date: April 2015
category: embeddedsystems
type: blog
comments: "true"
publish: "true"
title: "How to install and run Ubuntu 14.04 in a Beaglebone Black Rev-A with a micro-SD card, and then communicate by SSH (without ever using a screen with the BBB)"
description: "Tutorial on how to install Ubuntu 14.04 in Beaglebone Black Rev-A with a micro-SD, and then communicate by SSH, without ever using a screen to connect with the BBB."
p_languages: ""
---

<hr>
<h2> Overview </h2>
<p style='text-align: justify;'>
If you have a Beaglebone Black Rev-A, you might find that you are not able to install Ubuntu on its e-MMC memory. That's because the BBB Rev-a, as the first
revision of the board, didn't include e-MMC memory, and any operating system had to be run directly from the micro-SD card. 
</p>

<p style='text-align: justify;'>
<b>In this tutorial, I will explain to you how to install Ubuntu 14.04 for ARM in a micro-SD, so that we can run it on the Beaglebone Black Rev-A.</b> In order to 
follow it you will need the following materials:
</p>

* 1 x PC with Ubuntu (I have only tested this method on Ubuntu 14.04).
* 1 x Beaglebone Black Rev-A.
* 1 x micro-SD card with a storage capacity of 4GB or more.
* 1 x Mini-USB cable.
* 1 x Ethernet cross-over or direct cable.

<p style='text-align: justify;'>
When I installed Ubuntu 14.04 on my BBB board I didn't have a micro-HDMI cable available, so I had to find a way of communicating to it by
SSH. For that reason, as an extra, <b>I will also tell you how to run Ubuntu and communicate with the BBB board by SSH, without ever using an HDMI-compatible screen,
only your Linux terminal. </b>
</p>

<hr>
<h2> Step 1: Identify the device name of your micro-SD card </h2>
<p style='text-align: justify;'>
First, we need to identify which device name your micro-SD takes when you insert it into your computer. So, you need to do this:
</p>

<b>1.</b> Keep your micro-SD card out of your PC card slot, or, take it out of it, if it is already plugged in.

<b>2.</b> Open a terminal and type "df -h". You will see a list of physical and logical (partitions) storage units connected to your computer,
their size, used and available space, percentage of use, and their mounting address on your system.

<b>3.</b> Insert your micro-SD card into the card slot, and wait until your system recognizes it.

<b>4.</b> Type "df -h" in the same terminal you did before. You will see a new device at the bottom of the list, probably called "/dev/sdXy" (being X a letter, 
and y a number) with the same size, used and available space as your micro-SD card. The image below represents this situation:

<br>
<em>Micro-SD card device name:</em>
[![](/posts_images/thumb.BBBUbuntu1404microSDSSH-cardDeviceName.png)](/posts_images/BBBUbuntu1404microSDSSH-cardDeviceName.png)

<br>


<b>You should type down the name of this "/dev/sdXy" device, excluding the y of its name</b>. For example: if you find "/dev/sdb1" on the list, you should type down "/dev/sdb", because "/dev/sdb" is the name of your micro-SD and "/dev/sdb1" is a 
direct reference to the first partition on it.




<hr>
<h2> Step 2: Format and partition your micro-SD card </h2>
<p style='text-align: justify;'>
When I worked through this steps, I basically followed this <a href="http://www.armhf.com/boards/beaglebone-black/bbb-sd-install/">tutorial for formatting micro-SD cards for Beaglebone Black boards on the official ARMHF webpage</a>.
In the following lines, I cite the most important parts of it (all credits to the ARMHF people for that awesome tutorial):


<b>1.</b> 
1) Unmount the microSD card by typing "sudo umount /dev/sdX".

2) Begin partitioning the microSD Card by typing "sudo fdisk /dev/sdX".

a) Initialize a new partition table by selecting "o", then verify the partition table is empty by selecting "p".

b) Create a boot partition by selecting "n" for ‘new’, then "p" for ‘primary’, and "1" to specify the first partition. Press enter to accept the default first sector and specify "4095" for the last sector.

c) Change the partition type to FAT16 by selecting "t" for ‘type’ and "e" for ‘W95 FAT16 (LBA)’.

d) Set the partition bootable by selecting "a" and then "1".

e) Next, create the data partition for the root filesystem by selecting n for ‘new’, then p for ‘primary’, and 2 to specify the second partition. Accept the default values for the first and last sectors by pressing enter twice.

f) Press p to ‘print’ the partition table. It should look similar to the one below.

{% highlight bash %}
255 heads, 63 sectors/track, 966 cylinders, total 15523840 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0xafb3f87b

   Device Boot      Start         End      Blocks   Id  System
/dev/sdb1   *        2048        4095        1024    e  W95 FAT16 (LBA)
/dev/sdb2            4096    15523839     7759872   83  Linux</code>
{% endhighlight %}
g) Finally, commit the changes by selecting w to ‘write’ the partition table and exit fdisk."

<b>3.</b> Format the Partitions
a) Format partition 1 as FAT by typing "sudo mkfs.vfat /dev/sdX1"
b) Format partition 2 as ext4 by typing "sudo mkfs.ext4 /dev/sdX2"
</p>


<hr>
<h2> Step 3: Download Ubuntu 14.04 ARM and u-boot for Beaglebone Black</h2>
<b>1.</b> First, create a folder in your /home directory in which we will store the Ubuntu 14.04 and u-boot images, and change your current directory to it
 by typing the following commands:
{% highlight bash %}
mkdir ~/BBBlack_Ubuntu1404
cd ~/BBBlack_Ubuntu1404
{% endhighlight %}

<b>2.</b> Download Ubuntu 14.04 ARM for Beaglebone Black by typing:
{% highlight bash %}
wget http://s3.armhf.com/dist/bone/ubuntu-trusty-14.04-rootfs-3.14.4.1-bone-armhf.com.tar.xz
{% endhighlight %}


<b>3.</b> Download u-boot for Beaglebone Black:
{% highlight bash %}
wget http://s3.armhf.com/dist/bone/bone-uboot.tar.xz
{% endhighlight %}


<br>
<hr>
<h2> Step 4: Install u-boot and Ubuntu 14.04 on your Beaglebone Black </h2>
Again, I basically followed this <a href="http://www.armhf.com/boards/beaglebone-black/bbb-sd-install/">tutorial for formatting micro-SD cards for Beaglebone Black boards on the official ARMHF webpage</a>
while doing this step, being the main difference with respect to it that I previously downloaded Ubuntu and u-boot to be able 
to repeat the installation if I don't have an internet connection available. This is what you should do:

<b>1.</b> Install u-boot in your micro-SD card:
{% highlight bash %}
cd ~/BBBlack_Ubuntu1404
mkdir boot
sudo mount /dev/sdX1 boot
tar xJvf bone-uboot.tar.xz -C boot
sudo umount boot
{% endhighlight %}

<b>2.</b> Install Ubuntu 14.04 ARM in your micro-SD card:
{% highlight bash %}
cd ~/BBBlack_Ubuntu1404
mkdir rootfs
sudo mount /dev/sdX2 rootfs
sudo tar xJvf ubuntu-trusty-14.04-rootfs-3.14.4.1-bone-armhf.com.tar.xz -C rootfs
sudo umount rootfs
{% endhighlight %}

<b>Now you should have Ubuntu 14.04 for ARM installed on your micro-SD card, and you may be able to run it on your Beaglebone Black. However, if you don't
have an HDMI-compatible screen, you will not be able to communicate to your Beaglebone Black. If that is the case, continue with the following steps
of this tutorial, so that you can configure a static IP in your Beaglebone Black, and always access it through SSH with that IP.</b>


<br>
<hr>
<h2> Step 5: Configure a default static IP on your Beaglebone Black </h2>
Before you retire your micro-SD from your PC card slot, do the following:
<b>1.</b> Type "df -h" again, select with your mouse and copy the value of the column "Mounted on" (by pressing Ctrl+Shift+C), for the "/dev/sdX2" filesystem:
<br>
<em>Micro-SD card device name:</em>
[![](/posts_images/thumb.BBBUbuntu1404microSDSSH-devsdx2_MountedOn.png)](/posts_images/BBBUbuntu1404microSDSSH-devsdx2_MountedOn.png)

<b>2.</b> Type "sudo nano 'content you copied on step 1'" (to paste the content you copied previously, press Ctrl+Shift+V).


<b>3.</b> A file called "interfaces" should be opened in the nano editor, and you should it until it looks like this:
<br>
<em>Micro-SD card device name:</em>
[![](/posts_images/thumb.BBBUbuntu1404microSDSSH-staticIPinterfacesFile.png)](/posts_images/BBBUbuntu1404microSDSSH-staticIPinterfacesFile.png)


After that, press Ctrl+O to save, and Ctrl+X to exit.

<br>
<hr>
<h2> Step 6: Powering up your Beaglebone Black and testing your connection </h2>
<b>1.</b> Insert the micro-SD card into the Beaglebone Black micro-SD card slot.

<b>2.</b> Plug one end of the ethernet cable on your computer and the other on the Beaglebone Black.

<b>3.</b> Connect the Beaglebone Black to your computer with a mini-USB cable. If your system suddenly tries to connect to it (it usually appears as
"Wired connection 1"), stop it from doing so.

<b>4.</b> Open a terminal and type "suto ifconfig eth0 192.168.7.1" to set your ethernet interface IP to 192.168.7.1 (in the same network as 
192.168.7.2, the IP that we assigned to the Beaglebone Black).

<b>5.</b> Test your connection by typing "ping 192.168.7.2". If everything worked, after a short while you should see a message that reads 
"64 bytes from 192.168.7.1: icmp_seq=80 ttl=64 time=0.271 ms".


<br>
<hr>
<h2> Step 7: Connecting to your Beaglebone Black through SSH </h2>
To connect to your Beaglebone Black through SSH in the simplest way, type:
{% highlight bash %}
ssh ubuntu@192.168.7.2
{% endhighlight %}

You will be prompted for a password. The Ubuntu 14.04 image that we installed comes with a default user account, its username is set to be <b><em>ubuntu</em></b>, and its password is <b><em>ubuntu</em>.</b>


<br>
<hr>
<h2> Step 8: Sharing your internet connection with your Beaglebone Black </h2>
As described in this awesome tutorials: <a href="http://shallowsky.com/blog/hardware/talking-to-beaglebone.html">1</a> and <a href="http://stackoverflow.com/questions/19481415/share-the-internet-access-from-laptop-to-beaglebone-black-and-then-access-it-thr">2</a>, you should do the following:

<b>1.</b> Open a terminal in your PC and enter the following commands:
{% highlight bash %}
sudo iptables -A POSTROUTING -t nat -j MASQUERADE
echo 1 | sudo tee /proc/sys/net/ipv4/ip_forward > /dev/null
{% endhighlight %}

<b>2.</b> Connect to your Beaglebone Black through SSH and type the following command:
{% highlight bash %}
sudo nano /etc/resolv.conf
{% endhighlight %}
Then, add this line to make the Beaglebone Black starts use the Google DNS:
nameserver 8.8.8.8


<b>3.</b> Test your access to the internet by typing "ping www.google.com" in a terminal. If everything went alright, you should get something like 
"64 bytes from 201-248-78-241.dyn.dsl.cantv.net (201.248.78.241): icmp_seq=1 ttl=58 time=10.8 ms
"



<br>
<hr>
<h2> Final remarks </h2>
I hope this tutorial helps other people in the same situation I was. Being able to install Ubuntu 14.04 ARM in the Beaglebone Black Rev-A, which didn't have e-MMC,
 is something that I think that can be really helpful if you are working on robotics and you want to use ROS with the extraordinary Beaglebone Black!
 

If you have any problem, write a comment below, or send me an e-mail.

