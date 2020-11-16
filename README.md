# menu-bar-clock

## Purpose

Set the date and time format of the menu bar clock from the command line in macOS Big Sur. 

## Instructions

1. [Download](https://github.com/tech-otaku/menu-bar-clock/archive/main.zip) menu-bar-clock.sh.

1. Double-click `~/Downloads/menu-bar-clock-main.zip` to unzip it (Safari may do this automatically). 

1. Open the Terminal application in macOS

1. At a Terminal prompt:

    1. type `cd ~/Downloads/menu-bar-clock-main` and press enter

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

## Background

Prior to macOS Big Sur 11.0, setting the [date and time format of the menu bar clock](https://www.tech-otaku.com/mac/setting-the-date-and-time-format-for-the-macos-menu-bar-clock-using-terminal/) from the command line was relatively trivial.

Challenges to setting the date and time format of the menu bar clock introduced in macOS Big Sur include:

- Additional keys in the `com.apple.menuextra.clock` domain.

- A (re-purposed?) *24-Hour Time* option in System Preferences which overrides time settings.

- The `SystemUIServer` process no longer appears responsible for displaying the date and time in the menu bar. 

<br />

### Additional Keys

In macOS Big Sur the structure of `com.apple.menuextra.clock.plist` has changed:

```
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>DateFormat</key>
	<string>h:mm a</string>
	<key>FlashDateSeparators</key>
	<false/>
	<key>IsAnalog</key>
	<false/>
	<key>Show24Hour</key>
	<false/>
	<key>ShowAMPM</key>
	<true/>
	<key>ShowDayOfMonth</key>
	<false/>
	<key>ShowDayOfWeek</key>
	<false/>
	<key>ShowSeconds</key>
	<false/>
</dict>
</plist>
```

The additional keys are `Show24Hour`, `ShowAMPM`, `ShowDayOfMonth`, `ShowDayOfWeek` and `ShowSeconds`. 

Prior to Big Sur, only the `DateFormat` key need be set using a single `defaults write` command. Now, multiple `defaults write` commands are required to set the `DateFormat` key together with the 5 additional keys. 

<br />

### *24-Hour Time* Option

This option can be found in System Preferences > Language & Region > General and may override the keys `Show24Hour` and `ShowAMPM` depending on their values. It is also used to format the display of dates and times in the Finder. This option existed in Catalina too, but doesn't appear to assert the same control as it does in Big Sur. 

While this option can be checked or unchecked from within System Preferences, it can be toggled from the command line using the `AppleICUForce12HourTime` key in the `.GlobalPreferences` domain.

When the option is *unchecked*, the `AppleICUForce12HourTime` key has a boolean value of `true`. When *checked*, the key is deleted from the `.GlobalPreferences` domain. 

Any attempt to set the date and time format from the command line should ensure that this key exists or not based on the values of the `Show24Hour` and `ShowAMPM` keys, or vice versa.

<br />

### `SystemUIServer` Process

Prior to Big Sur, restarting the `SystemUIServer` process updated the date and time format of the menu bar clock with any changes to the `DateFormat` key.

This is no longer true in Big Sur. The process that controls the menu bar clock is `ControlCenter` which needs to be restarted (killed) after changes have been made to the `com.apple.menuextra.clock` and `.GlobalPreferences` domains.  





