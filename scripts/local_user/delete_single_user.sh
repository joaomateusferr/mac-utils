USER_ACC_NAME=$1

if [ $EUID -ne 0 ]; then #delete users and user's folder equire root privileges
    echo 'No root privileges detected!'
    echo 'Please, run this script as root'
else

    #check if the user exists here

    /usr/bin/dscl . -delete "/Users/$USER_ACC_NAME";

    if [ $? -eq 0 ] ; then
        echo "account $USER_ACC_NAME - deleted"
    else 
        echo "Error while deleting $USER_ACC_NAME"    
    fi

    if [ -e "/Users/$USER_ACC_NAME" ]; then 
        
        rm -rf "/Users/$USER_ACC_NAME";

        if [ $? -eq 0 ] ; then
            echo "/Users/$USER_ACC_NAME - deleted"
        else 
            echo "Error while deleting /Users/$USER_ACC_NAME"    
        fi
    fi

fi