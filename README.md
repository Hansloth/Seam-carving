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
-----

## Introduction of my project

### Data picture
>In this project, I use the picture "penguins.jpg", which you can download from this project's Github page.

### Find the seam (backward energy calculation)
>This part of code was written in the file named **"find_delete_line.m"**
>>Based on the procedure of seam carving mentioned above. First I start with an picture "penguins.jpg".
>>>Secondly, I use gradient magnitude to calculate the energy of the picture.
>>>>Thirdly, I have to find out the recursion relation of the picture's gradient magnitude.
M(i, j)= E(i, j) + min(M(i −1, j −1),M(i −1, j),M(i −1, j +1))
>>>>>The fifth step is to backtrack(backward energy calculation) the lowest-energy pixel of each row
>>>>>>The last step is to set the pixels which we backtracked in the last step into red.

### Delete the seam n times (backward energy calculation)
>This part of code was written in the file name  **"delete_line_ntimes.m"**
>>Based on the previous code, I have the seam at the moment. That is, cascade all the pixels except the pixels that are the lowest-energy pixel of each row.  

### Delete the seam N times (forward energy calculation)
see [What is forward energy seam carving?](https://avikdas.com/2019/07/29/improved-seam-carving-with-forward-energy.html)
>This part of code was written in the file name  **"delete_line_forward_energy.m"**
>>First I start with an picture "penguins.jpg".
>>>Secondly, I use gradient magnitude to calculate the energy of the picture.
>>>>Thirdly, I use forward energy method to calculate the picture's gradient magnitude.
CL(x,y)=D[(x−1,y),(x+1,y)]+D[(x,y−1),(x−1,y)]
CU(x,y)=D[(x−1,y),(x+1,y)]
CR(x,y)=D[(x−1,y),(x+1,y)]+D[(x,y−1),(x+1,y)]
>>>>>The fifth step is to find(forward energy calculation) the lowest-energy pixel of each row
>>>>>>The last step is to set the pixels which we find was the smallest in the row, in the last step, into red and delete it.

### Delete the seam N times horizontally and vertically (backward energy calculation)
>This part of code was written in the file name  **"delete_line_VH.m"**
In this section seam are calculated and deleted horizontally and vertically

### Preserve part of the image while seam carving (backward energy calculation)

### Reserve part of the image while seam carving (backward energy calculation)

### Reserve part of the image completely while seam carving (backward energy calculation)









