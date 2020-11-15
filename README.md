# menu-bar-clock

## Purpose

Set the date and time format of the Menu Bar clock from the command line in macOS Big Sur. 

## Background

Refer to [macOS Big Sur and the Menu Bar Date & Time Format](https://www.tech-otaku.com/mac/setting-the-date-and-time-format-for-the-macos-menu-bar-clock-using-terminal/#big-sur)

## Instructions

1. [Download](https://github.com/tech-otaku/menu-bar-clock/archive/main.zip) menu-bar-clock.sh

1. Open the Terminal application in macOS

1. At a Terminal prompt:

    1. type `cd /path/to/script/file` and press enter

    1. type `chmod +x menu-bar-clock.sh` and press enter to make the script executable

    1. use one of the commands under the *Command Line* heading in the table below to set the required date and time format.  


## Usage

| Date & Time              | Command Line                               | 24-Hour Time <sup>1</sup> |
|-------------------------:|:-------------------------------------------|:------------:|
|    `Thu 18 Aug 23:46:18` | `./menu-bar-clock.sh "EEE d MMM HH:mm:ss"` | checked      |
|           `Thu 23:46:18` | `./menu-bar-clock.sh "EEE HH:mm:ss"`       | checked      |
|        `18 Aug 23:46:18` | `./menu-bar-clock.sh "d MMM HH:mm:ss"`     | checked      |
|               `23:46:18` | `./menu-bar-clock.sh "HH:mm:ss"`           | checked      |
| `Thu 18 Aug 11:46:18 pm` | `./menu-bar-clock.sh "EEE d MMM h:mm:ss a"`| unchecked    |
|        `Thu 11:46:18 pm` | `./menu-bar-clock.sh "EEE h:mm:ss a"`      | unchecked    |
|     `18 Aug 11:46:18 pm` | `./menu-bar-clock.sh "d MMM h:mm:ss a"`    | unchecked    |
|            `11:46:18 pm` | `./menu-bar-clock.sh "h:mm:ss a"`          | unchecked    |
|    `Thu 18 Aug 11:46:18` | `./menu-bar-clock.sh "EEE d MMM h:mm:ss"`  | unchecked    |
|           `Thu 11:46:18` | `./menu-bar-clock.sh "EEE h:mm:ss"`        | unchecked    |
|        `18 Aug 11:46:18` | `./menu-bar-clock.sh "d MMM h:mm:ss"`      | unchecked    |
|               `11:46:18` | `./menu-bar-clock.sh "h:mm:ss"`            | unchecked    |
|       `Thu 18 Aug 23:46` | `./menu-bar-clock.sh "EEE d MMM HH:mm"`    | checked      |
|              `Thu 23:46` | `./menu-bar-clock.sh "EEE HH:mm"`          | checked      |
|           `18 Aug 23:46` | `./menu-bar-clock.sh "d MMM HH:mm"`        | checked      |
|                  `23:46` | `./menu-bar-clock.sh "HH:mm"`              | checked      |
|    `Thu 18 Aug 11:46 pm` | `./menu-bar-clock.sh "EEE d MMM h:mm a"`   | unchecked    |
|           `Thu 11:46 pm` | `./menu-bar-clock.sh "EEE h:mm a"`         | unchecked    |
|        `18 Aug 11:46 pm` | `./menu-bar-clock.sh "d MMM h:mm a"`       | unchecked    |
|               `11:46 pm` | `./menu-bar-clock.sh "h:mm a"`             | unchecked    |
|       `Thu 18 Aug 11:46` | `./menu-bar-clock.sh "EEE d MMM h:mm"`     | unchecked    |
|              `Thu 11:46` | `./menu-bar-clock.sh "EEE h:mm"`           | unchecked    |
|           `18 Aug 11:46` | `./menu-bar-clock.sh "d MMM h:mm"`         | unchecked    |
|                  `11:46` | `./menu-bar-clock.sh "h:mm"`               | unchecked    |

<br />

<sup>**1**</sup> *24-Hour Time* refers to the option in System Preferences > Language & Region > General that must be manually checked or unchecked to ensure the required date and time format is displayed correctly.