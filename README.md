# ssh_tunnel_manager
A bash script to rule all your SSH tunnels!

You work in an environment that the hosts are behind an SSH gateway? you have multiple tunnels that make your life hard?
This tool allows you to handle all your tunnels in one place

## How to create your connections file

The file with the SSH tunnel connections must be in this form, is actually the ssh part without the ssh command, each line must is a separate tunnel
```
ssh_gateway1 -L 33891:windows1:3389
-R 8080:127.0.0.1:80 webserver1
-D 33334 -q -C -N -f ssh_gateway1
```

## How to use the tool

## Start tunnels
tunnel_manager.sh connections.csv start

If there no any connectivity issues and the commands in the connections.csv file are correct the tunnels will start in parallel and stay in the background.

Tue Feb 1 18:24:11 EET 2022 - INFO - TUNNEL CREATED - gateway2 -L 33887:windows1:3389
Tue Feb 1 18:24:13 EET 2022 - INFO - TUNNEL CREATED - gateway2 -L 33888:windows2:3389
Tue Feb 1 18:24:13 EET 2022 - INFO - TUNNEL CREATED - gateway1 -L 33889:windows3:3389
Tue Feb 1 18:24:13 EET 2022 - INFO - TUNNEL CREATED - -D 33332 -q -C -N -f gateway1
Tue Feb 1 18:24:13 EET 2022 - INFO - TUNNEL CREATED - -D 33331 -q -C -N -f gateway2

## Get the status of the tunnels
tunnel_manager.sh connections.csv status

This will print the status if the SSH tunnels.

Tue Feb 1 18:26:44 EET 2022 - INFO - TUNNEL CREATED - gateway2 -L 33887:windows1:3389
Tue Feb 1 18:26:44 EET 2022 - INFO - TUNNEL CREATED - gateway2 -L 33888:windows2:3389
Tue Feb 1 18:26:44 EET 2022 - INFO - TUNNEL CREATED - -D 33332 -q -C -N -f gateway2

## Stop tunnels
tunnel_manager.sh connections.csv stop

Tue Feb 1 18:28:05 EET 2022 - INFO - TUNNEL STOPPED - gateway2 -L 33888:windows1:3389
Tue Feb 1 18:28:05 EET 2022 - INFO - TUNNEL STOPPED - gateway2 -L 33889:windows2:3389
Tue Feb 1 18:28:05 EET 2022 - INFO - TUNNEL STOPPED - -D 33332 -q -C -N -f gateway2
