# menu-bar-clock

## Purpose

Set the date and time format of the Menu Bar clock from the command line in macOS Big Sur. 

## Instructions

1. [Download](https://github.com/tech-otaku/menu-bar-clock/archive/main.zip) menu-bar-clock.sh

1. Open the Terminal application in macOS

1. At a Terminal prompt:

    1. type `cd /path/to/script/file` and press enter

    1. type `chmod +x menu-bar-clock.sh` and press enter to make the script executable

    1. use one of the commands under the *Command Line* heading in the table below to set the required date and time format.  


## Usage

| Date & Time              | Command Line                               | 
|-------------------------:|:-------------------------------------------|
|    `Thu 18 Aug 23:46:18` | `./menu-bar-clock.sh "EEE d MMM HH:mm:ss"` | 
|           `Thu 23:46:18` | `./menu-bar-clock.sh "EEE HH:mm:ss"`       | 
|        `18 Aug 23:46:18` | `./menu-bar-clock.sh "d MMM HH:mm:ss"`     | 
|               `23:46:18` | `./menu-bar-clock.sh "HH:mm:ss"`           | 
| `Thu 18 Aug 11:46:18 pm` | `./menu-bar-clock.sh "EEE d MMM h:mm:ss a"`| 
|        `Thu 11:46:18 pm` | `./menu-bar-clock.sh "EEE h:mm:ss a"`      | 
|     `18 Aug 11:46:18 pm` | `./menu-bar-clock.sh "d MMM h:mm:ss a"`    | 
|            `11:46:18 pm` | `./menu-bar-clock.sh "h:mm:ss a"`          | 
|    `Thu 18 Aug 11:46:18` | `./menu-bar-clock.sh "EEE d MMM h:mm:ss"`  | 
|           `Thu 11:46:18` | `./menu-bar-clock.sh "EEE h:mm:ss"`        | 
|        `18 Aug 11:46:18` | `./menu-bar-clock.sh "d MMM h:mm:ss"`      | 
|               `11:46:18` | `./menu-bar-clock.sh "h:mm:ss"`            | 
|       `Thu 18 Aug 23:46` | `./menu-bar-clock.sh "EEE d MMM HH:mm"`    | 
|              `Thu 23:46` | `./menu-bar-clock.sh "EEE HH:mm"`          | 
|           `18 Aug 23:46` | `./menu-bar-clock.sh "d MMM HH:mm"`        | 
|                  `23:46` | `./menu-bar-clock.sh "HH:mm"`              | 
|    `Thu 18 Aug 11:46 pm` | `./menu-bar-clock.sh "EEE d MMM h:mm a"`   | 
|           `Thu 11:46 pm` | `./menu-bar-clock.sh "EEE h:mm a"`         | 
|        `18 Aug 11:46 pm` | `./menu-bar-clock.sh "d MMM h:mm a"`       | 
|               `11:46 pm` | `./menu-bar-clock.sh "h:mm a"`             | 
|       `Thu 18 Aug 11:46` | `./menu-bar-clock.sh "EEE d MMM h:mm"`     | 
|              `Thu 11:46` | `./menu-bar-clock.sh "EEE h:mm"`           | 
|           `18 Aug 11:46` | `./menu-bar-clock.sh "d MMM h:mm"`         | 
|                  `11:46` | `./menu-bar-clock.sh "h:mm"`               | 