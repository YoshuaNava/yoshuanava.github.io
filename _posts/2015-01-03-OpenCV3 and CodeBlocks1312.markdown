---
layout: post
modal-id: 1
date: 2015-01-03
img: CodeBlocks_plus_OpenCV.png
alt: image-alt
project-date:
type: blog
category: computervision
comments: true
title: "How to install OpenCV 3.0 beta and link it to Code::Blocks projects under Ubuntu 14.04"
description: "Tutorial that describes how to install OpenCV 3.0 beta, and work with Code::Blocks in Ubuntu 14.04"
p_languages: ""
---

<h2>Installing OpenCV</h2> (As described in the <a href="http://docs.opencv.org/trunk/doc/tutorials/introduction/linux_install/linux_install.html#linux-installation">official OpenCV documentation</a>)

1) Execute the following commands in a terminal to install the gcc compiler and required dependencies:
{% highlight bash %}
sudo apt-get install build-essential
sudo apt-get install cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev
{% endhighlight %}


2) Execute the following commands in a terminal to obtain the latest opencv code from its repository:
{% highlight bash %}
cd ~/<my_working_directory>
git clone https://github.com/Itseez/opencv.git
{% endhighlight %}

3) Execute the following commands in a terminal to create a directory for the built files, and build them:
{% highlight bash %}
cd ~/opencv
mkdir build
cd build
cmake -D CMAKE_BUILD_TYPE=Release -D CMAKE_INSTALL_PREFIX=/usr/local ..
{% endhighlight %}

4) Finally, to build the necessary files in 7 different threads, and install them on Ubuntu, execute:
{% highlight bash %}
make -j7 # runs 7 jobs in parallel
sudo make install
{% endhighlight %}





<h2>Installing Code::Blocks from the Ubuntu repository</h2>
In a terminal execute the following lines to install the latest version of Code::Blocks:
{% highlight bash %}
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install codeblocks
{% endhighlight %}





<h2>Link OpenCV to a Code::Blocks project</h2>
<h3>NOTE: Whenever asked to keep the relative path, select No, so that you can move the project folder without breaking the library links.</h3>
1) Open Code::Blocks, and click File->New->Project.

2) Select "Console application", click Go and in the following wizard select the project programming language (C or C++, whichever you want to work with), introduce your project title, and specify the debugging and releasing configuration (you can keep the default configuration that appears).

3) As soon as the project appears on the "Management" file explorer, right click it, and select "Build options..."

4) In the "Project build options" window that appears, do the following:

4.1) Select the "Linker Settings" tab, and click on Add. On the window that appears, click on the "..." button, and in the file explorer go to /usr/local/lib. Select all the files called libopencv_*.so (* represents any combination of characters). When you are ready, click Ok until you are in the Project build options window again.
	
4.2) Select the "Search directories" tab, and then:
	
4.2.a) Select the "Compiler" tab, click Add, type "/usr/local/include/opencv" and click Ok.
		
4.3.b) Select the "Linker" tab, click Add, type "/usr/local/include/opencv2", and click Ok. Once again, click Add, type "/usr/local/lib", and click OK.
		
4.3) Press Ok to close the "Project build options window".

(I based this tutorial on the following articles: http://jonniedub.blogspot.com/2013/01/setting-up-codeblocks-ide-for-use-with.html and http://opensourcecollection.blogspot.in/2010/10/how-to-setup-codeblocks-for-opencv.html)


<h2>Test it</h2>
Edit your project main.cpp file and copy the following code (taken from http://docs.opencv.org/doc/tutorials/imgproc/shapedescriptors/point_polygon_test/point_polygon_test.html):
{% highlight c++ %}
/**
 * @function pointPolygonTest_demo.cpp
 * @brief Demo code to use the pointPolygonTest function...fairly easy
 * @author OpenCV team
 */

#include "opencv2/highgui/highgui.hpp"
#include "opencv2/imgproc/imgproc.hpp"
#include <iostream>
#include <stdio.h>
#include <stdlib.h>

using namespace cv;
using namespace std;

/**
 * @function main
 */
int main( void )
{
  /// Create an image
  const int r = 100;
  Mat src = Mat::zeros( Size( 4*r, 4*r ), CV_8UC1 );

  /// Create a sequence of points to make a contour:
  vector<Point2f> vert(6);

  vert[0] = Point( 3*r/2, static_cast<int>(1.34*r) );
  vert[1] = Point( 1*r, 2*r );
  vert[2] = Point( 3*r/2, static_cast<int>(2.866*r) );
  vert[3] = Point( 5*r/2, static_cast<int>(2.866*r) );
  vert[4] = Point( 3*r, 2*r );
  vert[5] = Point( 5*r/2, static_cast<int>(1.34*r) );

  /// Draw it in src
  for( int j = 0; j < 6; j++ )
     { line( src, vert[j],  vert[(j+1)%6], Scalar( 255 ), 3, 8 ); }

  /// Get the contours
  vector<vector<Point> > contours; vector<Vec4i> hierarchy;
  Mat src_copy = src.clone();

  findContours( src_copy, contours, hierarchy, RETR_TREE, CHAIN_APPROX_SIMPLE);

  /// Calculate the distances to the contour
  Mat raw_dist( src.size(), CV_32FC1 );

  for( int j = 0; j < src.rows; j++ )
     { for( int i = 0; i < src.cols; i++ )
          { raw_dist.at<float>(j,i) = (float)pointPolygonTest( contours[0], Point2f((float)i,(float)j), true ); }
     }

  double minVal; double maxVal;
  minMaxLoc( raw_dist, &minVal, &maxVal, 0, 0, Mat() );
  minVal = abs(minVal); maxVal = abs(maxVal);

  /// Depicting the  distances graphically
  Mat drawing = Mat::zeros( src.size(), CV_8UC3 );

  for( int j = 0; j < src.rows; j++ )
     { for( int i = 0; i < src.cols; i++ )
          {
            if( raw_dist.at<float>(j,i) < 0 )
              { drawing.at<Vec3b>(j,i)[0] = (uchar)(255 - abs(raw_dist.at<float>(j,i))*255/minVal); }
            else if( raw_dist.at<float>(j,i) > 0 )
              { drawing.at<Vec3b>(j,i)[2] = (uchar)(255 - raw_dist.at<float>(j,i)*255/maxVal); }
            else
              { drawing.at<Vec3b>(j,i)[0] = 255; drawing.at<Vec3b>(j,i)[1] = 255; drawing.at<Vec3b>(j,i)[2] = 255; }
          }
     }

  /// Create Window and show your results
  const char* source_window = "Source";
  namedWindow( source_window, WINDOW_AUTOSIZE );
  imshow( source_window, src );
  namedWindow( "Distance", WINDOW_AUTOSIZE );
  imshow( "Distance", drawing );

  waitKey(0);
  return(0);
}
{% endhighlight %}
