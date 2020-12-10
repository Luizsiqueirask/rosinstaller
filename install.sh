#!/bin/bash

# Author : Luiz Siqueira
# Copyright (c) Instituto Infnet
# This script was developed to assist in the installation. To the students of the Institute Infnet .
# ROS 1 && 2, Gazebo, virtualBox, Chrome Installer and Uninstaller.
# Version 1.6.3

#-------------- All Color -----------------

black='\e[0;30m'	dark_gray='\e[1;30m'		red='\e[0;31m' 		light_red='\e[1;31m'
green='\e[0;32m' 	light_green='\e[1;32m'		brown_orange='\e[0;33m'	yellow='\e[1;33m'
blue='\e[0;34m' 	light_blue='\e[1;34m'		purple='\e[0;35m' 		light_purple='\e[1;35m'
cyan='\e[0;36m'	light_cyan='\e[1;36m'		light_gray='\e[0;37m'		white='\e[1;37m'
nc='\e[0m'

#--------------------------------------------


ShowMenu() {
	clear
	printf '\n\n'
	echo -e ============================ $cyan Welcome Ros Installer $nc ============================
	printf '\n'
	printf "================== $light_purple ROS 1 and 2 Virtualbox Chrome Installer $nc ===================="
	printf '\n\n'
	printf "$white 1 - System Tools\n 2 - Install ROS Complete\n 3 - Remove ROS Complete\n 4 - Install ROS 2 Complete\n 5 - Remove ROS 2 Complete\n 6 - Install Google Chrome\n 7 - Exit$nc\n\n"
}

ReadMenu(){	
	echo -e "$brown_orange Enter choice [1 - 7]: $nc"
	read choice 

	case $choice in
		1)
			SystemTools
			sleep 3
			;;
		2)
			InstallRos
			sleep 3
			;;
		3)
			RemoveRos
			sleep 3
			;;
		4)
			InstallRos2
			sleep 3
			;;
		5)
			RemoveRos2
			sleep 3
			;;
		6)
			Chrome
			sleep 3
			;;
		7)
			clear
			exit 0
			;;
		*)
			echo -e "$red ERROR: $yellow Invalid Option, Try again!!!\n\n $nc" && sleep 2
	esac
}

SystemTools() {
	printf '\n'
	echo -e "$light_gray 1 - System Update\n 2 - Repair DPKG Installer\n 3 - Fix Broken and Update\n 4 - Multiarch Support\n 5 - Exit\n $nc"
	read ch
	case $ch in 
	1)
		echo -e "$yellow System Update\n\n $nc"
		sudo apt update
		sudo apt full-upgrade -y
		sudo apt autoremove
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
		return 0
		sleep 0
		;;
	*)
		echo -e "$red ERROR: $yellow Invalid Option, Try again!!!\n\n $nc" && sleep 1
	esac
		
}

InstallRos(){
	printf '\n\n'
	echo -e "$yellow Install ROS NOETIC\n\n $nc"
	sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
	sudo apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
	curl -sSL 'http://keyserver.ubuntu.com/pks/lookup?op=get&search=0xC1CF6E31E6BADE8868B172B4F42ED6FBAB17C654' | sudo apt-key add -
	sudo apt update

	printf '\n'
	echo -e "$light_gray 1 - Ros Noetic Desktop Full\n 2 - Ros Noetic Desktop\n 3 - Ros Noetic Base\n 4 - Ros Noetic Core\n 5 - Exit\n $nc"
	read pkg

	case $pkg in
		1)
			echo -e "$yellow Ros Noetic Desktop Full\n\n $nc"
			sudo apt install ros-noetic-desktop-full -y
			source /opt/ros/noetic/setup.bash
			sudo apt install ros-noetic-slam-gmapping -y
			sudo apt-get install ros-noetic-gazebo-ros-pkgs ros-noetic-gazebo-ros-control ros-noetic-ros-control ros-noetic-ros-controllers ros-noetic-smach ros-noetic-smach-ros
ros-noetic-executive-smach ros-noetic-smach-viewer -y
			echo alias initros1="'source /opt/ros/noetic/setup.bash'" >> ~/.bashrc
			source ~/.bashrc
			sleep 3
			;;
		2)
			echo -e "$yellow Ros Noetic Desktop\n\n $nc"
			sudo apt install ros-noetic-desktop -y
			source /opt/ros/noetic/setup.bash
			sudo apt install ros-noetic-slam-gmapping -y
			sudo apt-get install ros-noetic-gazebo-ros-pkgs ros-noetic-gazebo-ros-control ros-noetic-ros-control ros-noetic-ros-controllers ros-noetic-smach ros-noetic-smach-ros
ros-noetic-executive-smach ros-noetic-smach-viewer -y
			echo alias initros1="'source /opt/ros/noetic/setup.bash'" >> ~/.bashrc
			source ~/.bashrc
			sleep 3
			;;
		3)
			echo -e "$yellow Ros Noetic Base\n\n $nc"
			sudo apt install ros-noetic-base -y
			source /opt/ros/noetic/setup.bash
			sudo apt install ros-noetic-slam-gmapping -y
			sudo apt-get install ros-noetic-gazebo-ros-pkgs ros-noetic-gazebo-ros-control ros-noetic-ros-control ros-noetic-ros-controllers ros-noetic-smach ros-noetic-smach-ros
ros-noetic-executive-smach ros-noetic-smach-viewer -y
			echo alias initros1="'source /opt/ros/noetic/setup.bash'" >> ~/.bashrc
			source ~/.bashrc
			sleep 3
			;;
		4)
			echo -e "$yellow Ros Noetic Core\n\n $nc"
			sudo apt install ros-noetic-core -y
			source /opt/ros/noetic/setup.bash
			sudo apt install ros-noetic-slam-gmapping -y
			sudo apt-get install ros-noetic-gazebo-ros-pkgs ros-noetic-gazebo-ros-control ros-noetic-ros-control ros-noetic-ros-controllers ros-noetic-smach ros-noetic-smach-ros
ros-noetic-executive-smach ros-noetic-smach-viewer -y
			echo alias initros1="'source /opt/ros/noetic/setup.bash'" >> ~/.bashrc
			source ~/.bashrc
			sleep 3
			;;
		5)
			return 0
			;;
		*)
			echo -e "$red ERROR: $yellow Invalid Option, Try again!!!\n\n $nc" && sleep 2
			;;
	esac
}

RemoveRos(){
	printf '\n\n'
	echo -e "$yellow Remove ROS NOETIC\n\n $nc"
	sudo apt-get remove ros-noetic-* -y
	sudo apt autoremove -y
	sleep 2
}

InstallRos2(){
	printf '\n\n'
	echo -e "$yellow Install ROS 2 Foxy\n\n $nc"

	echo -e "$yellow Setup Sources\n\n $nc"
	sudo apt update && sudo apt install gnupg2 lsb-release terminator deepin-terminal -y
	curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -
	sudo sh -c 'echo "deb [arch=$(dpkg --print-architecture)] http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" > /etc/apt/sources.list.d/ros2-latest.list'

	echo -e "$yellow Install ROS 2 packages\n\n $nc"
	sudo apt update

	printf '\n'
	echo -e "$light_gray 1 - Ros Foxy Desktop \n 2 - Ros Foxy Base\n 3 - Exit\n $nc"
	read pkg

	case $pkg in
		1)
			echo -e "$yellow Install ROS 2 Foxy Desktop\n\n $nc"
			sudo apt install ros-foxy-desktop -y
			source /opt/ros/foxy/setup.bash
			sudo apt install -y python3-pip -y
			pip3 install -U argcomplete
			sudo apt install ros-foxy-ros1-bridge libroscpp-dev -y
			sudo apt install python3-colcon-common-extensions -y
			echo alias initros2="'source /opt/ros/foxy/setup.bash'" >> ~/.bashrc
			source ~/.bashrc
			sleep 2
			;;
		2)
			echo -e "$yellow Install ROS 2 Foxy Base\n\n $nc"
			sudo apt install ros-foxy-ros-base -y
			source /opt/ros/foxy/setup.bash
			sudo apt install -y python3-pip -y
			pip3 install -U argcomplete
			sudo apt install ros-foxy-ros1-bridge libroscpp-dev -y
			sudo apt install python3-colcon-common-extensions -y
			echo alias initros2="'source /opt/ros/foxy/setup.bash'" >> ~/.bashrc
			source ~/.bashrc
			sleep 2
			;;
		3)
			return 0
			;;
		*)
			echo -e "$red ERROR: $yellow Invalid Option, Try again!!!\n\n $nc" && sleep 2
	esac

}

RemoveRos2(){
	echo -e "$yellow Remove ROS 2 Foxy\n\n $nc"
	sudo apt-get remove ros-foxy-* gnupg2 lsb-release terminator deepin-terminal libroscpp-dev -y && sudo apt autoremove -y
	sudo apt remove python3-colcon-common-extensions -y
	pip3 uninstall argcomplete -y
	sudo apt autoremove -y
	sleep 2
}

Chrome(){
	echo -e "$yellow Install & Remove Google Chrome \n\n$nc"
	echo -e "$light_gray 1 - Install Chrome\n 2 - Remove Chrome\n 3 - Exit\n $nc"
	read ch
	case $ch in 
		1)
			echo -e "$yellow Install Chrome\n\n $nc"
			cd /home/$USER/Downloads/
			wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
			sudo apt install ./google-chrome-stable_current_amd64.deb -y
			sleep 2
			;;
		2)	
			echo -e "$yellow Remove Chrome\n\n $nc"
			sudo apt remove google-chrome-stable -y
			sleep 2
			;;
		3)
			return 0
			;;
		*)
			echo -e "$red ERROR: $yellow Invalid Option, Try again!!!\n\n $nc" && sleep 2
	esac

}

# ----------------------------------------------
# Step #3: Trap CTRL+C, CTRL+Z and quit singles
# ----------------------------------------------
trap '' SIGINT SIGQUIT SIGTSTP
 
# -------------------------------------
# Step #4: Main logic - infinite loop
# -------------------------------------

while true
do
	ShowMenu
	ReadMenu
done
