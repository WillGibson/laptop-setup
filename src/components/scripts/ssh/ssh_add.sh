#!/bin/bash

# Check default key exists
temp="$(cat ~/.ssh/id_rsa.pub)";
sshKeyComment="${temp##* }";
if [ "$sshKeyComment" == "" ]; then
    echo "Creating default SSH key... Rerun \"source ~/.zshrc\" when it's done."
    echo "N.B. If the email for the comment is wrong, exit and run it manually"
    command="ssh-keygen -t rsa -b 4096 -C \"$GIT_USER_EMAIL\""
    echo "$command"
    $command
fi

# Suggest rotating key if older than 3 months
days=$(( ( $(gdate '+%s') - $(gdate -d '3 months ago' '+%s') ) / 86400 ))
if [ "$(find ~/.ssh/id_rsa.pub -mtime +$days -type f)" != "" ]; then
    echo -e "\nYour default SSH key is more than 3 months old."
    echo "When you have time to update it in the places it will inevitably need updating, we suggest you run the following command..."
    echo -e "\nrm -f ~/.ssh/id_rsa ~/.ssh/id_rsa.pub && source ~/.zshrc\n"
fi

# Add default key
# eval "$(ssh-agent)"
grepResult="$(ssh-add -l)";
if [ "$grepResult" == "The agent has no identities." ]; then
    echo "Adding default SSH key..."
    # eval "$(ssh-agent)"
    ssh-add
fi
