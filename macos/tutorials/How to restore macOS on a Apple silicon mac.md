# How to restore/reinstall or change macOS versions on a Apple silicon mac

:warning: | If the mac frimewere is damaged in any way only the method using Apple Configurator 2 can be used.
:---: | :---

:information_source: | There are two ways to overwrite the recovery of a apple silicon mac, through the method using the Apple Configurator or installing an update.
:---: | :---

:information_source: | In case of downgrade between a standard and a beta version it is possible to remove the beta version and overwrite the recovery by unenrolling the device from the beta program, click on Details), waiting for a standard version to be launched and then install it through the macos software update.
:---: | :---

:information_source: | There are three ways to change the macOS version, the first one is unenrolling a mac from from macOS Beta Program and wait for an update (applicable to beta version only) the second is by creating a bootable usb drive and the is the last one is using the Apple Configurator 2.
:---: | :---


## Unenroll a mac from from macOS Beta Program and wait for an update

1 - Navigate to the System Preferences from the Apple menu.

2 - Find and click on Software Update.

3 - Under the Software Update Gear (This Mac is enrolled in the Apple Beta Software Program), click on Details.

4 - On selecting Restore Defaults, you will no longer receive any beta software program updates.

5 - Your Mac will ask to enter the Mac login Password. Once you verify the login passcode, Beta Updates will be removed automatically.

6 - Waiting for a standard macOS version to be launched and then install it through software update.

### Additional information

How to Unenroll macOS Monterey Beta on MacBook Pro/Air, Mac: https://www.howtoisolve.com/how-to-unenroll-macos-beta-on-macbook-pro-air-mac-updated/


## Bootable usb

:warning: | When macoOS is installed on a mac Apple silicon using a usb drive the recovery is not overwritten so, when the recovery version will not be the version installed on the device, if you want to overwrite recovery use the Apple Configurator 2 method.
:---: | :---

1 - Download the macOS .app from the mac app store looking for the version name or from the version macOS links in the apple support article if the desired version is not the last one available.

2 - Connect usb drive to mac.

3 - Use the createinstallmedia command line utility which is found inside the .app form the macOS veriosn using the command bellow (the command execution may take a while and keep in mind that all data contained in the usb drive will be erased).
```
#Generic example
sudo /Applications/Install\ macOS\ Version\ Name.app/Contents/Resources/createinstallmedia --volume /Volumes/VolumeName

#Example for the latest version
sudo /Applications/Install\ macOS\ Big\ Sur.app/Contents/Resources/createinstallmedia --volume /Volumes/usb
```

4 - Enter the recovery mode by pressing and holding the power button until device drives and options menu appear on the screen.

5 - Select the installation drive created earlier ().

### Additional information

Downgrade from macOS Monterey to Big Sur or Catalina on Intel and M1 Macs!: https://youtu.be/Ae_Vm39dxrA

How to create a bootable installer for macOS: https://support.apple.com/en-us/HT201372


## Apple Configurator 2

:exclamation: | This is a real difficult to do, avoid if possible.
:---: | :---

add instructions here ...

### Additional information

How To Set DFU Mode on M1 Apple Silicon MacBook - Reset Factory Settings: https://youtu.be/puL82I2B6Xk

Revive or restore a Mac with Apple silicon with Apple Configurator 2: https://support.apple.com/en-us/guide/apple-configurator-2/apdd5f3c75ad/mac


## Acknowledgements

Thanks to Jaysukh Patel, Mr. Macintosh and Andrew Tsai for the tutorials found in the additional info sections.