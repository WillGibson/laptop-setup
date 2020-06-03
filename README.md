# Laptop Setup

Just intended to automate as many of the commands I run to set up a new MacBook for developing as possible, trying to get away from copying them one by one from a note I have with them all in.

Created for my purposes really, not trying to solve this for everyone, but if it's any help to anyone else, then great :-)

## Installation

On a fresh laptop you can just download the zip from GitHub and run it from there as you probably don't have Git yet. After that it's probably best to clone this repository.

## Running the setup

Before you start the first time, export these variables in your terminal...

    export GIT_USER_NAME "<your name>"
    export GIT_USER_EMAIL "<your email address>"

Then you can run the script, but be aware that you may be prompted for your password, e.g. when changing the shell to ZSH.

    ./src/setup.sh

## What it won't do for you

You will need to do the following manually...

* Create your SSH key pair or copy it from elsewhere
