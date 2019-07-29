#!/bin/bash

export EDITOR='nano'

function UpdateI(){
	git add .
	git commit
	git push
}

function roll(){
	 let result=$1*$((1 + RANDOM % $3))
	 echo $result
}

function get(){
	if [ "$1"=="clone" ]; then
		git clone "$2"
	fi
	if [ "$1"=="pull" ]; then
		git pull
	fi
	if [ "$1" == "sync" ]; then
		git reset --hard
		git pull
	fi
	if [ "$1" == "push" ]; then
		git commit *
		git push
	fi
}

function check_db(){ 
	args=$(echo "$*" |grep -v "$1")
	if type "emerge" &> /dev/null; then
		sudo emerge --sync
	fi
	if type "pacman" &> /dev/null; then
		sudo pacman -Syy
	fi
	if type "apt-get" &> /dev/null; then
		sudo apt-get update
	fi
	if type "zypper" &> /dev/null; then
		sudo zypper refresh
	fi
	if type "dnf" &> /dev/null; then
		sudo dnf check-update
	fi
	if type "yum" &> /dev/null; then
		sudo yum check-update
	fi
}
function repository(){
	args=$(echo "$*" |grep -v "$1")
	if [ "$1" == "list" ];then
		if type "emerge" &> /dev/null; then
			ls /etc/portage/repos.conf/
		fi
		if type "pacman" &> /dev/null; then
			cat /etc/pacman.d/mirrorlist | more
		fi
		if type "apt-get" &> /dev/null; then
			echo command undefined
		fi
		if type "zypper" &> /dev/null; then
			zypper repos
		fi
		if type "dnf" &> /dev/null; then
			dnf repolist
		fi
		if type "yum" &> /dev/null; then
			yum repolist
		fi
	fi
}

function package(){
	args=$(echo "$*" |grep -v "$1")
	if [ "$1" == "install" ];then
		if type "emerge" &> /dev/null; then 
			sudo emerge "$args"
		fi
		if type "pacman" &> /dev/null; then
			sudo pacman -S "$args"
		fi
		if type "apt-get" &> /dev/null; then
			sudo apt-get install "$args"
		fi
		if type "zypper" &> /dev/null; then
			sudo zypper install "$args"
		fi
		if type "dnf" &> /dev/null; then
			sudo dnf install "$args"
		fi
		if type "yum" &> /dev/null; then
			sudo yum install "&args"
		fi
	fi
	if [ "$1" == "uninstall" ];then
		if type "emerge" &> /dev/null; then
			sudo emerge --unmerge "$args"
		fi
		if type "pacman" &> /dev/null; then
			sudo pacman -Rsc "$args"
		fi
		if type "apt-get" &> /dev/null; then
			sudo apt-get remove "$args"
		fi
		if type "zypper" &> /dev/null; then
			sudo zypper remove "$args"
		fi
		if type "dnf" &> /dev/null; then
			sudo dnf remove "$args"
		fi
		if type "yum" &> /dev/null; then
			sudo yum remove "&args"
		fi
	fi
	if [ "$1" == "update" ];then
		if type "emerge" &> /dev/null; then
			sudo emerge --update --deep "$args"
		fi
		if type "pacman" &> /dev/null; then
			sudo pacman -Syu "$args"
		fi
		if type "apt-get" &> /dev/null; then
			sudo apt-get install --only-upgrade "$args"
		fi
		if type "zypper" &> /dev/null; then
			sudo zypper update "$args"
		fi
		if type "dnf" &> /dev/null; then
			sudo dnf update "$args"
		fi
		if type "yum" &> /dev/null; then
			sudo yum update "&args"
		fi
	fi
	if [ "$1" == "list" ];then
		if type "emerge" &> /dev/null; then
			echo command undefined
		fi
		if type "pacman" &> /dev/null; then
			pacman -Q | more
		fi
		if type "apt-get" &> /dev/null; then
			echo command undefined
		fi
		if type "zypper" &> /dev/null; then
			zypper packages
		fi
		if type "dnf" &> /dev/null; then
			dnf list installed
		fi
		if type "yum" &> /dev/null; then
			yum list
		fi
	fi
	if [ "$1" == "search" ];then
		if type "emerge" &> /dev/null; then
			emerge --search "$args"
		fi
		if type "pacman" &> /dev/null; then
			pacman -Ss "$args"
		fi
		if type "apt-get" &> /dev/null; then
			apt-cache search "$args"
		fi
		if type "zypper" &> /dev/null; then
			zypper search "$args"
		fi
		if type "dnf" &> /dev/null; then
			dnf search "$args"
		fi
		if type "yum" &> /dev/null; then
			yum search "$args"
		fi
	fi
	if [ "$1" == "info" ];then
		if type "emerge" &> /dev/null; then
			emerge --info "$args"
		fi
		if type "pacman" &> /dev/null; then
			pacman -Si "$args"
		fi
		if type "apt-get" &> /dev/null; then
			apt-cache show "$args"
		fi
		if type "zypper" &> /dev/null; then
			zypper info"$args"
		fi
		if type "dnf" &> /dev/null; then
			dnf info "$args"
		fi
		if type "yum" &> /dev/null; then
			yum info "$args"
		fi
	fi
	if [ "$1" == "cleanup" ];then
		if type "emerge" &> /dev/null; then
			sudo emerge --ask --clean --deep
			sudo emerge --ask --depclean
		fi
		if type "pacman" &> /dev/null; then
			sudo pacman -Sc
		fi
		if type "apt-get" &> /dev/null; then
			sudo apt-get autoclean
		fi
		if type "zypper" &> /dev/null; then
			sudo zypper clean --all
		fi
		if type "dnf" &> /dev/null; then
			sudo dnf clean all
		fi
		if type "yum" &> /dev/null; then
			sudo yum clean all
		fi
	fi
}

function system(){
	args=$(echo "$*" |grep -v "$1")
	if [ "$1" == "update" ];then
		if type "emerge" &> /dev/null; then
			sudo emerge --update --deep @world
		fi
		if type "pacman" &> /dev/null; then
			sudo pacman -Syyu
		fi
		if type "apt-get" &> /dev/null; then
			sudo apt-get dist-upgrade
		fi
		if type "zypper" &> /dev/null; then
			sudo zypper update
		fi
		if type "dnf" &> /dev/null; then
			sudo dnf update
			sudo dnf upgrade
		fi
		if type "yum" &> /dev/null; then
			sudo yum update
		fi
	fi
}

function start(){
	args=$(echo "$*" |grep -v "$1")
	if [ "$1" == "service" ];then
		if type "systemctl" &> /dev/null; then
			sudo systemctl start "$args"
		fi
		if type "rc-service" &> /dev/null; then
			sudo rc-service "$args"  start
		fi
	fi
}
function stop(){
	args=$(echo "$*" |grep -v "$1")
	if [ "$1" == "service" ];then
		if type "systemctl" &> /dev/null; then
			sudo systemctl stop "$args"
		fi
		if type "rc-service" &> /dev/null; then
			sudo rc-service "$args"  stop
		fi
	fi
}
function restart(){
	args=$(echo "$*" |grep -v "$1")
	if [ "$1" == "service" ];then
		if type "systemctl" &> /dev/null; then
			sudo systemctl restart "$args"
		fi
		if type "rc-service" &> /dev/null; then
			sudo rc-service "$args"  restart
		fi
	fi
}
function status(){
	if [ "$1" == "service" ];then
		if type "systemctl" &> /dev/null; then
			sudo systemctl status "$args"
		fi
		if type "rc-service" &> /dev/null; then
			sudo rc-service "$args"  status
		fi
	fi
}
function startups(){
	args=$(echo "$*" |grep -v "$1")
	if [ "$1" == "service" ];then
		if type "systemctl" &> /dev/null; then
			systemctl list-unit-files --type=service
		fi
		if type "rc-service" &> /dev/null; then
			rc-update -v show
		fi
	fi
}
function enable(){
	args=$(echo "$*" |grep -v "$1")
	if [ "$1" == "service" ];then
		if type "systemctl" &> /dev/null; then
			sudo systemctl enable "$args" 
		fi
		if type "rc-service" &> /dev/null; then
			runlevel="default"
			read -p "runlevel(default):" runlevel
			sudo rc-update add "$args"  "$runlevel"
		fi
	fi
}
function disable(){
	args=$(echo "$*" |grep -v "$1")
	if [ "$1" == "service" ];then
		if type "systemctl" &> /dev/null; then
			sudo systemctl disable "$args" 
		fi
		if type "rc-service" &> /dev/null; then
			runlevel="default"
			read -p "runlevel(default):" runlevel
			sudo rc-update del "$args"  "$runlevel"
		fi
	fi
}
function remove(){
	rm -frv "$*"
}

function new(){
	args=$(echo "$*" |grep -v "$1")
	if [ "$1" == "cpp" ];then
		if type "make" &> /dev/null; then
			mkdir `pwd`"/$args"
			cd `pwd`"/$args"
			mkdir `pwd`"/src"
			echo '#include <iostream>'>>`pwd`"/src/Main.cpp"
			echo 'int main(){'>>`pwd`"/src/Main.cpp"
			echo 'std::cout << "Hello World" << std::endl;'>>`pwd`"/src/Main.cpp"
			echo 'return 0;}'>>`pwd`"/src/Main.cpp"
			echo '#!/bin/bash'>>`pwd`"/build.sh"
			echo 'cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Debug'>>`pwd`"/build.sh"
			chmod +x `pwd`"/build.sh"
			echo 'cmake_minimum_required (VERSION 3.5)' >> `pwd`"/CMakeLists.txt"
			echo "project ($args)" >> `pwd`"/CMakeLists.txt"
			echo 'set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -Werror -std=c++14")' >> `pwd`"/CMakeLists.txt"
			echo 'set (source_dir "${PROJECT_SOURCE_DIR}/src/")' >> `pwd`"/CMakeLists.txt"
			echo 'file (GLOB source_files "${source_dir}/*.cpp")' >> `pwd`"/CMakeLists.txt"
			echo "add_executable ($args"' ${source_files})' >> `pwd`"/CMakeLists.txt"
			`pwd`"/./build.sh"
			else
			echo "you do not have make installed"
		fi
	fi
}

cd `pwd`
$*
