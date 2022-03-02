# Embroidotron
The Embroidotron is designed to convert any standard sewing machine into a computer controlled embroidery machine. Our goal is to make machine embroidery more accessible, hackable, and fun. This repository serves as a source for the software, CAD designs and examples for running the Embroidotron.

This project was developed as a team in CMU's Electromechanical Systems Design Class and carried forward with support from [The Carnegie Mellon Textiles Lab](https://textiles-lab.github.io/). The Embroidotron was conceived of by the team: Amy Santoso, Amos Fishman-Resheff, David Perry, Juan Luis Vasquez, and Yuree Chu. David Perry has carried this project forward with support from the initial team.

## Manuals
See the [Embroidotron Manual](https://docs.google.com/presentation/d/e/2PACX-1vQDnrs32w4o7STt2GDkAjPlq3Xo2kj3-9yWwGp2af6CuQFf4LI4kpUE5b-No-ILSyXCkttRJLsAB5MZ/pub?start=false&loop=false&delayms=3000) for instructions on setting up hardware and running your first job.

## Contents

 - **Embroidotron_PEmbroider_Integration** 
Demos the integration of the Embroidotron and [PEmbroider](https://github.com/CreativeInquiry/PEmbroider), an open library for computational embroidery with [Processing](http://processing.org/).
 - **Embroidotron_LiveStitch_Keypressed**
Demos the "live stitch mode" in which the user can drive the stitch path using the arrow keys.
 - **arduino_MotorControl**
 The firmware on the arduino which coordinates the needle, computer, and stepper motors.
 
## Images
 ![Embroidotron](https://github.com/DavidBPerry/Embroidotron/blob/master/Embroido_Documentation/PXL_20210723_194200352.jpg?raw=true)

<img
  src="https://github.com/DavidBPerry/Embroidotron/blob/master/Embroido_Documentation/far_stitching_1.gif?raw=true"
  alt="Stitching Far"
  style="display: inline-block; margin: 0 auto; max-width: 200px">
<img
  src="https://github.com/DavidBPerry/Embroidotron/blob/master/Embroido_Documentation/close_stitching_1.gif?raw=true"
  alt="Stitching Close"
  style="display: inline-block; margin: 0 auto; max-width: 200px">
  
## Live Stitching
A unique trait of the Embroidotron is that it can take input during stitching that can modify the stitch path in real time. In this demo the stitch path is guided by the arrow keys on the users laptop. See the code for this [here](https://github.com/DavidBPerry/Embroidotron/blob/master/Embroidotron_Processing/Embroidotron_LiveStitch_Keypressed/Embroidotron_LiveStitch_Keypressed.pde)

[![Live Stitch Demo](https://img.youtube.com/vi/fqFlIdqWc_c/0.jpg)](https://www.youtube.com/watch?v=fqFlIdqWc_c)



## Credits
Hardware and software developed by David Perry
### Thanks to
- **[Jim McCann](http://www.cs.cmu.edu/~jmccann/)** and **[CMU Textiles Lab](https://textiles-lab.github.io/)** for initial funding, support, and interest
- **[Golan Levin](http://flong.com/archive/bio/en/index.html)** for support and interest
- **[Sarah Bergbreiter](https://www.meche.engineering.cmu.edu/directory/bios/bergbreiter-sarah.html)** for project support during Electromechanical Systems Design
- The original Embroidotron team: 
	- Amy Santoso
	- Amos Fishman-Resheff
	- Juan Luis Vasquez
	- Yuree Chu
- **[Tatyana Mustakos](https://tatyanade.github.io/portfolio//)** for helping with this manual and for providing motivation for finishing up this project
