#!/bin/bash

# Automatically add default SSH key, generating if required

temp="$(cat ~/.ssh/id_rsa.pub)";
sshKeyComment="${temp##* }";

if [ "$sshKeyComment" == "" ]; then
    echo "Creating default SSH key.."
    echo "N.B. If the email for the comment is wrong, exit and run it manually"
    command="ssh-keygen -t rsa -b 4096 -C \"$GIT_USER_EMAIL\""
    echo "$command"
    $command
fi

grepResult="$(ssh-add -l | grep "$sshKeyComment")";

if [ "$grepResult" == "" ]; then
    echo "Adding default SSH key..."
    ssh-add
fi
