#!/bin/bash

#editor="nano --nowrap --constantshow --autoindent"

function help(){
	echo -e "help \t\t\t\t\t displays this help info"
	echo -e "remove [thing] \t\t\t\t\t same as rm -frv [thing]"
	echo -e "PackageInstall [package] \t\t install [package]"
	echo -e "PackageUninstall [package] \t\t uninstall [package]"
	echo -e "PackageUpdate [package] \t\t update [package]"
	echo -e "PackageDBCheck \t\t\t\t updates database"
	echo -e "PackageListRepositories \t\t list repositories"
	echo -e "PackageListPackages \t\t\t list packages that are installed"
	echo -e "PackageSearch [package] \t\t search for [package] in repositories"
	echo -e "PackageInfo [package] \t\t\t gets information on [package]"
	echo -e "PackageClean \t\t\t\t cleans up"
	echo -e "PackageSystemUpdate \t\t\t performs a full system update"
	echo -e "ServiceStart [service] \t\t\t starts [service]"
	echo -e "ServiceRestart [service] \t\t restarts [service]"
	echo -e "ServiceStop [service] \t\t\t stop [service]"
	echo -e "ServiceEnable [service] \t\t enables [service]"
	echo -e "ServiceDisable [service] \t\t disables [service]"
	echo -e "ServiceStatus [service] \t\t gets the status of [service]"
	echo -e "NewCPP [name] \t\t\t\t makes a new cpp directory using make called [name]"
	echo -e "ServiceStartups \t\t\t gets all services that would start on startup"
	echo -e "get * \n\t sync overwrite local files with remote files \n\t push pushes changes to remote \n\t clone does what it normaly does"
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

function PackageInstall(){
	if type "emerge" &> /dev/null; then 
		sudo emerge "$*"
	fi
	if type "pacman" &> /dev/null; then
		sudo pacman -S "$*"
	fi
	if type "apt-get" &> /dev/null; then
		sudo apt-get install "$*"
	fi
	if type "zypper" &> /dev/null; then
		sudo zypper install "$*"
	fi
	if type "dnf" &> /dev/null; then
		sudo dnf install "$*"
	fi
	if type "yum" &> /dev/null; then
		sudo yum install "&*"
	fi
}
function PackageUninstall(){
	if type "emerge" &> /dev/null; then
		sudo emerge --unmerge "$*"
	fi
	if type "pacman" &> /dev/null; then
		sudo pacman -Rsc "$*"
	fi
	if type "apt-get" &> /dev/null; then
		sudo apt-get remove "$*"
	fi
	if type "zypper" &> /dev/null; then
		sudo zypper remove "$*"
	fi
	if type "dnf" &> /dev/null; then
		sudo dnf remove "$*"
	fi
	if type "yum" &> /dev/null; then
		sudo yum remove "&*"
	fi
}
function PackageUpdate(){
	if type "emerge" &> /dev/null; then
		sudo emerge --update --deep "$*"
	fi
	if type "pacman" &> /dev/null; then
		sudo pacman -Syu "$*"
	fi
	if type "apt-get" &> /dev/null; then
		sudo apt-get install --only-upgrade"$*"
	fi
	if type "zypper" &> /dev/null; then
		sudo zypper update "$*"
	fi
	if type "dnf" &> /dev/null; then
		sudo dnf update "$*"
	fi
	if type "yum" &> /dev/null; then
		sudo yum update "&*"
	fi
}
function PackageDBCheck(){
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
function PackageListRepositories(){
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
}
function PackageListPackages(){
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
}
function PackageSearch(){
	if type "emerge" &> /dev/null; then
		emerge --search "$*"
	fi
	if type "pacman" &> /dev/null; then
		pacman -Ss "$*"
	fi
	if type "apt-get" &> /dev/null; then
		apt-cache search "$*"
	fi
	if type "zypper" &> /dev/null; then
		zypper search "$*"
	fi
	if type "dnf" &> /dev/null; then
		dnf search "$*"
	fi
	if type "yum" &> /dev/null; then
		yum search "$*"
	fi
}
function PackageInfo(){
	if type "emerge" &> /dev/null; then
		emerge --info "$*"
	fi
	if type "pacman" &> /dev/null; then
		pacman -Si "$*"
	fi
	if type "apt-get" &> /dev/null; then
		apt-cache show "$*"
	fi
	if type "zypper" &> /dev/null; then
		zypper info"$*"
	fi
	if type "dnf" &> /dev/null; then
		dnf info "$*"
	fi
	if type "yum" &> /dev/null; then
		yum info "$*"
	fi
}
function PackageClean(){
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
}
function PackageSystemUpdate(){
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
}

function ServiceStart(){
	if type "systemctl" &> /dev/null; then
		sudo systemctl start "$*"
	fi
	if type "rc-service" &> /dev/null; then
		sudo rc-service "$*"  start
	fi
}
function ServiceStop(){
	if type "systemctl" &> /dev/null; then
		sudo systemctl stop "$*"
	fi
	if type "rc-service" &> /dev/null; then
		sudo rc-service "$*"  stop
	fi
}
function ServiceRestart(){
	if type "systemctl" &> /dev/null; then
		sudo systemctl restart "$*"
	fi
	if type "rc-service" &> /dev/null; then
		sudo rc-service "$*"  restart
	fi
}
function ServiceStatus(){
	if type "systemctl" &> /dev/null; then
		sudo systemctl status "$*"
	fi
	if type "rc-service" &> /dev/null; then
		sudo rc-service "$*"  status
	fi
}
function ServiceStartups(){
	if type "systemctl" &> /dev/null; then
		systemctl list-unit-files --type=service
	fi
	if type "rc-service" &> /dev/null; then
		rc-update -v show
	fi
}
function ServiceEnable(){
	if type "systemctl" &> /dev/null; then
		 sudo systemctl enable "$*" 
	fi
	if type "rc-service" &> /dev/null; then
		runlevel="default"
		read -p "runlevel(default):" runlevel
		sudo rc-update add "$*"  "$runlevel"
	fi
}
function ServiceDisable(){
	if type "systemctl" &> /dev/null; then
		 sudo systemctl disable "$*" 
	fi
	if type "rc-service" &> /dev/null; then
		runlevel="default"
		read -p "runlevel(default):" runlevel
		sudo rc-update del "$*"  "$runlevel"
	fi
}
function remove(){
	rm -frv "$*"
}

function NewCPP(){
		mkdir `pwd`"/$*"
		cd `pwd`"/$*"
		mkdir `pwd`"/src"
		echo '#include <iostream>'>>`pwd`"/src/Main.cpp"
		echo 'int main(){'>>`pwd`"/src/Main.cpp"
		echo 'std::cout << "Hello World" << std::endl;'>>`pwd`"/src/Main.cpp"
		echo 'return 0;}'>>`pwd`"/src/Main.cpp"
		echo '#!/bin/bash'>>`pwd`"/build.sh"
		echo 'cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Debug'>>`pwd`"/build.sh"
		chmod +x `pwd`"/build.sh"
		echo 'cmake_minimum_required (VERSION 3.5)' >> `pwd`"/CMakeLists.txt"
		echo "project ($*)" >> `pwd`"/CMakeLists.txt"
		echo 'set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -Werror -std=c++14")' >> `pwd`"/CMakeLists.txt"
		echo 'set (source_dir "${PROJECT_SOURCE_DIR}/src/")' >> `pwd`"/CMakeLists.txt"
		echo 'file (GLOB source_files "${source_dir}/*.cpp")' >> `pwd`"/CMakeLists.txt"
		echo "add_executable ($*"' ${source_files})' >> `pwd`"/CMakeLists.txt"
		`pwd`"/./build.sh"
}

cd `pwd`
$*
