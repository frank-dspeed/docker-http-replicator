# Source https://help.ubuntu.com/community/HttpReplicator
FROM ubuntu:14.04

RUN wget https://launchpad.net/~tikhonov/+archive/ubuntu/http-replicator/+build/5924499/+files/http-replicator_4.0%7Ealpha2-0tikhonov4%7Etrusty_all.deb
RUN dpkg -i http-replicator_4.0~alpha2-0tikhonov4~trusty_all.deb

#Now, to configure the proxy, open up the config file with

#sudo sensible-editor /etc/default/http-replicator

#Look at the line

#DAEMON_OPTS="$GENERAL_OPTS --port 8080 --log /var/log/http-replicator.log --user proxy"

#And change it to

#DAEMON_OPTS="$GENERAL_OPTS --port 8080 --log /var/log/http-replicator.log --user proxy --ip=192.168.0.*"

#--ip=192.168.0.*is whatever network address space your using.

#Its probably worth noting that ? and * are wildcards supported by http-replicator. You can make it accept connections from one host (or multiple hosts if you use --ip= more then once) or an entire subnet (as above).

#The other change you might like to do is change the port to 80. What this will do is make http-replicator cache all web trafic, without requiring you to reconfigure any client settings at all. Your resultant line will look something like:

#DAEMON_OPTS="$GENERAL_OPTS --port 80 --log /var/log/http-replicator.log --user proxy --ip=192.168.0.*"

#Then remove the line that says

#exit 0 # REMOVE THIS LINE TO ACTIVATE THE PROXY SERVER

#Save the file and exit.

#Restart the daemon (or start for the first time)

#sudo /etc/init.d/http-replicator restart

#And you're finished with the proxy!

#Now, all you have to do is get the clients ready. Note that if you changed the port http-replicator runs on to port 80, the following is unneeded. (The example given below is for proxying packages downloaded by APT).

#On the local computer you want to use http-replicator with, add this line to /etc/apt/apt.conf

#Acquire::http::Proxy "http://192.168.0.1:8080";

#Replace 192.168.0.1 with the IP of the server http-replicator is running on. 
