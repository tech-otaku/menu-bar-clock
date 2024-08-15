#!/usr/bin/env bash

# AUTHOR:   Steve Ward [steve at tech-otaku dot com]
# URL:      https://github.com/tech-otaku/menu-bar-clock.git
# README:   https://github.com/tech-otaku/menu-bar-clock/blob/master/README.md

# USAGE:    ./menu-bar-clock.sh FORMATSTRING [-s]
# EXAMPLE:  ./menu-bar-clock.sh "EEE d MMM HH:mm" -s
#           ./menu-bar-clock.sh -s "d MMM HH:mm" 
#           ./menu-bar-clock.sh "EEE HH:mm" 


# Exit with error if installed macOS version is not macOS 11 Big Sur or later
    if [ $(system_profiler SPSoftwareDataType | awk '/System Version/ {print $4}' | cut -d . -f 1) -lt 11 ]; then
        printf "\nERROR: * * *  For use with macOS 11 Big Sur or later * * * \n\n"
        exit 1
    fi
    
    
# # # # # # # # # # # # # # # # # # # #
# FUNCTION DECLARATIONS
#
    
# Function to display usage help
    function usage() {
        cat << EOF
                    
    Syntax: 
    ./$(basename $0) -h
    ./$(basename $0) FORMATSTRING [-s]
    ./$(basename $0) [-s] FORMATSTRING

    Options:
    -h                  This help message.
    -s                  Show the date ($(date +'%-d %b')) in the menu bar when space allows.
    FORMATSTRING        A valid Apple-supplied date and time string.

    Example: ./$(basename $0) "EEE d MMM HH:mm" -s

    See https://github.com/tech-otaku/menu-bar-clock/blob/main/README.md for more examples.
    
EOF
    }
    
    
    
# # # # # # # # # # # # # # # # # # # #
# COMMAND-LINE OPTIONS
#

# The script expects one option, either '-h' or '-s' and one positional parameter when using '-s' that defines the date and time format. The options are processed by getopts. The positional parameter(s) are processed outside of the getopts loop. Positional parameter(s) can be placed before or after options.

# Exit with error if no command line options given
    if [[ ! $# -gt 0 ]]; then
        printf "\nERROR: * * * No options given * * *\n"
        usage
        exit 1
    fi

    while [ $# -gt 0 ]; do
        OPTIND=1            # OPTIND is (re)set to 1, so getopts can be called more than once.
        while getopts ':hs' opt; do
        # Process options 
            case $opt in
                h)  
                    usage
                    exit 1
                    ;;
                s)
                    SHOWDATE=true
                    ;;
                ?) 
                    printf "\nERROR: * * * Invalid option: '-%s' * * *\n" $OPTARG
                    usage
                    exit 1
                    ;;
            esac
        done
    # Process positional parameter(s)
        shift "$((OPTIND-1))"
        # The script expects only one positional parameter, but let's create an array of all the positional parameters just in case there are 2 or more! 
        if [[ ! -z "${1// }" ]]; then
            positional+=("$1")
        fi
        if [ $# -gt 0 ]; then   # If parsed by zsh, stops the error: "shift count must be <= $#"
            shift
        fi
    done



# # # # # # # # # # # # # # # # # # # #
# VALIDATION
#

# No positional parameters passed to the script i.e. ./menu-bar-clock.sh -s
    if [ "${#positional[@]}" -eq 0 ]; then
        printf "\nERROR: * * * No date and time format string given * * *\n"
        usage
        exit 1
# 2 or more positional parameters passed to the script i.e. ./menu-bar-clock.sh 'EEE d MMM HH:mm' -s 'd MMM HH:mm'
    elif [ "${#positional[@]}" -gt 1 ]; then
        printf "\nERROR: * * * Too many parameters * * *\n"
        usage
        exit 1
# 1 positional parameter passed to the script i.e ./menu-bar-clock.sh 'EEE d MMM HH:mm' -s 
    else
        FORMATSTRING="${positional[@]:0:1}"     # Works for both bash and zsh
    fi

# Create an array of valid date and time format strings
    valid=("EEE d MMM HH:mm:ss" "EEE HH:mm:ss" "d MMM HH:mm:ss" "HH:mm:ss" "EEE d MMM h:mm:ss a" "EEE h:mm:ss a" "d MMM h:mm:ss a" "h:mm:ss a" "EEE d MMM h:mm:ss" "EEE h:mm:ss" "d MMM h:mm:ss" "h:mm:ss" "EEE d MMM HH:mm" "EEE HH:mm" "d MMM HH:mm" "HH:mm" "EEE d MMM h:mm a" "EEE h:mm a" "d MMM h:mm a" "h:mm a" "EEE d MMM h:mm" "EEE h:mm" "d MMM h:mm" "h:mm")

# Check if the date and time format string passed to the script (FORMATSTRING) is valid
    invalid=true
    if printf '%s\0' "${valid[@]}" | grep -Fxzq "$FORMATSTRING"; then   # See https://stackoverflow.com/a/47541882
        unset invalid
    fi



# # # # # # # # # # # # # # # # # # # #
# SET MENU BAR CLOCK DISPLAY
#

# Process the new format string
    if [ -z $invalid ]; then        # If $invalid is unset, the format string is valid

    # The script takes different actions depending on the version of macOS, so determine the major and minor versions of the installed OS e.g. 12.4
        major=$(system_profiler SPSoftwareDataType | awk '/System Version/ {print $4}' | cut -d . -f 1)
        minor=$(system_profiler SPSoftwareDataType | awk '/System Version/ {print $4}'| cut -d . -f 2)

    # Quit System Settings (previously System Preferences prior to macOS Ventura 13)
        SETTINGS="System Settings"
        if [[ $major -lt 13 ]]; then
            SETTINGS="System Preferences"
        fi

        killall "$SETTINGS" 2> /dev/null                        # Write STDERR to /dev/null to supress message if process isn't running

    # The date and time format is irrelevant unless the menu bar displays a digital clock
        defaults write com.apple.menuextra.clock.plist IsAnalog -bool false
        
    # Set the new format string 
        defaults write com.apple.menuextra.clock.plist DateFormat -string "$FORMATSTRING"

    # Set the various keys based upon the new format string
        # Day (Thu)
        if [[ "$FORMATSTRING" == *"EEE"* ]]; then
            defaults write com.apple.menuextra.clock.plist ShowDayOfWeek -bool true
        else
            defaults write com.apple.menuextra.clock.plist ShowDayOfWeek -bool false
        fi

        # Date (18 Aug)
        if [[ $major -ge 13 || ($major -eq 12 && $minor -ge 4) ]]; then
            # macOS Monterey 12.4 and later
            if [[ "$FORMATSTRING" == *"d MMM"* ]]; then
                if [ ! -z "$SHOWDATE" ]; then
                    defaults write com.apple.menuextra.clock.plist ShowDate -int 0
                else
                    defaults write com.apple.menuextra.clock.plist ShowDate -int 1
                fi
            else
                defaults write com.apple.menuextra.clock.plist ShowDate -int 2
            fi  
        else
            # macOS macOS Monterey 12.3.1 and earlier
            if [[ "$FORMATSTRING" == *"d MMM"* ]]; then
                defaults write com.apple.menuextra.clock.plist ShowDayOfMonth -bool true
            else
                defaults write com.apple.menuextra.clock.plist ShowDayOfMonth -bool false
            fi
        fi

        # 24-hour time (23:46)
        if [[ "$FORMATSTRING" == *"HH:mm"* ]]; then
            defaults delete -g AppleICUForce12HourTime > /dev/null 2>&1
            defaults write com.apple.menuextra.clock.plist Show24Hour -bool true
        fi    
        
        # 12-hour time (11:46)
        if [[ "$FORMATSTRING" == *"h:mm"* ]]; then
            defaults write -g AppleICUForce12HourTime -bool true
            defaults write com.apple.menuextra.clock.plist Show24Hour -bool false
        fi

        # Seconds (:18)
        if [[ "$FORMATSTRING" == *"ss"* ]]; then
            defaults write com.apple.menuextra.clock.plist ShowSeconds -bool true
        else
            defaults write com.apple.menuextra.clock.plist ShowSeconds -bool false
        fi

        # AM/PM (am|pm)
        if [[ "$FORMATSTRING" == *"a"* ]]; then
            defaults write com.apple.menuextra.clock.plist ShowAMPM -bool true
        else
            defaults write com.apple.menuextra.clock.plist ShowAMPM -bool false       
        fi
        
    # Restart the ControlCenter process for changes to take effect
        killall ControlCenter

        printf "The menu bar clock format has been set to '%s'.\n" "$FORMATSTRING"
        if [[ $major -ge 13 || ($major -eq 12 && $minor -ge 4) ]]; then
            if [ $(defaults read com.apple.menuextra.clock.plist ShowDate) -eq 0 ]; then
                printf "The date portion (%s) will be shown %s.\n" "$(date +'%-d %b')" "when space allows"
            elif [ $(defaults read com.apple.menuextra.clock.plist ShowDate) -eq 1 ]; then
                printf "The date portion (%s) will %s be shown.\n" "$(date +'%-d %b')" "always"
            fi
        fi

    else                            # If $invalid is set, the format string is invalid

        printf "\nERROR: * * * '%s' is NOT a valid Apple-defined date and time format string for the menu bar clock * * *\n\n" "$FORMATSTRING"

    fi
