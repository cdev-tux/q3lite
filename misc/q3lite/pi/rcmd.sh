#!/bin/bash
# Copyright (C) 2016-2017 cdev-tux - github.com/cdev-tux
# This file is part of Q3lite source code.
# See COPYING.txt for license details.

logged_in_user=$(who | grep -m 1 "." | awk '{print $1}')
if [ -z "$logged_in_user" ]; then
	q3l_user="pi"
else
	q3l_user="$logged_in_user"
fi
q3l_userhome=$(sudo -u $q3l_user -H -s eval 'echo $HOME')
pipefile="$q3l_userhome/.q3a/baseq3/pipefile"
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
		whiptail --msgbox "Rcon command sent to server:\n\n$rcon_command" 11 45
	done

exit 0
