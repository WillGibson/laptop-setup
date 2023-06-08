# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [1.16.0] - 2023-06-08
### Added
- Install tfenv and latest version of Terraform
- Install checkov
- Install AWS Copilot CLI
- Install tflint
### Changed
- Install pyenv and latest version of Python 3
- Don't install latest version of Node.js on a config only run

## [1.15.1] - 2023-03-20
### Fixed
- Set the required Homebrew environment variables in all new terminal sessions
- Don't try to output the current namespace if there is no `~/.kube/config`

## [1.15.0] - 2023-02-02
### Added
- Allow for a config only run
- Cater for using private GitHub email
### Fixed
- Handle usernames which include spaces
- Get Cellar and NVM directories dynamically
- Make SSH work in MacOS 13/Ventura
- Make the using Kubernetes namespace thing work

## [1.14.0] - 2022-11-02
### Added
- Install Git Large File Storage

## [1.13.0] - 2022-09-08
### Added
- Install Java 17
- Install jenv
- Source rvm in the shell
### Changed
- Stop Homebrew auto updating everything when you just want to install one small thing
# Removed
- Stop installing rbenv (I prefer rvm)
### Fixed
- Remove the python unlink that pointed to a version which didn't exist
- Disable Docker Buildkit
- Make the krew PATH export not expand the variables 
- Make the additional commands bit actually work
- Make the pipeline work again :-)

## [1.12.0] - 2021-11-24
### Added
- Install latest version of curl
- Install watch
### Fixed
- Update Spring Boot install
- Correct the git repository check in pull_latest_laptop_setup_code()
- Replace deprecated homebrew install command
- Remove unreached code renew SSH key and update output accordingly

## [1.11.0] - 2021-08-18
### Added
- Suggest rotating SSH key if it's older than 3 months

## [1.10.1] - 2021-08-18
### Fixed
- Switch back to using --cask for Docker

## [1.10.0] - 2021-08-17
### Added
- Use kubectl ohmyzsh plugin
- Install krew
- Install coreutils
### Changed
- Separate docker and kubernetes installs
- Switch to using Docker formula

## [1.9.0] - 2021-02-03
### Added
- Install Rectangle

## [1.8.0] - 2021-01-22
### Added
- Install Brave browser

## [1.7.0] - 2021-01-20
### Added
- Add `gtp` git trigger pipeline alias
### Changed
- Make `glog` and ghist aliases better
### Fixed
- Corrected Google Chrome and Slack install commands

## [1.6.3] - 2021-01-12
### Fixed
- Made `gtc` alias cope with the branch not being in the remote yet

## [1.6.2] - 2021-01-05
### Fixed
- Fallback to using default Node.js when no `.nvmrc` instead of borking up

## [1.6.1] - 2021-01-04
### Fixed
- Always relink awscli to prevent command not found issue

## [1.6.0] - 2021-01-01 
### Added
- Install rbenv
- Automatically add default SSH key, generating if required
- Stop it repeatedly updating Homebrew
### Changed
- Handle casks (AKA Mac Applications) better
### Fixed
- Issue with `gtc` command when running from a repository's subdirectory
### Removed
- Stop using ZSH correction

## [1.5.0] - 2020-11-11
### Added
- Make what gets installed configurable by a config file
- Option to config additional commands to run at the beginning and end ot the process
### Changed
- Be more intelligent about whether to install or upgrade
### Fixed
- Stop de-quarantining chromedriver borking

## [1.4.0] - 2020-11-05
### Added
- Install AWS Elastic Beanstalk CLI
- Install Serverless
- `gtc` command for committing on trunk based development

## [1.3.0] - 2020-11-02
### Added
- Install Arduino IDE

## [1.2.0] - 2020-10-30
### Added
- Install chromedriver for selenium tests

## [1.1.0] - 2020-10-28
### Changed
- Tidy up some zshrc aliases
### Added
- .gitignore_global
- Run `brew cleanup`
- Run `brew doctor` at the end to highlight possible issues
- Add `/usr/local/sbin` to PATH
- Explicitly install Python 3.9 to avoid issues when it clashes with Python 3.8 during installation as a PHP dependency
## Fixed
- Issue where reinstalling OhMyZSH wiped the changes previously made in `.zshrc` 

## [1.0.0] - 2020-10-27
### Changed
- Make output more useful
- Invalidate sudo timestamp in a bunch of places to make it clearer where elevated privileges are used

## [0.1.5] - 2020-10-26
### Added
- GitHub Actions pipeline
- Install Visual Studio Code
- Install Slack
- Install Microsoft Teams
- Install Google Chrome
### Changed
- Split up the commands and extract more things to one liners

## [0.1.4] - 2020-10-26
### Added
- Install tree
- Install composer
- Install Java, Spring Boot, Maven and Gradle
- Check if Docker is running before starting
- Remove some files which it complained about not being able to overwrite
### Changed
- Change deprecated `brew cask reinstall` commands to just `brew reinstall`
- `git-delete-all-local-branches-except-master-develop-and-current` becomes `git-delete-all-local-branches-except-main-develop-and-current`, but it still doesn't delete master.

## [0.1.3] - 2020-09-29
### Added
- git config pull.ff only (for real this time)
- Install GPG (for signed Git commits)
### Changed
- Use docker system prune in docker-cleanup
- Always check for node version on loading new terminal session

## [0.1.2] - 2020-07-14
### Added
- git config pull.ff only

## [0.1.1] - 2020-06-12
### Added
- Install Docker, Kubernetes, and Minikube
- Add NVM stuff to .zshrc
- Install Intellij IDEA
- Install Postman
- Install Spotify
### Changed
- Updated Homebrew install command

## [0.1.0] - 2020-06-12
### Added
- Install Homebrew
- Install iterm2
- Install zsh and oh-my-zsh
- Install nvm
- Install git
- Install awscli
- Install PHP
- Setup Miscellaneous aliases
- Setup Git aliases
- Setup Docker aliases
- Add docker oh-my-zsh plugin
- Add zsh-autosuggestions oh-my-zsh plugin
- docker git zsh-autosuggestions)'
- Ensure zshrc correction is used
- Ensure zshrc completion waiting dots are used
- Ensure correct ohmyzsh theme is used
