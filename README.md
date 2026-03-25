# Laptop Setup

Just something I run to set up a new MacBook for developing as possible.

The intention is not to provide the fastest way to do this, but to provide a reliable idempotent way to setup a new MacBook and, as far as possible, update all the things as time goes by.

Over time it is hoped that it will become more flexible and maybe work for more people than just me :-)

Massive thanks to [Homebrew](https://brew.sh/) and [asdf](https://asdf-vm.com/), which are heavily leveraged here.

## Installation

On a fresh laptop you can just download the zip from GitHub and run it from there as you probably don't have Git yet.

After that it's best to delete those files and clone this repository to the same path as they were.

## Running the setup

Before you start the first time, export these variables in your terminal...

```shell
export GIT_USER_NAME="<your name>" \
    GIT_USER_EMAIL="<your (maybe private GitHub) email address>" \
    SSH_USER_EMAIL="<your email address>"
```

If you have Docker running, please quit it.

Then you can run the script, but be aware you may be prompted for your password here and there when elevated privileges are required.

```shell
./src/setup.sh
```

## Configuration

You need to create a `.config.json` file based on `config.json.example` which contains all the available options.

## Adding your own commands

If you need a bit more you can add additional commands to`.config.json` to be run at the beginning and end of the process. See the `additionalCommands` section in `config.json.example`.

## Secrets and personal environment variables

The setup configures your shell to automatically source `~/.envrc` if it exists. This file is not managed by this tool, so it's a good place to put secrets, API keys, and personal environment variables that you don't want to commit to any repository.

For example:

```bash
export MY_API_KEY="..."
export SOME_SECRET_TOKEN="..."
```

Just create `~/.envrc` with whatever exports you need, and they will be available in every new terminal session.

## What it won't do for you (yet)

You will need to do the following manually...

* If you want to use GPG encryption: Create your GPG key or copy it from elsewhere to set up signed Git commits. See https://stackoverflow.com/a/55646482/2152144 and https://anh.do/blog/gpg-catalina
* If you want to use TouchID to elevate privileges in terminal: Add `auth       sufficient     pam_tid.so` to `/etc/pam.d/sudo`.
* Disable boot on lid open or power plugged in `sudo nvram AutoBoot=%00`. Note that this may not work on M1 MacBooks.

## Troubleshooting

If you use this tool on a machine which has already had some of the things installed manually, it can get a bit tricky with permissions here and there.

E.g. If it fails trying to delete an existing app from `/Applications` due to permissions, you might need to `sudo rm -rf /Applications/OffendingApp.app` to get rid of the one which is not managed with Homebrew

## Local development

Ensure you have [asdf](https://asdf-vm.com/) installed.

Run...

```shell
make setup
```
