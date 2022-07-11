# menu-bar-clock

[^1]: Since macOS Monterey 12.4.

Compatible with macOS Big Sur 11 and later.

~~IMPORTANT: Until I have the opportunity to fix it, please note that [changes in macOS Monterey 12.4 have temporarily broken this script](https://github.com/tech-otaku/menu-bar-clock/issues/9).~~

## Purpose

Set the date and time format of the menu bar clock from the command line in macOS Big Sur 11 and later. 

Please note, the script simply mimics what can otherwise be achieved by setting the format through System Preferences. It is therefore limited to the formats defined by Apple.

## Instructions

1. Download [menu-bar-clock-main.zip](https://github.com/tech-otaku/menu-bar-clock/archive/main.zip) 

1. Double-click `~/Downloads/menu-bar-clock-main.zip` in the Finder to unzip it (Safari may do this automatically)

1. Open the Terminal application in macOS

1. At a Terminal prompt:

    1. type `cd ~/Downloads/menu-bar-clock-main` and press enter

    1. type `chmod +x menu-bar-clock.sh` and press enter to make the script executable

    1. use one of the commands under the *Command Line* heading in the table below to set the required date and time format

## Changes in macOS Monterey 12.4

Starting with macOS Monterey 12.4, Apple have made changes to the *Show date* option in System Preferences > Dock & Menu Bar > Clock. Previously, it was either checked or unchecked and set the value of the `ShowDayOfMonth` key in the `com.apple.menuextra.clock` domain to either `true` or `false` respectively. This key now appears redundant. Instead, the *Show date* option offers 3 new choices which are written to a new key in the `com.apple.menuextra.clock` domain named `ShowDate`.

| *Show date*       | `ShowDate` |
|-------------------|-----------:|
| when space allows |        `0` |
| always            |        `1` |
| never             |        `2` |


## Usage

To support the changes to the *Show date* option in macOS Monterey 12.4, the script accepts a new option: `-s`. The option need only be passed to the script when the desired date format contains `d MMM` i.e. `18 Aug` **and** you want that date portion displayed *when space allows*. In all other circumstances it can be omitted, as per the table below. 
If the option is passed to the script it will be ignored when the date format doesn't contain `d MMM` or the installed macOS version is macOS Monterey 12.3.1 or earlier or macOS Big Sur 11.

| Menu Bar Clock           | Show date [^1] | Command Line                               | 
|-------------------------:|:------------------|:----------------------------------------------|
|    `Thu 18 Aug 23:46:18` | always            | `./menu-bar-clock.sh "EEE d MMM HH:mm:ss"`    |
|    `Thu 18 Aug 23:46:18` | when space allows | `./menu-bar-clock.sh "EEE d MMM HH:mm:ss" -s` | 
|           `Thu 23:46:18` | N/A               | `./menu-bar-clock.sh "EEE HH:mm:ss"`          | 
|        `18 Aug 23:46:18` | always            | `./menu-bar-clock.sh "d MMM HH:mm:ss"`        | 
|        `18 Aug 23:46:18` | when space allows | `./menu-bar-clock.sh "d MMM HH:mm:ss" -s`     |
|               `23:46:18` | N/A               | `./menu-bar-clock.sh "HH:mm:ss"`              | 
| `Thu 18 Aug 11:46:18 pm` | always            | `./menu-bar-clock.sh "EEE d MMM h:mm:ss a"`   | 
| `Thu 18 Aug 11:46:18 pm` | when space allows | `./menu-bar-clock.sh "EEE d MMM h:mm:ss a" -s`|
|        `Thu 11:46:18 pm` | N/A               | `./menu-bar-clock.sh "EEE h:mm:ss a"`         | 
|     `18 Aug 11:46:18 pm` | always            | `./menu-bar-clock.sh "d MMM h:mm:ss a"`       | 
|     `18 Aug 11:46:18 pm` | when space allows | `./menu-bar-clock.sh "d MMM h:mm:ss a" -s`    | 
|            `11:46:18 pm` | N/A               | `./menu-bar-clock.sh "h:mm:ss a"`             | 
|    `Thu 18 Aug 11:46:18` | always            | `./menu-bar-clock.sh "EEE d MMM h:mm:ss"`     | 
|    `Thu 18 Aug 11:46:18` | when space allows | `./menu-bar-clock.sh "EEE d MMM h:mm:ss" -s`  | 
|           `Thu 11:46:18` | N/A               | `./menu-bar-clock.sh "EEE h:mm:ss"`           | 
|        `18 Aug 11:46:18` | always            | `./menu-bar-clock.sh "d MMM h:mm:ss"`         | 
|        `18 Aug 11:46:18` | when space allows | `./menu-bar-clock.sh "d MMM h:mm:ss" -s`      |
|               `11:46:18` | N/A               | `./menu-bar-clock.sh "h:mm:ss"`               | 
|       `Thu 18 Aug 23:46` | always            | `./menu-bar-clock.sh "EEE d MMM HH:mm"`       | 
|       `Thu 18 Aug 23:46` | when space allows | `./menu-bar-clock.sh "EEE d MMM HH:mm" -s`    |
|              `Thu 23:46` | N/A               | `./menu-bar-clock.sh "EEE HH:mm"`             | 
|           `18 Aug 23:46` | always            | `./menu-bar-clock.sh "d MMM HH:mm"`           |
|           `18 Aug 23:46` | when space allows | `./menu-bar-clock.sh "d MMM HH:mm" -s`        | 
|                  `23:46` | N/A               | `./menu-bar-clock.sh "HH:mm"`                 | 
|    `Thu 18 Aug 11:46 pm` | always            | `./menu-bar-clock.sh "EEE d MMM h:mm a"`      |
|    `Thu 18 Aug 11:46 pm` | when space allows | `./menu-bar-clock.sh "EEE d MMM h:mm a" -s`   | 
|           `Thu 11:46 pm` | N/A               | `./menu-bar-clock.sh "EEE h:mm a"`            | 
|        `18 Aug 11:46 pm` | always            | `./menu-bar-clock.sh "d MMM h:mm a"`          |
|        `18 Aug 11:46 pm` | when space allows | `./menu-bar-clock.sh "d MMM h:mm a" -s`       | 
|               `11:46 pm` | N/A               | `./menu-bar-clock.sh "h:mm a"`                | 
|       `Thu 18 Aug 11:46` | always            | `./menu-bar-clock.sh "EEE d MMM h:mm"`        |
|       `Thu 18 Aug 11:46` | when space allows | `./menu-bar-clock.sh "EEE d MMM h:mm" -s`     | 
|              `Thu 11:46` | N/A               | `./menu-bar-clock.sh "EEE h:mm"`              | 
|           `18 Aug 11:46` | always            | `./menu-bar-clock.sh "d MMM h:mm"`            | 
|           `18 Aug 11:46` | when space allows | `./menu-bar-clock.sh "d MMM h:mm" -s`         |
|                  `11:46` | N/A               | `./menu-bar-clock.sh "h:mm"`                  | 

<br />

The **Menu Bar Clock** values in the table above are localised and based on a *Region* setting of *United Kingdom* in System Preferences > Language & Region > General. Other *Regions* may display the same date and time format differently. For example, the format `"EEE d MMM HH:mm"` is displayed differently for the following *Region* settings:

| Region Setting | Display               |
|----------------|-----------------------|
| United Kingdom | `Thu 18 Aug 23:46`    |
| United States  | `Thu Aug 28 23:46`    |
| France         | `Thu 28 Aug at 23:46` |
| Germany        | `Thu 28. Aug 23:46`   |
| Czechia        | `Thu 28. 8. 23:46`    |

In addition, the primary preferred language setting also in System Preferences > Language & Region > General [may affect how the date and time is displayed](https://github.com/tech-otaku/menu-bar-clock/issues/8#issuecomment-1019289477).

## Background

Prior to macOS Big Sur 11, setting the [date and time format of the menu bar clock](https://www.tech-otaku.com/mac/setting-the-date-and-time-format-for-the-macos-menu-bar-clock-using-terminal/) from the command line was relatively trivial.

Challenges to setting the date and time format of the menu bar clock introduced in macOS Big Sur 11 include:

- Additional keys in the `com.apple.menuextra.clock` domain.

- A (re-purposed?) *24-Hour Time* option in System Preferences which overrides time settings.

- The `SystemUIServer` process no longer appears responsible for displaying the date and time in the menu bar. 



### Additional Keys

In macOS Big Sur 11 and later, the structure of `com.apple.menuextra.clock.plist` has changed:

```
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>DateFormat</key>
	<string>EEE d MMM HH:mm</string>
	<key>FlashDateSeparators</key>
	<false/>
	<key>IsAnalog</key>
	<false/>
	<key>Show24Hour</key>
	<true/>
	<key>ShowAMPM</key>
	<false/>
	<key>ShowDate</key>         <--- New key as of macOS Monterey 12.4
	<integer>0</integer>
	<key>ShowDayOfMonth</key>   <--- Appears redundant as of macOS Monterey 12.4
	<true/>
	<key>ShowDayOfWeek</key>
	<true/>
	<key>ShowSeconds</key>
	<false/>
</dict>
</plist>
```

<br />

The additional keys are `Show24Hour`, `ShowAMPM`, `ShowDate` [^1], ~~`ShowDayOfMonth`~~[^1], `ShowDayOfWeek` and `ShowSeconds`. 

Prior to macOS Big Sur 11, only the `DateFormat` key need be set using a single `defaults write` command. Now, multiple `defaults write` commands are required to set the `DateFormat` key together with the 5 additional keys. 


### *24-Hour Time* Option

This option can be found in System Preferences > Language & Region > General and may override the keys `Show24Hour` and `ShowAMPM` depending on their values. It is also used to format the display of dates and times in the Finder. This option exists in Catalina too, but doesn't appear to assert the same control as it does in macOS Big Sur 11 and later. 

While this option can be checked or unchecked from within System Preferences, it can be toggled from the command line using the `AppleICUForce12HourTime` key in the `.GlobalPreferences` domain.

When the option is *unchecked*, the `AppleICUForce12HourTime` key has a boolean value of `true`. When *checked*, the key is deleted from the `.GlobalPreferences` domain. 

Any attempt to set the date and time format from the command line should ensure that this key exists or not based on the values of the `Show24Hour` and `ShowAMPM` keys, or vice versa.


### SystemUIServer Process

Prior to macOS Big Sur 11, restarting the `SystemUIServer` process updated the date and time format of the menu bar clock with any changes to the `DateFormat` key.

This is no longer true in macOS Big Sur 11 and later. The process that controls the menu bar clock is `ControlCenter` which needs to be restarted (killed) after changes have been made to the `com.apple.menuextra.clock` and `.GlobalPreferences` domains. 





