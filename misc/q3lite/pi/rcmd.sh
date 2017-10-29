#!/bin/bash
# This file is part of the Q3lite source code. https://github.com/cdev-tux/q3lite
# See COPYING.txt for copyright and license details.
#
# To make sure the shell doesn't hang we run redirection in the background,
# because fifo waits for output to come out.
#OUTPUT="$( cat $pipefile  )" # release contents of pipe

logged_in_user=$(who | grep -m 1 "." | awk '{print $1}')
if [ -z "$logged_in_user" ]; then
	logged_in_user="pi"
fi
pipefile="/home/$logged_in_user/.q3a/baseq3/pipefile"
q3user="quake3"

while true
	do
		sudo systemctl is-active q3lite_ded.service > /dev/null
		if [ "$?" -eq 0 ]; then
			rcon_command=$(whiptail --inputbox "\nType rcon command, then press [Enter]\nExample: timelimit 25" 11 45 3>&1 1>&2 2>&3)
			if [ $? -eq 1 ]; then
				break;
			fi
		else
			whiptail --msgbox "The background server isn't running.\nYou can start the server with: \nq3admin start" 11 45
			break;
		fi
		sudo -u $q3user echo -e "$rcon_command" >$pipefile &
#		sudo -u quake3 echo -e "$rcon_command" 2> $pipefile &
		whiptail --msgbox "Rcon command sent to server:\n\n$rcon_command" 11 45
	done

exit 0
