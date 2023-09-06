#!/bin/bash

#######################################################################
#CREATED BY:  ANNIE V LAM
#
#DATE:  2023-09-06
#
#PURPOSE:  To automate the ssh connection or the secure copy of files
#
#######################################################################

#Provide menu option to the user to select ssh or scp
echo "Please make a selection using the number option..."
echo " "
echo "1: ssh"
echo "2: scp"

# Prompt user to make a selection
read -p "Enter your selection (1 or 2): " user_selection

# User input for remote server username
echo " "
echo "Enter username..."
read -p "Enter Username: " user_name

# User input for remote server IP address
echo "Enter IP Address..."
read -p "Enter IP Address: " ip_address

# Set remote server connection
remote_server="$user_name@$ip_address"

# Give user the public key to save it to the remote server's authorized_keys file in the .ssh directory
echo "Save the following public key to the remote server's authorized_keys file in the .ssh directory:"
echo " "
sleep 3
cat /home/ubuntu/.ssh/id_rsa.pub
echo " "
sleep 3
echo "Press Enter to continue..."
read -r

# If user selected option 1, then ssh to the remote server
if [[ "$user_selection" -eq 1 ]]; then
    echo "Starting ssh connection to $remote_server..."
    ssh "$remote_server"
# If user selected option 2, provide menu option for direction of copy: remote to local or local to remote
elif [[ "$user_selection" -eq 2 ]]; then
    echo "Please make a selection for the direction of secure copy, using the following options..."
    echo "a: copy from remote server to current server"
    echo "b: copy from current server to remote server"

    # Prompt user to make direction selection
    read -p "Enter your selection (a or b): " copy_direction
    echo " "
    echo "Your selection is $copy_direction"

    # Ask for source file and destination file name
    echo " "
    echo "Enter the name of the source file including extension..."
    read -p "Enter source file name: " src_file
    echo " "
    echo "Enter the name of the destination file name including extension..."
    read -p "Enter destination file name: " dst_file
    echo " "

    # If the user gives the destination file name, keep that file name. If not, use the source file name
    if [ -z "$dst_file" ]; then
        dst_file="$src_file"
        echo "The destination file name is $dst_file"
    else
        echo "The destination file name is $dst_file"
    fi

    # Ask for absolute source directory and destination directory path
    echo " "
    echo "Enter the absolute directory path of the source..."
    read -p "Enter source directory: " src_directory

    echo " "
    echo "Enter the absolute directory path of the destination..."
    read -p "Enter destination directory: " dst_directory

    # If no destination location is provided, copy the file to the destination home directory with the same source file name
    if [ -z "$dst_directory" ]; then
        dst_directory="/home/ubuntu"
        echo "The destination directory is $dst_directory"
    else
        echo "The destination directory is $dst_directory"
    fi

    if [[ "$copy_direction" == "a" ]]; then
        echo " "
        echo "Copying from $remote_server:$src_directory/$src_file to current server $dst_directory/$dst_file"
        scp "$remote_server:$src_directory/$src_file" "$dst_directory/$dst_file"
    elif [[ "$copy_direction" == "b" ]]; then
        echo " "
        echo "Copying from current server $src_directory/$src_file to $remote_server:$dst_directory/$dst_file"
        scp "$src_directory/$src_file" "$remote_server:$dst_directory/$dst_file"

    #Error handling if user did not select a or b
    else
        echo " "
        echo "Incorrect selection, option was a - copy from remote server to current server or b - copy from current server to remote server"
    fi
#Error handing if user did not select 1 or 2
else
    echo " "
    echo "Incorrect selection: selection option was 1 - ssh or 2 - scp."
fi


















