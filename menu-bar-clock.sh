#!/usr/bin/env bash

# AUTHOR: Steve Ward [steve@tech-otaku.com]
# URL: https://github.com/tech-otaku/menu-bar-clock.git
# README: https://github.com/tech-otaku/menu-bar-clock/blob/master/README.md

# USAGE: ./menu-bar-clock.sh FORMATSTRING
# EXAMPLE: ./menu-bar-clock.sh "EEE d MMM HH:mm"


# Exit with error if installed macOS version is not 11
    if [ $(system_profiler SPSoftwareDataType | awk '/System Version/ {print $4}' | cut -d . -f 1) -lt 11 ]; then
        printf "ERROR: For use with macOS 11 Big Sur only.\n"
        exit 1
    fi


valid=("EEE d MMM HH:mm:ss" "EEE HH:mm:ss" "d MMM HH:mm:ss" "HH:mm:ss" "EEE d MMM h:mm:ss a" "EEE h:mm:ss a" "d MMM h:mm:ss a" "h:mm:ss a" "EEE d MMM h:mm:ss" "EEE h:mm:ss" "d MMM h:mm:ss" "h:mm:ss" "EEE d MMM HH:mm" "EEE HH:mm" "d MMM HH:mm" "HH:mm" "EEE d MMM h:mm a" "EEE h:mm a" "d MMM h:mm a" "h:mm a" "EEE d MMM h:mm" "EEE h:mm" "d MMM h:mm" "h:mm")


invalid=true
for i in "${valid[@]}"; do 
    #echo $i
    if [ "$1" == "$i" ]; then
        unset invalid
        break
    fi
done


if [ -z $invalid ]; then

    killall System\ Preferences > /dev/null 2>&1

    defaults write com.apple.menuextra.clock.plist DateFormat -string "$1"

    # Day of week
    if [[ $1 == "EEE"* ]]; then
        defaults write com.apple.menuextra.clock.plist ShowDayOfWeek -bool true
    else
        defaults write com.apple.menuextra.clock.plist ShowDayOfWeek -bool false
    fi

    # Date
    if [[ $1 == *"d MMM"* ]]; then
        defaults write com.apple.menuextra.clock.plist ShowDayOfMonth -bool true
    else
        defaults write com.apple.menuextra.clock.plist ShowDayOfMonth -bool false
    fi

    # 24-hour time
    if [[ $1 == *"HH:mm"* ]]; then
        defaults delete -g AppleICUForce12HourTime > /dev/null 2>&1
        defaults write com.apple.menuextra.clock.plist Show24Hour -bool true
    fi    
    
    # 12-hour time
    if [[ $1 == *"h:mm"* ]]; then
        defaults write -g AppleICUForce12HourTime -bool true
        defaults write com.apple.menuextra.clock.plist Show24Hour -bool false
    fi

    # Seconds
    if [[ $1 == *"ss"* ]]; then
        defaults write com.apple.menuextra.clock.plist ShowSeconds -bool true
    else
        defaults write com.apple.menuextra.clock.plist ShowSeconds -bool false
    fi

    # am/pm
    if [[ $1 == *"a"* ]]; then
        defaults write com.apple.menuextra.clock.plist ShowAMPM -bool true
    else
        defaults write com.apple.menuextra.clock.plist ShowAMPM -bool false
        
    fi
    
    killall ControlCenter

else

    printf "ERROR: '%s' is NOT a valid Date/Time string\n" "$1"

fi
