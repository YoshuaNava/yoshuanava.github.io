---
layout: post
modal-id: 1
date: 2015-02-09
img: 
alt: image-alt
project-date:
type: blog
category: miscellaneous
comments: "true"
publish: "true"
title: "How to automate the generation of image thumbnails for your webpage (Ubuntu/Debian)"
description: "Bash script to automatically generate image thumbnails for your webpage using imagemagick"
p_languages: "Bash"
---

If you're making your own webpage, you might have gone through the process of manually generating a reduced version of your images to
make your page load faster. I developed a bash script to automate this process with ImageMagick. In the following lines I describe
how to install ImageMagick, and how to execute the script:

<hr>
<h2> Installation </h2>
Open a terminal and enter the following command:
{% highlight bash %}
sudo apt-get install imagemagick
{% endhighlight %}

<hr>
<h2> How to execute the script </h2>

<b>1)</b> Create an empty file (the script file) called "GenerateThumbnailsImageMagick.sh" in the folder where you have your images.

<b>2)</b> Open the "GenerateThumbnailsImageMagick.sh" file with a text editor, and paste the following lines in it:
{% highlight bash %}
#! /bin/bash

for fileName in $( ls ); do
	$( convert -thumbnail 640 $fileName thumb.$fileName )
	if [ $? -eq 0 ]; then
		echo "$fileName thumbnail generated."
	else
		echo "$fileName thumbnail generation ERROR."
	fi
done
{% endhighlight %}

Explanation: 

* The first line tells the interpreter that we are executing a <a href="http://www.linux.com/learn/tutorials/284789-writing-a-simple-bash-script-">bash script</a>.
* A <a href="http://tldp.org/HOWTO/Bash-Prog-Intro-HOWTO-7.html">bash loop</a> goes through every fileName in your folder (assuming that 
there are only images in it, in any format), and does the following:
	* Generates the thumbnail by executing the command "$( convert -thumbnail 640 $fileName thumb.$fileName )". The command starts with "convert",
	which is a call to the imagemagick tool. -thumbnail is a command to transform the files into thumbnails with a <b>width of 640 pixels</b> 
	(you can change this parameter to modify the width of the generated thumbnails). $fileName is the name of the file that is going to be processed,
	 and thumb.$fileName is the name of the thumbnail file (This means that, for example, after executing the script, a file called image.jpg would 
	 have a thumbnail called thumb.image.jpg)
	* Tells you if the thumbnails was succesfully generated or if an error happened in the process (something that would normally happen if you have 
	non-image type files in the folder where the script is being executed.) -to do that, the content of the $ variable is used, as described
	<a href="http://askubuntu.com/questions/29370/how-to-check-if-a-command-succeeded">here</a>

<b>3)</b> Open a terminal, and change the directory (with the <a href="http://www.linfo.org/cd.html">cd command</a>) to the folder where 
your image and script files are allocated.


<b>4)</b> To execute the script file, we need to explicitly allow its execution under Ubuntu. In order to do that, enter the following command
in the terminal:
{% highlight bash %}
chmod +x GenerateThumbnailsImageMagick.sh
{% endhighlight %}


<b>5)</b> Finally, enter the following command to execute the file:
{% highlight bash %}
./GenerateThumbnailsImageMagick.sh
{% endhighlight %}


