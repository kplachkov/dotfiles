#!/usr/bin/bash

echo "Setting up locales"

/usr/bin/sudo /usr/bin/sed -E -i '/(en_US.UTF-8|en_GB.UTF-8)/s/^# //g' /etc/locale.gen || return $?

/usr/bin/sudo /usr/sbin/locale-gen || return $?

echo "Updating locales"

/usr/bin/sudo /usr/sbin/update-locale \
	LANG='en_US.UTF-8' \
	LC_ADDRESS='en_US.UTF-8' \
	LC_NAME='en_US.UTF-8' \
	LC_MONETARY='en_US.UTF-8' \
	LC_PAPER='en_GB.UTF-8' \
	LC_IDENTIFICATION='en_US.UTF-8' \
	LC_TELEPHONE='en_US.UTF-8' \
	LC_MEASUREMENT='en_GB.UTF-8' \
	LC_TIME='en_GB.UTF-8' \
	LC_NUMERIC='en_GB.UTF-8'
