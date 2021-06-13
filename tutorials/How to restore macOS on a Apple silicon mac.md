# How to restore/revive or change macOS versions on a Apple silicon mac

:exclamation: | In case you can choose a specific model to use as a beta test device the macs mini or imacs are more suitable as it is easier to set the device into DFU mode.
:---: | :---

:warning: | If the mac frimewere is damaged in any way only the method using Apple Configurator 2 can be used.
:---: | :---

:information_source: | There are two ways to overwrite the recovery of a apple silicon mac, through the method using the Apple Configurator or installing an update.
:---: | :---

:information_source: | In case of downgrade between a standard and a beta version it is possible to remove the beta version and overwrite the recovery by unenrolling the device from the beta program, click on Details), waiting for a standard version to be launched and then install it through the macos software update.
:---: | :---

:information_source: | There are three ways to change the macOS version, the first one is unenrolling a mac from from macOS Beta Program and wait for an update (applicable to beta version only) the second is by using a bootable usb drive and the is the last one is using the Apple Configurator 2.
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


## Reinstall macOS using a bootable usb drive

:warning: | When macoOS is installed on a mac Apple silicon using a usb drive the recovery is not overwritten so, when the recovery version will not be the version installed on the device, if you want to overwrite recovery use the Apple Configurator 2 method.
:---: | :---

:warning: | The mac will need to be connected to the internet during the installation for the mac to be activated.
:---: | :---

:information_source: | There is no external boot protection on Apple silicon macs so, you can boot directly from the usb drive without having to change any settings.
:---: | :---

1 - Download the macOS .app from the mac app store looking for the version name or from the version macOS links in the apple support article if the desired version is not the last one available.

2 - Connect usb drive to mac.

3 - Use the createinstallmedia command line utility which is found inside the .app form the macOS veriosn using the command bellow (the command execution may take a while and keep in mind that all data contained in the usb drive will be erased).

**Generic example**
```
sudo /Applications/Install\ macOS\ Version\ Name.app/Contents/Resources/createinstallmedia --volume /Volumes/USBVolumeName
```

**Example for the latest version**
```
sudo /Applications/Install\ macOS\ Big\ Sur.app/Contents/Resources/createinstallmedia --volume /Volumes/usb
```

4 - Enter the recovery mode by pressing and holding the power button until device drives and options menu appear on the screen.

5 - Select the installation drive created earlier.

6 - Open disk utility

7 - In case the view mode is in partitions click on view in the upper left corner of the screen and change to show the device disks.

8 - Select the disk where macOS will be installed.

9 - Erase the selected disk using APFS.

10 - Close disk utility.

11 - After the disk is erased on mac it will be activated automatically.

12 - Open install mac OS.

13 - Follow the installation process steps to the end.

14 - Configure the initial settings in setup assistant.

### Additional information

Downgrade from macOS Monterey to Big Sur or Catalina on Intel and M1 Macs!: https://youtu.be/Ae_Vm39dxrA

How to create a bootable installer for macOS: https://support.apple.com/en-us/HT201372


## Revive macOS using Apple Configurator 2

:exclamation: | This is a real difficult and take some time to do, avoid if possible.
:---: | :---

:warning: | When the mac goes into DFU mode it will not turn on normally until the reinstall starts, if you want to turn on the device normally without reinstalling the macOS to take the device out of DFU mode just repeat the sequence used to get into DFU mode again.
:---: | :---

:warning: | There are non-apple compatible cables, but to avoid compatibility problems use the apple USB C to USB C cable that comes with the macs.
:---: | :---

:information_source: | To install other versions than the last available you can download the IPSW (check the IPSW sources below) of the desired version and just drag the file to the device in DFU mode inside the apple configurator 2 and then select the revive option.
:---: | :---

1 - Install Apple Configurator 2 on the working mac.

2 - Connect the working mac to the mac you want to reinstall the macs to using its recovery port (check the apple article below to  recovery port).

3 - Turn off the mac you want to install the macs in case it is on.

4 - Set the mac you want to reinstall the macOS into DFU mode (check the apple article below to find what is the recovery port on your specific model).

5 - In case everything works fine, on the working mac you will see a square written DFU in Apple Configurator 2 (there will be no feedback on mac where you want to reinstall macs).

6 - In apple configurator right click on the device which is in DFU mode.

7 - Select advanced options.

8 - Select Revive Device.

9 - The apple configurator will download the macOS latest IPSW and start installing.

10 - Wait for the installation process to finish.

11 - The mac will activated automatically.

12 - Configure the initial settings in setup assistant.

### Additional information

How To Set DFU Mode on M1 Apple Silicon MacBook - Reset Factory Settings: https://youtu.be/puL82I2B6Xk

Revive or restore a Mac with Apple silicon with Apple Configurator 2: https://support.apple.com/en-us/guide/apple-configurator-2/apdd5f3c75ad/mac

IPSW Download: https://ipsw.me/product/Mac


## Acknowledgements

Thanks to Jaysukh Patel, Mr. Macintosh and Andrew Tsai for the tutorials found in the additional info sections.