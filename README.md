# Seam Carving


## What is seam carving?
see [Wikipedia](https://en.wikipedia.org/wiki/Seam_carving)

>Seam carving (or liquid rescaling) is an algorithm for content-aware image resizing, developed by Shai Avidan, of Mitsubishi Electric Research Laboratories (MERL), and Ariel Shamir, of the Interdisciplinary Center and MERL. It functions by establishing a number of seams (paths of least importance) in an image and automatically removes seams to reduce image size or inserts seams to extend it. Seam carving also allows manually defining areas in which pixels may not be modified, and features the ability to remove whole objects from photographs.


>To be more specific, the procedure of seam carving are shown below.
* Start with an image.
* Calculate the weight/density/energy of each pixel. This can be done by various algorithms: gradient magnitude, entropy, visual saliency, eye-gaze movement.In my project gradient magnitude are used.
* From the energy, make a list of seams. Seams are ranked by energy, with low energy seams being of least importance to the content of the image. Seams can be calculated via the dynamic programming approach below.
* Remove low-energy seams as needed.
* Final image.


### What are seams?

>Seams can be either vertical or horizontal. A vertical seam is a path of pixels connected from top to bottom in an image with one pixel in each row. A horizontal seam is similar with the exception of the connection being from left to right. The importance/energy function values a pixel by measuring its contrast with its neighbor pixels.

## Introduction of my code

>### Data picture
In this project, I use the picture "penguins.jpg", which you can download from this project's Github page.

>### Find the seam
>>This part of code are writen in the file name "find_delete_line"
>>>To find seam, we have to first calculate the recursion relation 
M(i, j)= E(i, j) + min(M(i −1, j −1),M(i −1, j),M(i −1, j +1))




