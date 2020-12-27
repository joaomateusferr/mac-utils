#How to use

Payload
    1 - Copy the files that you want to put in the package to the payload folder (if nothing is placed in the payload folder a package containing only the scripts will be created)
    2 - Change the LOCATION variable if you want to place your files in another location.

Scripts
    1 - Create the file with the desired name (preinstall or postinstall) without using extensions.
    2 - Create the file with the following structure:
        #!/bin/sh
        YOUR CODE HERE
    3 - Copy these files to the scripts folder. (be aware that they will be converted to executable files backup the files if necessary)