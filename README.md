# ECEN_5813_Project_2 - README
## Mike Fruge and Mark Hinkle

Repository for project 2 of Principles of Embedded Software (ECEN 5813)

This repository contains all required elements for Project 2 of ECEN 5813 F19.


1) PES_Project_2 - This is a C project designed to run a simple program with 4 different build configurations on both a PC and on the NXP FRDM-KL25Z development board. The functionallity of the program is quite similar in all 4 cases - generate a timing routine that is aimed at cycling through the colors of an RGB led while blinking on and off at various timing periods. In the case of the PC builds, instead of blinking an LED, the program will print the specified LED state to a local terminal. For both the PC builds and the Freedom Board builds, there is a run mode as well as a debug mode that prints the LED state as well as the desired wait time.

2) PES_Project_2_Code.pdf - This repo also contains a pdf of all of the code we have written for the project detailed above. This is to ensure that our work can pass a plagarism check and prove that the submitted assignment is entirely our own 

3) Updated_PES_Project_2_WBS.png - This is a diagram that outlines the roles and responibilites of our team that we executed during the development of this project. Each task has been labeled with the owner/lead of that role as well as a rating of how much time that subsection required.
    
Installation / Execution Notes


In order to properly run all 4 of the variations of the project, build targets must be defined in the IDE for fb_run, fb_debug, pc_run, and pc_debug (as well as the typical all and clean build targets). We reccomend cleaning the project before each new build to ensure proper building of targets. To execute any freedom board builds, either flash the .axf file to the board and supply power via USB or run the project through the debugger (recommended). To exectute the PC builds, navigate to your project directory via a local terminal and type the command PES_Project_2.exe
    
All rights reserved
