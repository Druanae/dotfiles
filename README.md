# Loki~'s Dotfiles
## Screenshots - [wallpaper](https://i.imgur.com/OWjfwGX.jpg)
![1](https://i.imgur.com/3C5G5Kf.png)
![2](https://i.imgur.com/805OpCY.png)  
![3](https://i.imgur.com/Gu8pLbB.png) 
### Software Shown:  
`Screenshot 01:`  \[ top-Left: modified z3bra's [info.sh](http://pub.z3bra.org/monochromatic/misc/info.sh) | \[ bottom-left: terminal colours ] | \[ bottom-right: neofetch ]  
`Screenshot 02:`  \[ left: ranger ] | \[ right: vim ]  
`Screenshot 03:`  \[ top: ncmpcpp ] | \[ bottom: cava ]  

## Specs
`OS:`    Arch Linux  
`CPU:`   Intel i5-2520m [4] @ 2.50GHz  
`GPU:`   Integrated  
`WM:`    [i3-gaps](https://github.com/Airblader/i3)  
`Term:`  urxvt  
`Font:`  Terminus  
`Bar:`   [Lemonbar](https://github.com/LemonBoy/bar) with xft patch.

## Notes
My personal dotfiles.
Most of this stuff is temporary.
A lot of the files contain placeholder variables for sensitive data like passwords and usernames.
Those files are:
* .gitconfig
* .mpdasrc
* .msmtprc
* .fdm.conf
* .netrc

## Dependencies
In this section I will be listing each config file and which piece of software they are specifically for.  
In most cases I will link the git repo if available or the Arch Wiki page for software instead of their project pages as I find these are more informative.  

**file/folder** | **associated software** | **description**   
------------ | ------------- | -------------  
.vimrc | [vim](https://wiki.archlinux.org/index.php/Vim) | Highly configurable CLI text editor.  
.vim/ | [vim](https://wiki.archlinux.org/index.php/Vim) | Stores plugin files and colourschemes.  
.xbindkeyssrc | [Xbindkeys](https://wiki.archlinux.org/index.php/Xbindkeys) | I use this to make sure my mouse buttons are mapped to forward and back.  
.netrc | [part of the GNU Inetutils suite](https://www.gnu.org/software/inetutils/manual/html_node/The-_002enetrc-file.html) | Stores login information for auto-login to remote servers. I use this for my email.  
.msmtprc | [msmtp](https://wiki.archlinux.org/index.php/msmtp) | Simple SMTP client. I use this to send emails.  
.mpdasrc | [mpdas](https://wiki.archlinux.org/index.php/Music_Player_Daemon/Tips_and_tricks#mpdas) | Scrobbles from MPD to last.fm  
.mailrc | [S-nail](https://wiki.archlinux.org/index.php/S-nail) | CLI mail client.  
.gitconfig | [git](https://wiki.archlinux.org/index.php/git) | Config file for the git version control system.  
.gitignore_global | [git](https://wiki.archlinux.org/index.php/git) | Stores files and file extensions that will be ignored when running git commands.  
.fdm.conf | [FDM](https://wiki.archlinux.org/index.php/fdm) | Fetches and Delivers my emails.  
.bashrc | [bash](https://wiki.archlinux.org/index.php/Bash) | Bash user config file. Contains command aliases, exports, etc.  
.scripts/rofi.sh | [rofi](https://wiki.archlinux.org/index.php/Rofi) | Script to run Rofi, a better replacement for dmenu. Including this because it's essential for my every day workflow.  
.scrips/poomf.sh | none | Script for taking screenshots and uploading them to a pomf clone. Bound to keys in i3's config for quick screenshot shortcuts.  
.scripts/poomf.sh | [sprunge](http://sprunge.us/) (NOT AN APPLICATION) | Custom script for quickly uploading files to the Sprunge website.
.Xresources | [Xresources](https://wiki.archlinux.org/index.php/x_resources) | Used to configure X applications such as URxvt's colours and font settings.  
.Xresources.d/ | [Xresources](https://wiki.archlinux.org/index.php/x_resources) | Optional folder. Stores config files for individual applications and are linked in ~/.Xresources using `#include`  
.themes/ | [GTK+](https://wiki.archlinux.org/index.php/GTK%2B) | Used to store the GTK themes for GTK applications such as PCManFM or Nautilus.  
.scripts/ | none | Stores all of my scripts that I have written or found and use for various purposes.  
.ncmpcpp/ | [ncmpcpp](https://wiki.archlinux.org/index.php/Ncmpcpp) | Stores the ncmpcpp Config. CLI frontend for [MPD](https://wiki.archlinux.org/index.php/MPD).  
.icons/ | [GTK+](https://wiki.archlinux.org/index.php/GTK%2B) | Used to store the Icon Themes used by GTK applications.  
.gimp-2.8/ | [GIMP](https://www.gimp.org/) | Stores files used by GIMP such as tool options and keybinds.  
.fonts/ | [fontconfig](https://wiki.archlinux.org/index.php/Font_configuration) | Stores user fonts to be used in applications.  
.config/ | system | Stores user config files for individual applications.  
.config/beets/ | [beets.io](https://wiki.archlinux.org/index.php/Beets) | Stores configs for the Beets media tagger.  
.config/cava/ | [cava](https://github.com/karlstav/cava) | Stores the config for the Cava CLI audio visualiser.  
.config/fontconfig/ | [fontconfig](https://wiki.archlinux.org/index.php/Font_configuration) | Stores config files for fontconfig.  
.config/git/ | [git](https://wiki.archlinux.org/index.php/git) | Stores misc config files for Git.  
.config/gtk-2.0/ | [GTK](https://wiki.archlinux.org/index.php/GTK%2B) | Stores the config file for GTK-2.0 applications.  
.config/gtk-3.0/ | [GTK](https://wiki.archlinux.org/index.php/GTK%2B) | Stores config files for GTK-3.0 applications.  
.config/i3/ | [i3](https://wiki.archlinux.org/index.php/I3) | Stores the config file for the i3 Dynamic Tiling Window Manager.  
.config/mirage/ | [mirage](http://mirageiv.sourceforge.net/) | Stores for the Mirage GTK+ Image Viewer.  
.config/mpd/ | [MPD](https://wiki.archlinux.org/index.php/MPD) | Stores the config and other necessary file for MPD.  
.config/mpv/ | [MPV](https://wiki.archlinux.org/index.php/Mpv) | Stores config and plugin files for the MPV Video Player.  
.config/neofetch/ | [neofetch](https://github.com/dylanaraps/neofetch/) | Stored the config file for the Neofetch CLI System info tool.  
.config/networkmanager-dmenu/ | [networkmanager-dmenu](https://github.com/firecat53/networkmanager-dmenu) | Stores the config file for networkmanager-dmenu. Configured to work with Rofi instead of dmenu.  
.config/pcmanfm | [pcmanfm](https://wiki.archlinux.org/index.php/PCManFM) | Stores the config for the PCManFM file manager.  
.config/ranger/ | [ranger](https://wiki.archlinux.org/index.php/PCManFM) | Stores the config for the Ranger commandline file manager. Needs w3m for image support.  
.config/transmission/ | [transmission](https://wiki.archlinux.org/index.php/Transmission) | Stores the configs for the Transmission CLI BitTorrent client.  
.config/compton.conf | [compton](https://wiki.archlinux.org/index.php/Compton) | Config file for the Compton compositor.  
