#!/bin/bash
echo "This will completely remove Process Resource Monitor from your server!"
echo -n "Would you like to proceed? "
read -p "[y/n] " -n 1 Z
echo
if [ "$Z" == "y" ] || [ "$Z" == "n" ]; then
	rm -rf /usr/local/prm /etc/cron.d/prm /usr/local/sbin/prm
	echo "Process Resource Monitor has been uninstalled."
else
	echo "You selected No or provided an invalid confirmation, nothing has been done!"
fi

