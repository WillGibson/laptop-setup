# Laptop Setup

Just intended to automate as many of the commands I run to set up a new MacBook for developing as possible, trying to get away from copying them one by one from a note I have with them all in.

The intention is not to provide the fastest way to do this, but to provide a reliable idempotent way to setup a new MacBook and, as far as possible, update all the things as time goes by.

Over time it is hoped that it will become more flexible and maybe work for more people than just me :-)

Massive thanks to [Homebrew](https://brew.sh/), which is heavily leveraged here.

## Installation

On a fresh laptop you can just download the zip from GitHub and run it from there as you probably don't have Git yet.

After that it's probably best to delete those files and clone this repository to the same path as they were.

## Running the setup

Before you start the first time, export these variables in your terminal...

    export GIT_USER_NAME "<your name>"
    export GIT_USER_EMAIL "<your email address>"

If you have Docker running, please quit it.

Then you can run the script, but be aware you may be prompted for your password here and there when elevated privileges are required.

    ./src/setup.sh

## Configuration

By default everything is installed. If that's not what you need, create a `.config.json` file based on `config.json.example` which contains all the available options.

## Adding your own commands

If you need a bit more you can add additional commands to`.config.json` to be run at the beginning and end of the process. See the `additionalCommands` section in `config.json.example`.

## What it won't do for you (yet)

You will need to do the following manually...

* Create your GPG key or copy it from elsewhere to set up signed Git commits. See https://stackoverflow.com/a/55646482/2152144 and https://anh.do/blog/gpg-catalina
* Use TouchID to elevate privileges in terminal. Add `auth       sufficient     pam_tid.so` to `/etc/pam.d/sudo`.

## Troubleshooting

If you use this tool on a machine which has already had some of the things installed manually, it can get a bit tricky with permissions here and there.

E.g. If it fails trying to delete an existing app from `/Applications` due to permissions, you might need to `sudo rm -rf /Applications/OffendingApp.app` to get rid of the one which is not managed with Homebrew
