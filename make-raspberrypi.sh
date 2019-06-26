#!/bin/bash
#===========================================================================
# Copyright (C) 2016-2017 cdev-tux github.com/cdev-tux
#
# This file is part of Q3lite Source Code. https://github.com/cdev-tux/q3lite
#
# Q3lite Source Code is free software; you can redistribute it
# and/or modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation; either version 3 of the License,
# or (at your option) any later version.
#
# Q3lite Source Code is distributed in the hope that it will be
# useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Q3lite Source Code.  If not, see <http://www.gnu.org/licenses/>.
#
# In addition, Q3lite Source Code is also subject to certain additional terms.
# You should have received a copy of these additional terms immediately following
# the terms and conditions of the GNU General Public License.  If not, please
# request a copy in writing from id Software at the address below.
# If you have questions concerning this license or the applicable additional
# terms, you may contact in writing id Software LLC, c/o ZeniMax Media Inc.,
# Suite 120, Rockville, Maryland 20850 USA.
#===========================================================================

scriptname=$(basename "$0")

# Make sure we're running as root.
if [[ $(id -u) -ne 0 ]]; then
	echo "The $scriptname script must be run as root, retry using 'sudo bash $scriptname'."
	exit 1
fi

if [ -z "$1" ]; then
clear
fi

echo ""
cd $(dirname "$0")

# Make sure we're running from the Q3lite source code directory.
if [ ! -f Makefile.q3lite ]; then
	echo "The $scriptname script must be run from the Q3lite source code directory."
	exit 2
fi

# Set Variables
logged_in_user=$(who | grep -m 1 "." | awk '{print $1}')
if [ -z "$logged_in_user" ]; then
	q3l_user="pi"
else
	q3l_user="$logged_in_user"
fi
q3l_userhome=$(sudo -u $q3l_user -H -s eval 'echo $HOME')
if [ $(dirname "$0") = "." ]; then
	q3l_compile_path=$PWD
else
	q3l_compile_path=$(dirname "$0")
fi
inst_upd="no"
q3user="quake3"
q3l_homepath="$q3l_userhome/.q3a"
q3l_basepath="/usr/local/games/quake3"
q3l_dir_dir="$q3l_userhome/.local/share/desktop-directories"
q3l_menu_dir="$q3l_userhome/.config/menus"
q3l_app_dir="/usr/share/applications"
q3l_local_app_dir="$q3l_userhome/.local/share/applications"
q3l_bin_dir="/usr/local/bin"
q3l_img_dir="/usr/share/pixmaps"
q3l_systemd_dir="/lib/systemd/system"
q3l_src_home="misc/q3lite"
q3l_src_platform="misc/q3lite/pi"
q3l_src_sdl_path="code/libs/q3lite/pi"
q3l_lib_path="/usr/local/lib/q3lite"
q3l_pr_dir="/usr/local/share/quake3_point_release"
q3_pt_rel="linuxq3apoint-1.32b-3.x86.run"
sha256="c36132c5556b35e01950f1e9c646235033a5130f87ad776ba2bc7becf4f4f186"

#	ftp://ftp.idsoftware.com/idstuff/quake3/linux/$q3_pt_rel \         FTP server appears to be down.
url_list=( https://github.com/nrempel/q3-server/raw/master/$q3_pt_rel \
		http://ftp.gwdg.de/pub/misc/ftp.idsoftware.com/idstuff/quake3/linux/$q3_pt_rel \
		ftp://ftp.filearena.net/.pub1/gentoo/distfiles/$q3_pt_rel \
		ftp://ftp.gamers.org/pub/idgames/idstuff/quake3/linux/$q3_pt_rel)

# Functions
create_user () {
	if ! id "$q3user" > /dev/null 2>&1; then
		echo -e "Adding new user '$q3user'"
		useradd -M $q3user  2> /dev/null
		echo "quake3:raspberry" | chpasswd  2> /dev/null
		usermod -a -G dialout,cdrom,audio,video,plugdev,games,users,input,netdev,gpio,i2c,spi quake3
	else
		echo -e "The '$q3user' user already exists, skip adding new user."
	fi
}

update_paks () {
	while true
		do
			echo -e  "\e[01;37mUpdated pak files from the Q3A 1.32b Point Release are required for"
			echo -e  "use with Q3lite. The installer can download the pak files"
			echo -e  "for you (requires an internet connection). You'll need to agree to"
			echo -e  "the id Software EULA before the pak files can be installed.\e[0m"

			echo -e  "\e[01;37m"
			read -p "Do you want to download and install the updated pak files? [y/n]: " -ei "y" response
			echo -e  "\e[0m"

			case $response in
				[yY]* )
					whiptail --title "Id Software, Inc. EULA" \
							--yesno "$(cat $q3l_src_home/Q3A_navigate.txt $q3l_src_home/Q3A_EULA.txt)" \
							--scrolltext \
							--yes-button " I Agree " \
							--no-button " I Do Not Agree " \
							24 80
					if [ $? -eq 0 ]; then
						echo -e "\e[01;37mYou chose 'I Agree' to the id Software EULA.\n\e[0m"
						echo -e "\e[01;37mDownloading updated pak files...\n\e[0m"
						inst_upd="yes"
						dl_paks
					else
						echo -e "\e[01;37mYou chose 'I Do Not Agree' to the id Software EULA.\n\e[0m"
						echo -e "\e[01;37mUpdated pak files won't be installed.\n\e[0m"
						inst_upd="no"
					fi
				break;;

				[nN]* )
					echo -e "\n\e[01;37mUpdated pak files won't be installed.\n\e[0m"
				break;;

				* )
					echo -e "\n\e[01;37mEnter y or n please, or Ctrl+C to exit.\n\e[0m";;
			esac
		done
}

dl_paks () {
	if [ ! -f "$q3l_pr_dir/$q3_pt_rel" ]; then
		echo -e "Testing Internet connectivity...\n"
		wget -q --tries=10 --timeout=20 --spider http://google.com > /dev/null
		if [[ $? -eq 0 ]]; then
			echo -e "Internet connection found.\n"
			mkdir -p $q3l_pr_dir
			cd $q3l_pr_dir
			# Download the Point Release and verify file integrity.
			for url in ${url_list[@]};
				do
					echo -e "Downloading $q3_pt_rel from:\n\n$url\n"
					wget -q -t 3 --show-progress $url
					if [ $? -eq 0 ] && [ -f "$q3l_pr_dir/$q3_pt_rel" ]; then
						if [ "$sha256" = $(sha256sum linuxq3apoint-1.32b-3.x86.run | cut -d" " -f1) ]; then
							echo -e "\n\e[01;37mPoint Release sha256sum verified\n\e[0m"
							break
						else
							echo -e "\e[01;37mBad Point Release sha256sum, trying different URL.\n\e[0m"
						fi
					fi
					if [ -f "$q3l_pr_dir/$q3_pt_rel" ]; then
						rm -f "$q3l_pr_dir/$q3_pt_rel";
					fi
				done
				if [ -f "$q3l_pr_dir/$q3_pt_rel" ]; then
					echo -e "\e[01;37mDownload successful\n\e[0m"
			else
				echo -e "\e[01;33mPoint Release download failed.\e[0m"
				echo -e "\e[01;33mInstall the updated pak files manually.\n\e[0m"
			fi
		else
			echo -e "\e[01;33mInternet connection unavailable.\e[0m"
			echo -e "\e[01;33mInstall the updated pak files manually.\n\e[0m"
		fi
	else
		echo -e "\e[01;37mThe Point Release file already exists, using existing file.\n\e[0m"
	fi
	# Unpack the Point Release files.
	if [ -f "$q3l_pr_dir/$q3_pt_rel" ]; then
		echo -e "Unpacking Point Release files...\n"
		tail -c +8252 "$q3l_pr_dir/$q3_pt_rel" | tar xzvf - -C "$q3l_pr_dir" --wildcards "*.pk3" 2>&1 || \
			{  echo Unpacking Point Release failed > /dev/tty; kill -SIGTERM $$; }
		if [[ $? -eq 0 ]]; then
			echo -e "\nUnpacking Point Release files done\n"
		else
			echo -e "\nInstall the updated pak files manually.\n"
		fi
	fi
	cd $q3l_compile_path
}

# Main
# If we have write permissions to the Q3lite source code directory then proceed.
if [ -w $q3l_compile_path ]; then

	# Check for command line arguments.
	if [ -z "$1" ]; then
		target="clean release"
	else
		case $1 in
			install )
				if [ ! -d build ]; then
					echo -e "\e[01;37mThe build directory doesn't exist, compile Q3lite before installing.\n\e[0m"
					exit 3
				fi
				update_paks
				echo -e "\e[01;37mInstalling Q3lite files\n\e[0m"
				create_user
				target="q3lite_install";;

			uninstall )
				echo -e "\n\e[01;33m*** Uninstall Q3lite ***"
				echo -e "\nThis will remove your Q3lite game directory and files. The"
				echo -e "uninstaller will also remove the app menu icons and .desktop"
				echo -e "files. Your ~/.q3a home directory will not be removed since"
				echo -e "it may contain important files. You can manually delete the"
				echo -e "~/.q3a directory if you no longer need it\n."
				while true
					do
						read -p "Do you really want to uninstall Q3lite? [y/n]: " -ei "n" answer
						echo -e  "\e[0m"

						case $answer in
							[yY]* )
								echo -e "\n\e[01;33mUninstalling Q3lite\n\e[0m"
							target="q3lite_uninstall"
							break;;

							[nN]* )
								echo -e "\n\e[01;33mUninstall canceled\n\e[0m"
								exit 4;;

							* )
								echo -e "\nEnter y or n please, or Ctrl+C to exit.\n";;
						esac
					done;;

			* )
				echo -e "\e[01;33mArgument to $scriptname not understood.\n\e[0m"
				echo -e "\e[01;33mUsage: to compile Q3lite type: sudo bash $scriptname\e[0m"
				echo -e "\e[01;33m       to install Q3lite type: sudo bash $scriptname install\e[0m"
				echo -e "\e[01;33m       to uninstall Q3lite type: sudo bash $scriptname uninstall\n\e[0m"
				exit 5;;
		esac
	fi

	# Enable colorized text for compiler warning/error messages.
	export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

	# Determine which Pi model we're compiling on so we can set the proper compiler flags.
	if grep -i -q "^model name\s*:\s*ARMv" /proc/cpuinfo; then
		while true
		do
			# Check if we're running on a Pi 3, 3A+ or 3B+.
			if grep -i -q "^Revision\s*:\s*[ 123]a[0-9a-f]20[0-9a-f][0-9a-f]$" /proc/cpuinfo || \
			   grep -i -q "^Revision\s*:\s*[ 123][0-9a-f][0-9a-f][0-9a-f][0-9a-f]e[0-9a-f]$" /proc/cpuinfo; then
				if [ -z "$1" ]; then
					echo -e "\e[01;37mCompiling Q3lite on a Pi 3, 3A+ or 3B+\n\e[0m"
				fi
				ptype="raspberrypi3"
				break
			fi
			# Check if we're running on a Pi 2.
			if grep -i -q "^Revision\s*:\s*[ 123][0-9a-f][0-9a-f][0-9a-f]04[0-9a-f]$" /proc/cpuinfo; then
				if [ -z "$1" ]; then
					echo -e "\e[01;37mCompiling Q3lite on a Pi 2\n\e[0m"
				fi
				ptype="raspberrypi2"
				break
			fi
			# Check if we're running on a Pi 1.
			if grep -i -q "^Revision\s*:\s*00[0-9a-f][0-9a-f]$" /proc/cpuinfo || \
			   grep -i -q "^Revision\s*:\s*[ 123][0-9a-f][0-9a-f][0-9a-f]0[0-36][0-9a-f]$" /proc/cpuinfo; then
				if [ -z "$1" ]; then
					echo -e "\e[01;37mCompiling Q3lite on a Pi 1\n\e[0m"
				fi
				ptype="raspberrypi"
				break
			fi
			# Check if we're running on a Pi Zero or Zero W.
			if grep -i -q "^Revision\s*:\s*[ 123][0-9a-f][0-9a-f][0-9a-f]0[9c][0-9a-f]$" /proc/cpuinfo; then
				if [ -z "$1" ]; then
					echo -e "\e[01;37mCompiling Q3lite on a Pi Zero or Zero W\n\e[0m"
				fi
				ptype="raspberrypi"
				break
			fi
			# Default to safe settings if we're unable to determine the Pi model.
			if [ -z "$1" ]; then
				echo -e "\e[01;33mCompiling Q3lite on an unknown Pi model\n\e[0m"
			fi
			ptype="raspberrypi"
			break
		done
	else
		echo -e "\e[01;31mUnable to determine platform type from /proc/cpuinfo\n\e[0m"
		exit 6
	fi

	if [ -z "$1" ]; then
		# Let's time the build process.
		SECONDS=0
	fi

	# Set compile options below.
	make -j$(nproc) \
		V=0 \
		BUILD_SERVER=1 \
		BUILD_CLIENT=1 \
		BUILD_BASEGAME=1 \
		BUILD_MISSIONPACK=0 \
		BUILD_GAME_SO=0 \
		BUILD_GAME_QVM=1 \
		BUILD_STANDALONE=0 \
		SERVERBIN=q3ded \
		CLIENTBIN=quake3 \
		BUILD_RENDERER_OPENGL2=0 \
		USE_OPENAL=0 \
		USE_OPENAL_DLOPEN=0 \
		USE_CURL=0 \
		USE_CURL_DLOPEN=0 \
		USE_MUMBLE=0 \
		USE_VOIP=0 \
		USE_FREETYPE=0 \
		USE_INTERNAL_LIBS=1 \
		USE_INTERNAL_JPEG=1 \
		USE_INTERNAL_SPEEX=1 \
		USE_INTERNAL_ZLIB=1 \
		USE_LOCAL_HEADERS=1 \
		Q3LITE_INSTALL_SDL=1 \
		PLATFORM=linux \
		COMPILE_PLATFORM=linux \
		PLATFORM_TYPE=$ptype \
		Q3LITE_USER=$q3l_user \
		Q3LITE_HOMEPATH=$q3l_homepath \
		Q3LITE_BASEPATH=$q3l_basepath \
		Q3LITE_DIR_DIR=$q3l_dir_dir \
		Q3LITE_MENU_DIR=$q3l_menu_dir \
		Q3LITE_APP_DIR=$q3l_app_dir \
		Q3LITE_LOCAL_APP_DIR=$q3l_local_app_dir \
		Q3LITE_BIN_DIR=$q3l_bin_dir \
		Q3LITE_IMG_DIR=$q3l_img_dir \
		Q3LITE_SYSTEMD_DIR=$q3l_systemd_dir \
		Q3LITE_SRC_HOME=$q3l_src_home \
		Q3LITE_SRC_PLATFORM=$q3l_src_platform \
		Q3LITE_SRC_SDL_PATH=$q3l_src_sdl_path \
		Q3LITE_LIB_PATH=$q3l_lib_path \
		Q3LITE_TMP_DIR=$q3l_pr_dir \
		Q3LITE_UPDATE=$inst_upd \
		$target

	if [ -z "$1" ]; then
		# Display the build time.
		etime=$SECONDS
		if (($etime<3600)); then
			printf '\n\e[01;37mBuild Time: %dm:%ds\n\n\e[0m' $(($etime%3600/60)) $(($etime%60))
		else
			printf '\n\e[01;37mBuild Time: %dh:%dm:%ds\n\n\e[0m' $(($etime/3600)) $(($etime%3600/60)) $(($etime%60))
		fi
	fi

else
	echo -e "\e[01;31mYou don't have write permissions to: $PWD.\n\nUnable to create the build directory to continue.\n\e[0m"
	exit 7
fi
unset update_paks
unset dl_paks
unset create_user
if [ "$1" = "install" ]; then
	echo -e "\e[01;37mRemember to copy the pak0.pk3 file from your legal copy of\e[0m"
	echo -e "\e[01;37mQuake3 or Steam version to $q3l_basepath/baseq3\n\e[0m"
	echo -e "\e[01;37mYou can launch the game from the applications menu in the\e[0m"
	echo -e "\e[01;37mGames section. Enjoy Q3lite!\n\e[0m"
fi
exit 0
