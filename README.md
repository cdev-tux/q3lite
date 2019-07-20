<img height=auto width=29% src="https://raw.githubusercontent.com/cdev-tux/q3lite/master/misc/q3lite/img/q3lite_logo.gif" alt="Q3lite Logo"><img height=auto width=69% src="https://raw.githubusercontent.com/cdev-tux/q3lite/master/misc/q3lite/img/q3lite-screenshot.jpg" alt="Q3lite Screenshot">

&nbsp; &nbsp; **Q3lite** is an updated [id Tech 3](https://en.wikipedia.org/wiki/Id_Tech_3) game engine for embedded Linux systems.  The project is a fork of [ioquake3](https://github.com/ioquake/ioq3). Q3lite provides users with an updated version of the engine running on [OpenGL ES](https://www.khronos.org/opengles) and [SDL2](https://www.libsdl.org).  The goal of the project is to add useful new features that enhance the game experience for both players and server administrators while staying in sync with the updated Quake III Arena engine.  The long term plan is to slim the code down to improve performance on low-end embedded processors, hence the name Q3lite.


### Platforms

  * Raspberry Pi Zero, Zero W
  * Raspberry Pi 1 Model A+, B, B+ w/512 MB Memory
  * Raspberry Pi 2
  * Raspberry Pi 3, 3A+, 3B+
  * Pi platforms are supported on Raspbian Desktop and Raspbian Lite


### Features

<img src="https://raw.githubusercontent.com/cdev-tux/q3lite/master/misc/q3lite/img/app_menu.jpg" width="430" align="right" style="margin-left:8px;margin-top:5px" alt="App Menu">

  * Built on the latest ioq3 codebase using OpenGL ES.
  * Set the game resolution independent of your desktop resolution on the Pi.
  * Play full screen with or without x11 running.
  * Optimized player and dedicated server config files included with instructions for each setting.
  * The provided compile script automatically detects the Pi processor type and sets optimized compiler settings.
  * Includes a robust installer to automatically create game directories, copy game files and download&nbsp;/&nbsp;install updated pak files from the Q3A Point Release. It can also install SDL2 dynamic  libraries so there's no need to compile or preinstall SDL2. The installer creates game, server, rcon and   timedemo launch icons in the applications menu as seen in the image above.  
  **Note:** You'll still need to copy the pak0.pk3 file from your full version of Quake III Arena to play the game. See section 1.1 of the [Q3lite FAQ](https://github.com/cdev-tux/q3lite/wiki/Q3lite-FAQ) for details.
  * Uninstaller included for removing installation if desired.
  * Includes all files and step by step instructions to run a dedicated server from the applications menu or as a systemd service at boot time.
  * Timedemo four runs at ~150 fps on a Pi 3 B+ at 720P (without overclocking).
  * Also includes a desktop Remote Console (rcon) application to send console commands to the background server.

### New Q3lite cvars
These cvars are in addition to those currently available in the base game. All new features can be turned off to maintain default Quake3 behavior. Set client cvars in your autoexec.cfg file and server cvars in your server.cfg file, both located in ~/.q3a/baseq3.

```
Client cvars:

  cg_drawSpeedometer <0|1>          - Toggle display of player speed in
                                      Quake units per second.  Speed shown in
                                      upper right corner under the match clock.
                                      Also works with demos and while following
                                      other players in spectator mode.
                                      0 = disabled.
                                      1 = enabled.

  cg_nochatbeeps <0|1|2|3>          - Toggle playing of the chat beep sound.
                                      Handy on servers with chatty spectators.
                                      0 = disabled.
                                      1 = No chat beeps for non-team chat only.
                                      2 = No chat beeps for team chat only.
                                      3 = No chat beeps for team / non-team chat.

  cg_novotebeeps <0|1|2|3>          - Toggle playing of the vote beep sound.
                                      0 = disabled.
                                      1 = No vote beeps for non-team votes only.
                                      2 = No vote beeps for team votes only.
                                      3 = No vote beeps for team / non-team votes.

  cg_noTaunts <0|1>                 - Toggle playing of client taunt sounds.
                                      Useful when opponents press the taunt
                                      key excessively.
                                      0 = disabled.
                                      1 = No taunt sounds played.

Server cvars:

  g_intermissionDuration <seconds>  - Limits end-of-round intermission duration.
                                      Prevents endless intermission if a human
                                      player is away from the keyboard.
                                      0 = disabled.
                                      > 0 = intermission duration in seconds,
                                      then server moves to the next map.
                                      Valid range 5 - 30 seconds.

  sv_inactivity <seconds>           - Move player to spectator mode after a
                                      period of inactivity rather than kick them
                                      as g_inactivity does. Set to a lower value
                                      than g_inactivity if both are used.
                                      0 = disabled.
                                      > 0 = inactivity period in seconds, then
                                      server moves player to spectator mode.

  sv_maxconcurrent <0|1..64>        - Limits the number of simultaneous player
                                      connections from the same IP address.
                                      0 = disabled.
                                      Valid range 1 - 64.
```

### Getting Started

  * See the [Compiling and Installation Guide](https://github.com/cdev-tux/q3lite/wiki/Compiling-Install-Guide) for instructions on how to get Q3lite up and running.
  * Copy the pak0.pk3 file from your official copy of Quake III Arena or Steam version to `/usr/local/games/quake3/baseq3`.
  * Set the memory split on the Pi platform.  See section 2.2 of the [Q3lite FAQ](https://github.com/cdev-tux/q3lite/wiki/Q3lite-FAQ) for details.
  * Be sure to set the necessary passwords in your server.cfg file located in ~/.q3a/baseq3.

### Documentation

  * [Q3lite wiki](https://github.com/cdev-tux/q3lite/wiki)
  * [Compiling and Installation Guide](https://github.com/cdev-tux/q3lite/wiki/Compiling-Install-Guide)
  * [Q3lite FAQ](https://github.com/cdev-tux/q3lite/wiki/Q3lite-FAQ)

### Q3lite on the Web

  * [Q3lite - Raspberry Pi Forums](https://www.raspberrypi.org/forums/viewtopic.php?f=78&t=198680)

### Git branches

  * `master` stable - serious bug fixes only.
  * `dev` unstable - latest features/bug fixes - periodically promoted to stable.

### Versioning

Q3lite uses [Semantic Versioning.](http://semver.org)  
Release syntax is "Major_version.Minor_version.Patch_version".  
Post-release syntax is "Major_version.Minor_version.Patch_version+Commit_sha1".  
Full releases are tagged with the version number.  

### License

Q3lite is licensed under a [modified version of the GNU GPLv3](https://github.com/cdev-tux/q3lite/blob/master/COPYING.txt#L625) (or at your option, any later version). This license is also used by Doom 3.

### Contributing

Please submit patches as a GitHub pull request.  

  * One of the goals of Q3lite is to remove features that are too resource intensive to run well on embedded processors. This goes hand in hand with optimizing code to improve performance.
  * Q3lite is looking to add new lightweight features to help server administrators run their servers, as well as player features to enhance the Q3 experience.
  * The project also needs someone with [OpenGL ES](https://www.khronos.org/opengles) experience to help improve the renderer.
  * See the [Contributing Guide](https://github.com/cdev-tux/q3lite/wiki/Contributing) for details on how you can help.
  * If you enjoy Q3lite please consider giving the project a star at the top of this page.


### Credits

**Maintainer**

  * cdev-tux - [github.com/cdev-tux](https://github.com/cdev-tux)

**Significant contributions from:**  

  * Quake III Arena [source code](https://github.com/id-Software/Quake-III-Arena) - [id software](http://www.idsoftware.com)
  * ioquake3 contributors - [github.com/ioquake/ioq3](https://github.com/ioquake/ioq3)
  * Quake3e - [github.com/ec-/Quake3e](https://github.com/ec-/Quake3e)
  * SDL - [libsdl.org](https://www.libsdl.org)
  * Open Arena - [github.com/OpenArena](https://github.com/OpenArena)
  * ptitSeb - [github.com/ptitSeb/ioq3](https://github.com/ptitSeb/ioq3)
  * twolife - [github.com/twolife/ioq3](https://github.com/twolife/ioq3)
  * q3mme - [github.com/entdark/q3mme](https://github.com/entdark/q3mme)
  * Uber Demo Tools - [github.com/mightycow/uberdemotools](https://github.com/mightycow/uberdemotools)
  * and many other contributors


Quake III Arena screenshot copyright © 1999-2000 [id software](http://www.idsoftware.com).  
Raspberry Pi is a trademark of the [Raspberry Pi Foundation](https://www.raspberrypi.org/).  
Q3lite copyright © 2016 - 2019 cdev-tux - [github.com/cdev-tux](https://github.com/cdev-tux).  
All trademarks, logos and copyrights are the property of their respective owners.  

---

---
&nbsp;
### *ioquake3 SECURITY.md:*

## ioquake3 Security
We take security very seriously at ioquake3. We welcome any peer review of our 100% free software source code to ensure nobody's ioquake3 clients or servers are ever compromised or hacked.

### Where should I report security issues?

In order to give the community time to respond and upgrade we strongly urge you report all security issues privately.
Please contact zachary@ioquake.org directly to provide details and repro steps and we will respond ASAP.

&nbsp;
### *ioquake3 README.md:*


                   ,---------------------------------------.
                   |   _                     _       ____  |
                   |  (_)___  __ _ _  _ __ _| |_____|__ /  |
                   |  | / _ \/ _` | || / _` | / / -_)|_ \  |
                   |  |_\___/\__, |\_,_\__,_|_\_\___|___/  |
                   |            |_|                        |
                   |                                       |
                   `---------- http://ioquake3.org --------'

The intent of this project is to provide a baseline Quake 3 which may be used
for further development and baseq3 fun.
Some of the major features currently implemented are:

  * SDL 2 backend
  * OpenAL sound API support (multiple speaker support and better sound
    quality)
  * Full x86_64 support on Linux
  * VoIP support, both in-game and external support through Mumble.
  * MinGW compilation support on Windows and cross compilation support on Linux
  * AVI video capture of demos
  * Much improved console autocompletion
  * Persistent console history
  * Colorized terminal output
  * Optional Ogg Vorbis support
  * Much improved QVM tools
  * Support for various esoteric operating systems
  * cl_guid support
  * HTTP/FTP download redirection (using cURL)
  * Multiuser support on Windows systems (user specific game data
    is stored in "%APPDATA%\Quake3")
  * PNG support
  * Many, many bug fixes

The map editor and associated compiling tools are not included. We suggest you
use a modern copy from http://icculus.org/gtkradiant/.

The original id software readme that accompanied the Q3 source release has been
renamed to id-readme.txt so as to prevent confusion. Please refer to the
website for updated status.

More documentation including a Player's Guide and Sysadmin Guide is on:
http://wiki.ioquake3.org/

If you've got issues that you aren't sure are worth filing as bugs, or just
want to chat, please visit our forums:
http://discourse.ioquake.org

# Compilation and installation

For *nix
  1. Change to the directory containing this readme.
  2. Run 'make'.

For Windows,
  1. Please refer to the excellent instructions here:
     http://wiki.ioquake3.org/Building_ioquake3

For Mac OS X, building a Universal Binary
  1. Install MacOSX SDK packages from XCode.  For maximum compatibility,
     install MacOSX10.4u.sdk and MacOSX10.3.9.sdk, and MacOSX10.2.8.sdk.
  2. Change to the directory containing this README file.
  3. Run './make-macosx-ub.sh'
  4. Copy the resulting ioquake3.app in /build/release-darwin-ub to your
     /Applications/ioquake3 folder.

Installation, for *nix
  1. Set the COPYDIR variable in the shell to be where you installed Quake 3
     to. By default it will be /usr/local/games/quake3 if you haven't set it.
     This is the path as used by the original Linux Q3 installer and subsequent
     point releases.
  2. Run 'make copyfiles'.

It is also possible to cross compile for Windows under *nix using MinGW. Your
distribution may have mingw32 packages available. On debian/Ubuntu, you need to
install 'mingw-w64'. Thereafter cross compiling is simply a case running
'PLATFORM=mingw32 ARCH=x86 make' in place of 'make'. ARCH may also be set to
x86_64.

The following variables may be set, either on the command line or in
Makefile.local:

```
  CFLAGS               - use this for custom CFLAGS
  V                    - set to show cc command line when building
  DEFAULT_BASEDIR      - extra path to search for baseq3 and such
  BUILD_SERVER         - build the 'ioq3ded' server binary
  BUILD_CLIENT         - build the 'ioquake3' client binary
  BUILD_BASEGAME       - build the 'baseq3' binaries
  BUILD_MISSIONPACK    - build the 'missionpack' binaries
  BUILD_GAME_SO        - build the game shared libraries
  BUILD_GAME_QVM       - build the game qvms
  BUILD_STANDALONE     - build binaries suited for stand-alone games
  SERVERBIN            - rename 'ioq3ded' server binary
  CLIENTBIN            - rename 'ioquake3' client binary
  USE_RENDERER_DLOPEN  - build and use the renderer in a library
  USE_YACC             - use yacc to update code/tools/lcc/lburg/gram.c
  BASEGAME             - rename 'baseq3'
  BASEGAME_CFLAGS      - custom CFLAGS for basegame
  MISSIONPACK          - rename 'missionpack'
  MISSIONPACK_CFLAGS   - custom CFLAGS for missionpack (default '-DMISSIONPACK')
  USE_OPENAL           - use OpenAL where available
  USE_OPENAL_DLOPEN    - link with OpenAL at runtime
  USE_CURL             - use libcurl for http/ftp download support
  USE_CURL_DLOPEN      - link with libcurl at runtime
  USE_CODEC_VORBIS     - enable Ogg Vorbis support
  USE_CODEC_OPUS       - enable Ogg Opus support
  USE_MUMBLE           - enable Mumble support
  USE_VOIP             - enable built-in VoIP support
  USE_FREETYPE         - enable FreeType support for rendering fonts
  USE_INTERNAL_LIBS    - build internal libraries instead of dynamically
                         linking against system libraries; this just sets
                         the default for USE_INTERNAL_ZLIB etc.
                         and USE_LOCAL_HEADERS
  USE_INTERNAL_ZLIB    - build and link against internal zlib
  USE_INTERNAL_JPEG    - build and link against internal JPEG library
  USE_INTERNAL_OGG     - build and link against internal ogg library
  USE_INTERNAL_OPUS    - build and link against internal opus/opusfile libraries
  USE_LOCAL_HEADERS    - use headers local to ioq3 instead of system ones
  DEBUG_CFLAGS         - C compiler flags to use for building debug version
  COPYDIR              - the target installation directory
  TEMPDIR              - specify user defined directory for temp files
```

The defaults for these variables differ depending on the target platform.


# Console

## New cvars

```
  cl_autoRecordDemo                 - record a new demo on each map change
  cl_aviFrameRate                   - the framerate to use when capturing video
  cl_aviMotionJpeg                  - use the mjpeg codec when capturing video
  cl_guidServerUniq                 - makes cl_guid unique for each server
  cl_cURLLib                        - filename of cURL library to load
  cl_consoleKeys                    - space delimited list of key names or
                                      characters that toggle the console
  cl_mouseAccelStyle                - Set to 1 for QuakeLive mouse acceleration
                                      behaviour, 0 for standard q3
  cl_mouseAccelOffset               - Tuning the acceleration curve, see below

  con_autochat                      - Set to 0 to disable sending console input
                                      text as chat when there is not a slash
                                      at the beginning
  con_autoclear                     - Set to 0 to disable clearing console
                                      input text when console is closed

  in_joystickUseAnalog              - Do not translate joystick axis events
                                      to keyboard commands

  j_forward                         - Joystick analogue to m_forward,
                                      for forward movement speed/direction.
  j_side                            - Joystick analogue to m_side,
                                      for side movement speed/direction.
  j_up                              - Joystick up movement speed/direction.
  j_pitch                           - Joystick analogue to m_pitch,
                                      for pitch rotation speed/direction.
  j_yaw                             - Joystick analogue to m_yaw,
                                      for yaw rotation speed/direction.
  j_forward_axis                    - Selects which joystick axis
                                      controls forward/back.
  j_side_axis                       - Selects which joystick axis
                                      controls left/right.
  j_up_axis                         - Selects which joystick axis
                                      controls up/down.
  j_pitch_axis                      - Selects which joystick axis
                                      controls pitch.
  j_yaw_axis                        - Selects which joystick axis
                                      controls yaw.

  s_useOpenAL                       - use the OpenAL sound backend if available
  s_alPrecache                      - cache OpenAL sounds before use
  s_alGain                          - the value of AL_GAIN for each source
  s_alSources                       - the total number of sources (memory) to
                                      allocate
  s_alDopplerFactor                 - the value passed to alDopplerFactor
  s_alDopplerSpeed                  - the value passed to alDopplerVelocity
  s_alMinDistance                   - the value of AL_REFERENCE_DISTANCE for
                                      each source
  s_alMaxDistance                   - the maximum distance before sounds start
                                      to become inaudible.
  s_alRolloff                       - the value of AL_ROLLOFF_FACTOR for each
                                      source
  s_alGraceDistance                 - after having passed MaxDistance, length
                                      until sounds are completely inaudible
  s_alDriver                        - which OpenAL library to use
  s_alDevice                        - which OpenAL device to use
  s_alAvailableDevices              - list of available OpenAL devices
  s_alInputDevice                   - which OpenAL input device to use
  s_alAvailableInputDevices         - list of available OpenAL input devices
  s_sdlBits                         - SDL bit resolution
  s_sdlSpeed                        - SDL sample rate
  s_sdlChannels                     - SDL number of channels
  s_sdlDevSamps                     - SDL DMA buffer size override
  s_sdlMixSamps                     - SDL mix buffer size override
  s_backend                         - read only, indicates the current sound
                                      backend
  s_muteWhenMinimized               - mute sound when minimized
  s_muteWhenUnfocused               - mute sound when window is unfocused
  sv_dlRate                         - bandwidth allotted to PK3 file downloads
                                      via UDP, in kbyte/s

  com_ansiColor                     - enable use of ANSI escape codes in the tty
  com_altivec                       - enable use of altivec on PowerPC systems
  com_standalone (read only)        - If set to 1, quake3 is running in
                                      standalone mode
  com_basegame                      - Use a different base than baseq3. If no
                                      original Quake3 or TeamArena pak files
                                      are found, this will enable running in
                                      standalone mode
  com_homepath                      - Specify name that is to be appended to the
                                      home path
  com_legacyprotocol                - Specify protocol version number for
                                      legacy Quake3 1.32c protocol, see
                                      "Network protocols" section below
                                      (startup only)
  com_maxfpsUnfocused               - Maximum frames per second when unfocused
  com_maxfpsMinimized               - Maximum frames per second when minimized
  com_busyWait                      - Will use a busy loop to wait for rendering
                                      next frame when set to non-zero value
  com_pipefile                      - Specify filename to create a named pipe
                                      through which other processes can control
                                      the server while it is running.
                                      Nonfunctional on Windows.
  com_gamename                      - Gamename sent to master server in
                                      getservers[Ext] query and infoResponse
                                      "gamename" infostring value. Also used
                                      for filtering local network games.
  com_protocol                      - Specify protocol version number for
                                      current ioquake3 protocol, see
                                      "Network protocols" section below
                                      (startup only)

  in_joystickNo                     - select which joystick to use
  in_availableJoysticks             - list of available Joysticks
  in_keyboardDebug                  - print keyboard debug info

  sv_dlURL                          - the base of the HTTP or FTP site that
                                      holds custom pk3 files for your server
  sv_banFile                        - Name of the file that is used for storing
                                      the server bans

  net_ip6                           - IPv6 address to bind to
  net_port6                         - port to bind to using the ipv6 address
  net_enabled                       - enable networking, bitmask. Add up
                                      number for option to enable it:
                                      enable ipv4 networking:    1
                                      enable ipv6 networking:    2
                                      prioritise ipv6 over ipv4: 4
                                      disable multicast support: 8
  net_mcast6addr                    - multicast address to use for scanning for
                                      ipv6 servers on the local network
  net_mcastiface                    - outgoing interface to use for scan

  r_allowResize                     - make window resizable
  r_ext_texture_filter_anisotropic  - anisotropic texture filtering
  r_zProj                           - distance of observer camera to projection
                                      plane in quake3 standard units
  r_greyscale                       - desaturate textures, useful for anaglyph,
                                      supports values in the range of 0 to 1
  r_stereoEnabled                   - enable stereo rendering for techniques
                                      like shutter glasses (untested)
  r_anaglyphMode                    - Enable rendering of anaglyph images
                                      red-cyan glasses:    1
                                      red-blue:            2
                                      red-green:           3
                                      green-magenta:       4
                                      To swap the colors for left and right eye
                                      just add 4 to the value for the wanted
                                      color combination. For red-blue and
                                      red-green you probably want to enable
                                      r_greyscale
  r_stereoSeparation                - Control eye separation. Resulting
                                      separation is r_zProj divided by this
                                      value in quake3 standard units.
                                      See also
                                      http://wiki.ioquake3.org/Stereo_Rendering
                                      for more information
  r_marksOnTriangleMeshes           - Support impact marks on md3 models, MOD
                                      developers should increase the mark
                                      triangle limits in cg_marks.c if they
                                      intend to use this.
  r_sdlDriver                       - read only, indicates the SDL driver
                                      backend being used
  r_noborder                        - Remove window decoration from window
                                      managers, like borders and titlebar.
  r_screenshotJpegQuality           - Controls quality of jpeg screenshots
                                      captured using screenshotJPEG
  r_aviMotionJpegQuality            - Controls quality of video capture when
                                      cl_aviMotionJpeg is enabled
  r_mode -2                         - This new video mode automatically uses the
                                      desktop resolution.
```

## New commands

```
  video [filename]        - start video capture (use with demo command)
  stopvideo               - stop video capture
  stopmusic               - stop background music
  minimize                - Minimize the game and show desktop
  togglemenu              - causes escape key event for opening/closing menu, or
                            going to a previous menu. works in binds, even in UI

  print                   - print out the contents of a cvar
  unset                   - unset a user created cvar

  banaddr <range>         - ban an ip address range from joining a game on this
                            server, valid <range> is either playernum or CIDR
                            notation address range.
  exceptaddr <range>      - exempt an ip address range from a ban.
  bandel <range>          - delete ban (either range or ban number)
  exceptdel <range>       - delete exception (either range or exception number)
  listbans                - list all currently active bans and exceptions
  rehashbans              - reload the banlist from serverbans.dat
  flushbans               - delete all bans

  net_restart             - restart network subsystem to change latched settings
  game_restart <fs_game>  - Switch to another mod

  which <filename/path>   - print out the path on disk to a loaded item

  execq <filename>        - quiet exec command, doesn't print "execing file.cfg"

  kicknum <client number> - kick a client by number, same as clientkick command
  kickall                 - kick all clients, similar to "kick all" (but kicks
                            everyone even if someone is named "all")
  kickbots                - kick all bots, similar to "kick allbots" (but kicks
                            all bots even if someone is named "allbots")

  tell <client num> <msg> - send message to a single client (new to server)

  cvar_modified [filter]  - list modified cvars, can filter results (such as "r*"
                            for renderer cvars) like cvarlist which lists all cvars

  addbot random           - the bot name "random" now selects a random bot
```


# README for Developers

## pk3dir

ioquake3 has a useful new feature for mappers. Paths in a game directory with
the extension ".pk3dir" are treated like pk3 files. This means you can keep
all files specific to your map in one directory tree and easily zip this
folder for distribution.

## 64bit mods

If you wish to compile external mods as shared libraries on a 64bit platform,
and the mod source is derived from the id Q3 SDK, you will need to modify the
interface code a little. Open the files ending in _syscalls.c and change
every instance of int to intptr_t in the declaration of the syscall function
pointer and the dllEntry function. Also find the vmMain function for each
module (usually in cg_main.c g_main.c etc.) and similarly replace the return
value in the prototype with intptr_t (arg0, arg1, ...stay int).

Add the following code snippet to q_shared.h:

    #ifdef Q3_VM
    typedef int intptr_t;
    #else
    #include <stdint.h>
    #endif

Note if you simply wish to run mods on a 64bit platform you do not need to
recompile anything since by default Q3 uses a virtual machine system.

## Creating mods compatible with Q3 1.32b

If you're using this package to create mods for the last official release of
Q3, it is necessary to pass the commandline option '-vq3' to your invocation
of q3asm. This is because by default q3asm outputs an updated qvm format that
is necessary to fix a bug involving the optimizing pass of the x86 vm JIT
compiler.

## Creating standalone games

Have you finished the daunting task of removing all dependencies on the Q3
game data? You probably now want to give your users the opportunity to play
the game without owning a copy of Q3, which consequently means removing cd-key
and authentication server checks. In addition to being a straightforward Q3
client, ioquake3 also purports to be a reliable and stable code base on which
to base your game project.

However, before you start compiling your own version of ioquake3, you have to
ask yourself: Have we changed or will we need to change anything of importance
in the engine?

If your answer to this question is "no", it probably makes no sense to build
your own binaries. Instead, you can just use the pre-built binaries on the
website. Just make sure the game is called with:

    +set com_basegame <yournewbase>

in any links/scripts you install for your users to start the game. The
binary must not detect any original quake3 game pak files. If this
condition is met, the game will set com_standalone to 1 and is then running
in stand alone mode.

If you want the engine to use a different directory in your homepath than
e.g. "Quake3" on Windows or ".q3a" on Linux, then set a new name at startup
by adding

    +set com_homepath <homedirname>

to the command line. You can also control which game name to use when talking
to the master server:

    +set com_gamename <gamename>

So clients requesting a server list will only receive servers that have a
matching game name.

Example line:

    +set com_basegame basefoo +set com_homepath .foo
    +set com_gamename foo

If you really changed parts that would make vanilla ioquake3 incompatible with
your mod, we have included another way to conveniently build a stand-alone
binary. Just run make with the option BUILD_STANDALONE=1. Don't forget to edit
the PRODUCT_NAME and subsequent #defines in qcommon/q_shared.h with
information appropriate for your project.

## Standalone game licensing

While a lot of work has been put into ioquake3 that you can benefit from free
of charge, it does not mean that you have no obligations to fulfill. Please be
aware that as soon as you start distributing your game with an engine based on
our sources we expect you to fully comply with the requirements as stated in
the GPL. That includes making sources and modifications you made to the
ioquake3 engine as well as the game-code used to compile the .qvm files for
the game logic freely available to everyone. Furthermore, note that the "QIIIA
Game Source License" prohibits distribution of mods that are intended to
operate on a version of Q3 not sanctioned by id software:

    "with this Agreement, ID grants to you the non-exclusive and limited right
    to distribute copies of the Software ... for operation only with the full
    version of the software game QUAKE III ARENA"

This means that if you're creating a standalone game, you cannot use said
license on any portion of the product. As the only other license this code has
been released under is the GPL, this is the only option.

This does NOT mean that you cannot market this game commercially. The GPL does
not prohibit commercial exploitation and all assets (e.g. textures, sounds,
maps) created by yourself are your property and can be sold like every other
game you find in stores.


## PNG support

ioquake3 supports the use of PNG (Portable Network Graphic) images as
textures. It should be noted that the use of such images in a map will
result in missing placeholder textures where the map is used with the id
Quake 3 client or earlier versions of ioquake3.

Recent versions of GtkRadiant and q3map2 support PNG images without
modification. However GtkRadiant is not aware that PNG textures are supported
by ioquake3. To change this behaviour open the file 'q3.game' in the 'games'
directory of the GtkRadiant base directory with an editor and change the
line:

    texturetypes="tga jpg"

to

    texturetypes="tga jpg png"

Restart GtkRadiant and PNG textures are now available.

## Building with MinGW for pre Windows XP

IPv6 support requires a header named "wspiapi.h" to abstract away from
differences in earlier versions of Windows' IPv6 stack. There is no MinGW
equivalent of this header and the Microsoft version is obviously not
redistributable, so in its absence we're forced to require Windows XP.
However if this header is acquired separately and placed in the qcommon/
directory, this restriction is lifted.


# Contributing

Please send all patches to bugzilla (https://bugzilla.icculus.org), or as a GitHub pull request and
submit your patch there.

The focus for ioq3 is to develop a stable base suitable for further development
and provide players with the same Quake 3 experience they've had for years.

We do have graphical improvements with the new renderer, but they are off by default.
See opengl2-readme.md for more information.

# Building Official Installers

We need help getting automated installers on all the platforms that ioquake3
supports. We don't necessarily care about all the installers being identical,
but we have some general guidelines:

  * Please include the id patch pk3s in your installer, which are available
    from http://ioquake3.org/patch-data/ subject to agreement to the id
    EULA. Your installer shall also ask the user to agree to this EULA (which
    is in the /web/include directory for your convenience) and subsequently
    refuse to continue the installation of the patch pk3s and pak0.pk3 if they
    do not.

  * Please don't require pak0.pk3, since not everyone using the engine
    plans on playing Quake 3 Arena on it. It's fine to (optionally) assist the
    user in copying the file or tell them how.

  * It is fine to just install the binaries without requiring id EULA agreement,
    providing pak0.pk3 and the patch pk3s are not referred to or included in the
    installer.

  * Please include at least a libSDL2 so/dylib/dll on every platform.

  * Please include an OpenAL so/dylib/dll, since every platform should be using
    it by now.

  * Please be prepared to alter your installer on the whim of the maintainers.

  * Your installer will be mirrored to an "official" directory, thus making it
    a done deal.


# Credits

Maintainers

  * James Canete <use.less01@gmail.com>
  * Ludwig Nussel <ludwig.nussel@suse.de>
  * Thilo Schulz <arny@ats.s.bawue.de>
  * Tim Angus <tim@ngus.net>
  * Tony J. White <tjw@tjw.org>
  * Zachary J. Slater <zachary@ioquake.org>
  * Zack Middleton <zturtleman@gmail.com>

Significant contributions from

  * Ryan C. Gordon <icculus@icculus.org>
  * Andreas Kohn <andreas@syndrom23.de>
  * Joerg Dietrich <Dietrich_Joerg@t-online.de>
  * Stuart Dalton <badcdev@gmail.com>
  * Vincent S. Cojot <vincent at cojot dot name>
  * optical <alex@rigbo.se>
  * Aaron Gyes <floam@aaron.gy>
