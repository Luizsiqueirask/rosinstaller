#!/bin/bash

# Author : Luiz Siqueira
# Copyright (c) Instituto Infnet
# This script was developed to assist in the installation.
# To the students of the Institute Infnet .
# Installer ROS 1 & 2, Chrome.
# Version 1.6.7.2

#-------------- All Color -----------------

black='\e[0;30m'	dark_gray='\e[1;30m'		red='\e[0;31m' 		light_red='\e[1;31m'
green='\e[0;32m' 	light_green='\e[1;32m'		brown_orange='\e[0;33m'	yellow='\e[1;33m'
blue='\e[0;34m' 	light_blue='\e[1;34m'		purple='\e[0;35m' 		light_purple='\e[1;35m'
cyan='\e[0;36m'	light_cyan='\e[1;36m'		light_gray='\e[0;37m'		white='\e[1;37m'
nc='\e[0m'

#--------------------------------------------

#You can change your version to installer only changing valiable name.
#select your version using position array for choise install version.

echo -e -n "$brown_orange Enter choice [1 - Kinetic | 2 - Melodic | 3 - Noetic | 4 - Exit]: $nc"
read ros1
case $ros1 in 
	  1)
		versionRos1='kinetic'
		;;
	  2)
		versionRos1='melodic'
		;;
	  3)
	  	versionRos1='noetic'
	  	;;
	  4)
	  	clear
	  	exit 0
	  	;;
	  *)
	  	echo -e "\n\n$red ERROR: $yellow Try again!!!\n\n $nc" && sleep 2
	  	clear
	  	exit 0
	  	;;
	esac

echo -e -n "$brown_orange Enter choice [1 - Dashing | 2 - Foxy | 3 - Exit ]: $nc"
read ros2
case $ros2 in 
	  1)
		versionRos2='dashing'
		;;
	  2)
		versionRos2='foxy'
		;;
	  3)
	  	clear
	  	exit 0
	  	;;
	  *)
	  	echo -e "\n\n$red ERROR: $yellow Try again!!!\n\n $nc" && sleep 2
	  	clear
	  	exit 0
	  	;;
	esac

#--------------------------------------------

ShowMenu() {
	clear
	printf "$light_blue-------------------------------------------------------------------------------"
	printf "\n\n$cyan Welcome Ros Installer $nc "
	printf "\n\n$light_green ROS Installer & Dependency $nc "
	printf "\n$yellow ROS 1 ${versionRos1^} & ROS 2 ${versionRos2^} $nc \n\n"
	printf "$light_blue--------------------------------------------------------------------------------"
	printf "\n\n$white 1 - ROS 1 Complete\n 2 - ROS 2 Complete\n 3 - System Tools\n 4 - Google Chrome\n 5 - Exit $nc\n\n"
}

ReadMenu(){	
	ShowMenu
	echo -e -n "$brown_orange Enter choice [1 - 5]: $nc"
	read choice

	case $choice in
		
		1)
			echo -e "\n\n$light_gray 1 - Install ROS ${versionRos1^}\n 2 - Remove ROS ${versionRos1^}\n 3 - Exit\n $nc"
			echo -e -n "$brown_orange Enter choice [1 - 3]: $nc"
			read input
			if [ $input -eq 1 ]; then
				InstallRos
				sleep 1				
			elif [ $input -eq 2 ]; then
				RemoveRos
				sleep 1				
			else
				echo -e "\n$yellow Returning to Principal Menu!!!\n\n $nc" && sleep 2
				clear
				return 0
			fi
			;;
		2)
			echo -e "\n\n$light_gray 1 - Install ROS 2 ${versionRos2^}\n 2 - Remove ROS 2 ${versionRos2^}\n 3 - Exit\n $nc"
			echo -e -n "$brown_orange Enter choice [1 - 3]: $nc"
			read input
			if [ $input -eq 1 ]; then
				InstallRos2
				sleep 1				
			elif [ $input -eq 2 ]; then
				RemoveRos2
				sleep 1
			else
				echo -e "\n$yellow Returning to Principal Menu!!!\n\n $nc" && sleep 2
				clear
				return 0
			fi
			;;
		3)
			SystemTools
			sleep 1
			;;
		4)
			Chrome
			sleep 1
			;;
		5)
			clear
			exit 0
			;;
		*)
			echo -e "\n\n$red ERROR: $yellow Invalid Option, Try again!!!\n\n $nc" && sleep 2
	esac
}

SystemTools() {
	echo -e "\n$light_gray 1 - System Update\n 2 - Repair DPKG Installer\n 3 - Fix Broken and Update\n 4 - Multiarch Support\n 5 - Exit\n $nc"
	echo -e -n "$brown_orange Enter choice [1 - 5]: $nc"
	read ch
	case $ch in 
	1)
		echo -e "$yellow System Update\n\n $nc"
		sudo apt update
		sudo apt full-upgrade -y
		sudo apt autoremove --purge
		sleep 2
		;;
	2)
		echo -e "$yellow Repair DPKG Installer \n\n$nc"
		sudo apt clean
		sudo apt install -f
		sudo dpkg --configure -a
		sudo apt update
		sleep 2
		;;
	3)
		echo -e "$yellow Fix Broken and Update \n\n$nc"
		sudo apt --fix-broken install
		sudo apt update
		sudo apt full-upgrade
		sleep 2
		;;
	4)
		echo -e "$yellow Multiarch Support \n\n$nc"
		cd ~/Downloads/
		wget http://archive.ubuntu.com/ubuntu/pool/main/g/glibc/multiarch-support_2.27-3ubuntu1.3_amd64.deb
		sudo apt-get install ./multiarch-support_2.27-3ubuntu1.3_amd64.deb
		sudo apt-get install libroscpp-dev -y
		sleep 2
		;;
	5)
		echo -e "\n$yellow Returning to Principal Menu!!!\n\n $nc" && sleep 2
		return 0
		;;
	*)
		echo -e "$red ERROR: $yellow Invalid Option, Try again!!!\n\n $nc" && sleep 1
	esac
		
}

InstallRos(){
	echo -e "\n$yellow Installing Ros ${versionRos1^} Desktop Full\n\n $nc"
	sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
	sudo apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
	curl -sSL 'http://keyserver.ubuntu.com/pks/lookup?op=get&search=0xC1CF6E31E6BADE8868B172B4F42ED6FBAB17C654' | sudo apt-key add -
	sudo apt update
	sudo apt install ros-$versionRos1-desktop-full -y
	sudo apt install python3-rosdep
	source /opt/ros/$versionRos1/setup.bash
	sudo apt install ros-$versionRos1-slam-gmapping -y
	sudo apt-get install ros-$versionRos1-gazebo-ros-pkgs ros-$versionRos1-gazebo-ros-control ros-$versionRos1-ros-control ros-$versionRos1-ros-controllers ros-$versionRos1-smach ros-$versionRos1-smach-ros ros-$versionRos1-executive-smach ros-$versionRos1-smach-viewer -y
	echo alias initros1="'source /opt/ros/$versionRos1/setup.bash'" >> ~/.bashrc
	source ~/.bashrc
	sleep 3		
}

RemoveRos(){
	printf '\n\n'
	echo -e "$yellow Removing ROS ${versionRos1^}\n\n $nc"
	sudo apt-get remove ros-$versionRos1-* -y
	sudo apt autoremove -y
	sleep 2
}

InstallRos2(){
	echo -e "\n$yellow Installing ROS 2 ${versionRos2^}\n\n $nc"
	sudo apt update && sudo apt install gnupg2 lsb-release terminator deepin-terminal -y
	curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -
	sudo sh -c 'echo "deb [arch=$(dpkg --print-architecture)] http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" > /etc/apt/sources.list.d/ros2-latest.list'
	sudo apt update
	sudo apt install ros-$versionRos2-desktop -y
	source /opt/ros/$versionRos2/setup.bash
	sudo apt install -y python3-pip -y
	pip3 install -U argcomplete
	sudo apt install ros-$versionRos2-ros1-bridge libroscpp-dev -y
	sudo apt install python3-colcon-common-extensions -y
	echo alias initros2="'source /opt/ros/$versionRos2/setup.bash'" >> ~/.bashrc
	source ~/.bashrc
	sleep 2
}

RemoveRos2(){
	echo -e "$yellow Removing ROS 2 ${versionRos2^}\n\n $nc"
	sudo apt-get remove ros-$versionRos2-* gnupg2 lsb-release terminator deepin-terminal libroscpp-dev -y && sudo apt autoremove -y
	sudo apt remove python3-colcon-common-extensions -y
	pip3 uninstall argcomplete -y
	sudo apt autoremove -y
	sleep 2
}

Chrome(){
	echo -e "\n$yellow Google Chrome \n\n$nc"
	echo -e "$light_gray 1 - Install Chrome\n 2 - Remove Chrome\n 3 - Exit\n $nc"
	echo -e -n "$brown_orange Enter choice [1 - 3]: $nc"
	read ch
	case $ch in 
		1)
			echo -e "\n$yellow Installing Chrome\n\n $nc"
			cd /home/$USER/Downloads/
			wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
			sudo apt install ./google-chrome-stable_current_amd64.deb -y
			sleep 2
			;;
		2)	
			echo -e "$yellow Removing Chrome\n\n $nc"
			sudo apt remove google-chrome-stable -y
			sleep 2
			;;
		3)
			return 0
			;;
		*)
			echo -e "\n\n$red ERROR: $yellow Invalid Option, Try again!!!\n\n $nc" && sleep 2
	esac

}

# ----------------------------------------------
# Step #3: Trap CTRL+C, CTRL+Z and quit singles
# ----------------------------------------------


while true
do
	trap '' SIGINT SIGQUIT SIGTSTP
	ReadMenu
done
