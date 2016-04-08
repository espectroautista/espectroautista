#!/bin/bash

#[[ $HOSTNAME == 'ks369902.kimsufi.com' ]] || {

[[ $HOSTNAME == 'ns3301013.ip-5-135-157.eu' ]] || {
	echo "Error: to execute only in production server"
	exit
}

W=/home/joan/espectroautista.info/conf

function change-path {
	local conf=$1

	if [[ -e $conf ]]; then
		sed -i -e 's/espectroautista-info/espectroautista.info/g' "$conf"
	else
		echo "Warning: $conf does no exists"
	fi
}

change-path $W/host.conf
change-path $W/routes.conf
change-path $W/directories.conf

sudo /usr/sbin/apachectl configtest
sudo systemctl reload httpd.service

# vim:ai:sw=4:ts=4
