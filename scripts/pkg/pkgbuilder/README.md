**How to use**
===


Payload
---
1 - Copy the files that you want to put in the package to the payload folder (if nothing is placed in the payload folder a package containing only the scripts will be created)

2 - Change the LOCATION variable if you want to place your files in another location.


Scripts
---

1 - Create the file with the desired name (preinstall or postinstall) without using extensions.

2 - Create the file with the following structure:

```
#!/bin/sh
YOUR CODE HERE
```

3 - Copy these files to the scripts folder. (be aware that they will be converted to executable files backup the files if necessary)

**Developer notes**
===

In the case of a package containing .app files, usually the LOCATION parameter that should be used is /Applications/

In case the BUNDLE_IS_RELOCATABLE parameter is 0 if the .app already exists on the mac, the LOCATION parameter will be ignored and the .app will be replaced at the location it is on the mac

Otherwise, the .app will be placed at the location specified in the LOCATION parameter independent where this .app is located on the mac

In case you want to sign a package the Developer ID Installer certificate has to be installed on the mac that is running this script for it to work properly.

To find out how to have your Developer ID Installer certificate and learn more about the Mac Gatekeeper check the link https://developer.apple.com/developer-id/.

The DEVELOPER_ID_INSTALLER parameter must contain only the id following the pattern *******.

**PS:** Not tested on  Apple Silicon mac yet!