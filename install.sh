#!/bin/bash
#
# CloudNet Installer
# Automatically installs the CloudNet software and necessary dependencies.
# Additionally checks for issues regarding other running services.
#
# Author: TheMeinerLP
# Compatible with CloudNetv3
# Version: 0.1
# Inspired: GaintTreeLP CloudNet v2 Installer

install_package() {
	echo "Checking and installing" "$@" "..."
	if ! ./pacapt --noconfirm -S "$@" 2>"/dev/null" 1>"/dev/null"; then
		echo "Error installing '$1'."
		echo "Aborting installation."
		exit 1
	fi
}

install_java() {
	if [ -x "$(command -v java)" ]; then
		echo "Found a valid installation of Java."
		echo "Please make sure it is compatible with CloudNet."
		return
	fi

	if [ -f "/etc/os-release" ]; then
		source "/etc/os-release"

		if [ "$ID" = "debian" ]; then
			# Handle slim versions
			# https://github.com/debuerreotype/docker-debian-artifacts/issues/24
			mkdir -p "/usr/share/man/man1"
			VERSION_ID=${VERSION_ID:=9} # Debian buster does not have VERSION_ID in its /etc/os-release file, fixing to 9 then.

			if [ "$VERSION_ID" = "8" ]; then
				echo "Found Debian 8, using jessie-backports of Java 8"
				echo "deb http://archive.debian.org/debian jessie-backports main" >"/etc/apt/sources.list.d/jessie-backports.list"
				echo "Acquire::Check-Valid-Until \"false\";" > "/etc/apt/apt.conf.d/100disablechecks"
				update_package_cache
				install_package 'openjdk-8-jre-headless' '-t' 'jessie-backports'
				rm "/etc/apt/apt.conf.d/100disablechecks"
				return
			elif [ "$VERSION_ID" -gt "8" ]; then
				echo "Found modern Debian, Java 11 or later should be the default."
				echo "Spigot 1.8 might not work, anyone using it is highly recommended to switch to a supported version."
				install_package 'default-jre-headless'
				return
			else
				echo "Unsupported version of Debian."
				echo "We are trying to install Java using the 'default-jre-headless' package."
				echo "Spigot 1.8 might not work, anyone using it is highly recommended to switch to a supported version."
				install_package 'default-jre-headless'
				return
			fi
		elif [ "$ID" = "ubuntu" ]; then
			if [ "$VERSION_ID" = "14.04" ]; then
				echo "Found old version of Ubuntu."
				echo "Using OpenJDK PPA..."
				echo -e "deb http://ppa.launchpad.net/openjdk-r/ppa/ubuntu trusty main\\ndeb-src http://ppa.launchpad.net/openjdk-r/ppa/ubuntu trusty main" >"/etc/apt/sources.list.d/ppa-openjdk.list"
				apt-key adv --keyserver "keyserver.ubuntu.com" --recv-keys "86F44E2A" 2>"/dev/null" 1>"/dev/null"
				update_package_cache
				install_package 'openjdk-8-jre-headless'
				return
			else
				install_package 'openjdk-11-jre-headless'
				return
			fi
		elif [ "$ID" = "alpine" ]; then
			echo "Choosing correct $ID package."
			install_package 'openjdk11-jre-base'
			return
		elif [ "$ID" = "arch" ]; then
			echo "Choosing correct $ID package."
			install_package 'jre11-openjdk-headless'
			return
		elif [ "$ID" = "centos" ] || [ "$ID" = "fedora" ]; then
			echo "Choosing correct $ID package."
			install_package 'java-11-openjdk-headless'
			return
		fi

		echo "Trying to install on $NAME using default package"
		install_package 'openjdk-11-jre-headless'
	fi

	echo "Could not install Java."
	echo "Aborting installation."
	echo "Please install Java manually."
	exit 1
}

update_package_cache() {
	./pacapt -Sy 2>"/dev/null" 1>"/dev/null"
	retval=$?
	if [ "$retval" -eq 1 ]; then
		echo "Error updating the package cache."
		echo "Aborting installation."
		exit 1
	fi
}

check_incompatibilities() {
	if [ ! -x "$(command -v fuser)" ]; then
		return
	fi
	echo "Checking for incompatibilities..."
	if fuser '1410/tcp' '2812/tcp'; then
		echo "Another CloudNet-Instance is already running."
		echo "You might want to stop it first or configure this one to use different ports."
	fi

	if fuser '25565/tcp'; then
		echo "Another process is using the port 25565 which is typically used by Minecraft."
		echo "You might want to stop it first or configure this one to use different ports."
	fi
}

echo "NOTICE: The installation requires root permissions to install dependencies!"

if [ $EUID -ne 0 ]; then
	echo "Non-root user detected."
	echo "Dependencies will be skipped!"
fi

echo "Welcome to the CloudNet installer"
echo "This script will download the latest version of CloudNet"
echo "and it's dependencies, so that you can run it right away."
sleep 1

if [ $EUID -eq 0 ]; then
	echo "Downloading dependencies..."
	curl --progress-bar -L -q -o "./pacapt" "https://raw.githubusercontent.com/icy/pacapt/ng/pacapt" && chmod +x "./pacapt"

	echo "Updating package cache..."
	update_package_cache

	echo "Installing dependencies..."
	install_package 'screen' 'unzip'
	install_java
fi

echo "Downloading the latest version of CloudNet..."
curl --progress-bar -L -q -o "cloudnet.zip" "https://github.com/CloudNetService/CloudNet-v3/releases/latest/download/CloudNet.zip"

echo "Verifying download..."
unzip -tq "cloudnet.zip"

echo "Unpacking CloudNet..."
unzip -qo "cloudnet.zip"

echo "Preparing start scripts..."
chmod u+x "CloudNet/start.sh"

check_incompatibilities

echo "Cleaning up..."
rm "./pacapt" "cloudnet.zip"

echo "Installation successful."
echo "Enjoy the Cloud Network Environment Technology CloudNet"
echo "For questions regarding this script, head over to the official Discord:"
echo "https://discord.gg/CloudNet"
echo ""