#!/bin/bash

##settings
editor="nano --nowrap --constantshow --autoindent"

##enviroment variables
PIP=`wget http://ipecho.net/plain -O - -q ; echo`

if [ "$init_check" != "1" ];then 
	if type "systemctl" &> /dev/null; then
		ServiceStart="systemctl start"
		ServiceStop="systemctl stop"
		ServiceRestart="systemctl restart"
		ServiceEnable="systemctl enable"
		ServiceDisable="systemctl disable"
		export init_check="1"
	fi
fi

if [ "$package_check" != "1" ];then 
	if type "emerge" &> /dev/null; then 
 		export PackageInstall='emerge'
        	export PackageUninstall='emerge --unmerge'
        	export PackageUpdate='emerge --update --deep'
        	export PackageDBCheck='emerge --sync'
        	export PackageListRepositories='ls /etc/portage/repos.conf/'
        	export PackageListPackages='pacman -Q | more'
        	export PackageSearch='emerge --search'
        	export PackageInfo='emerge --info'
        	export PackageCleanCache='emerge --clean'
        	export PackageSystemUpdate='emerge --update --deep @world'
        	export package_check="1"
	fi
	if type "pacman" &> /dev/null; then 
		export PackageInstall='pacman -S'
		export PackageUninstall='pacman -Rsc'
		export PackageUpdate='pacman -Syu'
		export PackageDBCheck='pacman -Syy'
		export PackageListRepositories='cat /etc/pacman.d/mirrorlist | more'
		export PackageListPackages='pacman -Q | more'
		export PackageSearch='pacman -Ss'
		export PackageInfo='pacman -Si'
		export PackageCleanCache='pacman -Sc'
		export PackageSystemUpdate='pacman -Syyu'
		export package_check="1"
	fi
	if type "apt-get" &> /dev/null; then 
		export PackageInstall='apt-get install'
		export PackageUninstall='apt-get remove'
		export PackageUpdate='apt-get install --only-upgrade'
		export PackageDBCheck='apt-get update'
		export PackageListRepositories='echo command undefined'
		export PackageListPackages='echo command undefined'
		export PackageSearch='apt-cache search'
		export PackageInfo='apt-cache show'
		export PackageCleanCache='apt-get autoclean'
		export PackageSystemUpdate='sudo apt-get dist-upgrade'
		export package_check="1"
	fi
	if type "zypper" &> /dev/null; then 
		export PackageInstall='zypper install'
		export PackageUninstall='zypper remove'
		export PackageUpdate='zypper update'
		export PackageDBCheck='zypper refresh'
		export PackageListRepositories='zypper repos'
		export PackageListPackages='zypper packages'
		export PackageSearch='zypper search'
		export PackageInfo='zypper info'
		export PackageCleanCache='zypper clean --all'
		export PackageSystemUpdate='zypper update'
		export package_check="1"
	fi
	if type "dnf" &> /dev/null; then 
		export PackageInstall='dnf install'
		export PackageUninstall='dnf remove'
		export PackageUpdate='dnf update'
		export PackageDBCheck='dnf check-update'
		export PackageListRepositories='dnf repolist'
		export PackageListPackages='dnf list installed'
		export PackageSearch='dnf search'
		export PackageInfo='dnf info'
		export PackageCleanCache=''
		export PackageSystemUpdate='dnf update && dnf upgrade'
		export package_check="1"
	fi
	if type "yum" &> /dev/null; then 
		export PackageInstall='yum install'
		export PackageUninstall='yum remove'
		export PackageUpdate='yum update'
		export PackageDBCheck='yum check-update'
		export PackageListRepositories='yum repolist'
		export PackageListPackages='yum list'
		export PackageSearch='yum search'
		export PackageInfo='yum info'
		export PackageCleanCache='yum clean all'
		export PackageSystemUpdate='yum update'
		export package_check="1"
	fi
fi

##commands below
if [ "$1" == "test" ];then
	if [ "$2" == "pwd" ];then
		pwd
	fi
fi

#PackageInstall
if [ "$1" == "install" ];then
	sudo $PackageInstall "$2"
fi

#PackageUninstall
if [ "$1" == "uninstall" ];then
	sudo $PackageUninstall "$2"
fi

#PackageUpdate
#PackageSystemUpdate
#PackageDBCheck
if [ "$1" == "update" ];then
	if [ "$2" == "package" ];then
		sudo $PackageUpdate "$3"
	fi
	if [ "$2" == "system" ];then
		sudo $PackageSystemUpdate
	fi
	if [ "$2" == "repositories" ];then
		sudo $PackageDBCheck
	fi
fi

#PackageListRepositories
#PackageListPackages
if [ "$1" == "list" ];then
	if [ "$2" == "repositories" ];then
		$PackageListRepositories
	fi
	if [ "$2" == "packages" ];then
		$PackageListPackages
	fi
fi

#PackageSearch
if [ "$1" == "search" ];then
	$PackageSearch "$2"
fi

#PackageInfo
if [ "$1" == "info" ];then
	$PackageInfo "$2"
fi

#PackageCleanCache
if [ "$1" == "cleanup" ];then
	$PackageCleanCache
fi

if [ "$1" == "make" ];then
	if [ "$2" == "new" ];then
		mkdir `pwd`"/$3"
		cd `pwd`"/$3"
		mkdir `pwd`"/src"
		echo '#include <iostream>'>>`pwd`"/src/Main.cpp"
		echo 'int main(){'>>`pwd`"/src/Main.cpp"
		echo 'std::cout << "Hello World" << std::endl;'>>`pwd`"/src/Main.cpp"
		echo 'return 0;}'>>`pwd`"/src/Main.cpp"
		echo '#!/bin/bash'>>`pwd`"/build.sh"
		echo 'cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Debug'>>`pwd`"/build.sh"
		chmod +x `pwd`"/build.sh"
		echo 'cmake_minimum_required (VERSION 3.5)' >> `pwd`"/CMakeLists.txt"
		echo "project ($3)" >> `pwd`"/CMakeLists.txt"
		echo 'set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -Werror -std=c++14")' >> `pwd`"/CMakeLists.txt"
		echo 'set (source_dir "${PROJECT_SOURCE_DIR}/src/")' >> `pwd`"/CMakeLists.txt"
		echo 'file (GLOB source_files "${source_dir}/*.cpp")' >> `pwd`"/CMakeLists.txt"
		echo "add_executable ($3"' ${source_files})' >> `pwd`"/CMakeLists.txt"
		`pwd`"/./build.sh"		
	fi
fi

if [ "$1" == "remove" ];then
	rm -frv `pwd`"/$2"
fi

if [ "$1" == "edit" ];then
	if [ "$2" == "self" ]
	then
		$editor ~/.local/bin/i
	else
		$editor `pwd`"/$2"
	fi
fi

if [ "$1" == "start" ];then
	if [ "$2" == "kde" ];then
		export command="startkde"
		startx
	fi
	if [ "$2" == "i3" ];then
		export command='i3'
		startx
	fi
	if [ "$2" == "ipfs" ];then
		ipfs daemon
	fi
fi

if [ "$1" == "ip" ];then
	echo "public : $PIP"
fi

if [ "$1" == "generate" ] ;then
	if [ "$2" == "random" ] ;then
		if [ "$3" == "number" ] ;then
			echo $((1 + RANDOM % $4))
		fi
	fi
fi

exit
if type "" > /dev/null; then 
		PackageInstall=''
		PackageUninstall=''
		PackageUpdate=''
		PackageDBCheck=''
		PackageListRepositories=''
		PackageListPackages=''
		PackageSearch=''
		PackageInfo=''
		PackageCleanCache=''
		PackageSystemUpdate=''
fi
