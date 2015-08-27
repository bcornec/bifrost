Docker container for bifrost
----------------------------

In order to help testing bifrost, this directory provides a script which
you should be able to run on your system (providing you have docker support 
and a docker registry) which will create a docker container running bifrost
on the port 5000.

To build your container, just issue:  ./buildImage.sh
To launch it, just issue: run-bifrost.sh
To use it, just issue: firefox http://localhost:5000/
