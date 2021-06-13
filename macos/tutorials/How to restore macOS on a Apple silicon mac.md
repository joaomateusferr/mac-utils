# How to restore macOS on a Apple silicon mac

**This is a real difficult to do, avoid if possible!**

**General instructions**
===

There are two ways to do this, the first is by creating a bootable usb drive and the second is using the Apple Configurator.

If the mac **frimewere is damaged** in any way only the method using **Apple Configurator** can be used.

!! When macoOS is installed on a mac Apple silicon using a **usb drive** the recovery is not overwritten so, when **the recovery version will not be the version installed** on the device.

There are two ways to overwrite the recovery of a apple silicon mac, through the method using the Apple Configurator or installing an update.

In case of downgrade between a standard and a **beta version** it is possible to remove the beta version and overwrite the recovery by unenrolling the device from the beta program, click on Details), waiting for a standard version to be launched and then install it through the macos software update.


##How to unenroll a mac from from macOS Beta Programs

1 - Navigate to the System Preferences from the Apple menu.

2 - Find and click on Software Update.

3 - Under the Software Update Gear (This Mac is enrolled in the Apple Beta Software Program), click on Details.

4 - On selecting Restore Defaults, you will no longer receive any beta software program updates.


##Bootable usb

1 - Download the macOS .app from the mac app store looking for the version name or from the version macOS links in the apple support article if the desired version is not the last one available.

2 - Connect usb drive to mac.

3 - Use the createinstallmedia command line utility which is found inside the .app form the macOS veriosn using the command bellow (the command execution may take a while).
```
#Generic example
sudo /Applications/Install\ macOS\ Version\ Name.app/Contents/Resources/createinstallmedia --volume /Volumes/VolumeName

#Example for the latest version
sudo /Applications/Install\ macOS\ Big\ Sur.app/Contents/Resources/createinstallmedia --volume /Volumes/usb
```

4 - Enter the recovery mode by pressing and holding the power button until device drives and options menu appear on the screen.

5 - Select the installation drive created earlier ().


Additional information!
---

Downgrade from macOS Monterey to Big Sur or Catalina on Intel and M1 Macs!: https://youtu.be/Ae_Vm39dxrA

How to create a bootable installer for macOS: https://support.apple.com/en-us/HT201372


##Apple Configurator 2

add instructions here ...


Additional information!
---

How To Set DFU Mode on M1 Apple Silicon MacBook - Reset Factory Settings: https://youtu.be/puL82I2B6Xk

Revive or restore a Mac with Apple silicon with Apple Configurator 2: https://support.apple.com/en-us/guide/apple-configurator-2/apdd5f3c75ad/mac

##Acknowledgements
===
Special thanks to Mr. Macintosh and Andrew Tsai for the videos found in the additional info section take a look at their youtube channels.


Mr. Macintosh: https://www.youtube.com/channel/UC7FRPWLwRlhORhFHHywfqAg

Andrew Tsai: https://www.youtube.com/channel/UCJ-hl32h5CokBhlGu95C1Xg