# Laptop Setup

Just intended to automate as many of the commands I run to set up a new MacBook for developing as possible, trying to get away from copying them one by one from a note I have with them all in.

The intention is not to provide the fastest way to do this, but to provide a reliable idempotent way to setup a new MacBook and, as far as possible, update all the things as time goes by. This last part is why Homebrew commands are largely `reinstall` etc.

Over time it is hoped that it will become more flexible and maybe work for more people than just me :-)

Massive thanks to [Homebrew](https://brew.sh/), which is heavily leveraged here.

## Installation

On a fresh laptop you can just download the zip from GitHub and run it from there as you probably don't have Git yet. After that it's probably best to clone this repository.

## Running the setup

Before you start the first time, export these variables in your terminal...

    export GIT_USER_NAME "<your name>"
    export GIT_USER_EMAIL "<your email address>"

Then you can run the script, but be aware that you may be prompted for your password, e.g. when changing the shell to ZSH, fact there a few points where you will be asked for some input.

    ./src/setup.sh

## What it won't do for you yet

You will need to do the following manually...

* [Create your SSH key pair](https://docs.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#generating-a-new-ssh-key) or copy it from elsewhere
* Create your GPG key or copy it from elsewhere to set up signed Git commits. See https://stackoverflow.com/a/55646482/2152144 and https://anh.do/blog/gpg-catalina
* Install DisplayLink drivers

## Troubleshooting

If it fails trying to delete an existing app from `/Applications` due to permissions, you might need to `sudo rm -rf /Applications/Offending\ App.app` to get rid of the one which is not managed with Homebrew
