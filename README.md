# AssettoCorsaLinuxScripts
Linux scripts for controlling ac servers.

## Prerequisites
There is a user called assettocorsa
The assettocorsa server has been installed using the instructions here: [http://b.joaoubaldo.com/installing-assetto-corsa-dedicated-server-in-linux-post/](http://b.joaoubaldo.com/installing-assetto-corsa-dedicated-server-in-linux-post/) 

There are parts of the script where the user is hardcoded so the user name is critical.

## Installing
Copy this file into onto you machine. /home/assettocorsa is a suggestion.
[code]
chmod u+x acServer.sh
vi acServer.sh
[code]
Change ASSETTO_DIR to be where the acServer executable is. Default value should be correct after doing a standard install.
Change PIDFILE and LOGFILE to locations the user running the script can write to.

## Running
cd to where the acServer.sh is.
./acServer.sh start - starts the server
./acServer.sh stop - stops the server
./acServer.sh status - tells you if the server is running or not
./acServer.sh tail - Tails the log file output from the acServer itself.

