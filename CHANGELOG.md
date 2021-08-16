# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [unreleased]
### Added
- Use kubectl ohmyzsh plugin
- Install krew
### Changed
- Separate docker and kubernetes installs

## [1.8.0]
### Added
- Install Rectangle

## [1.8.0]
### Added
- Install Brave browser

## [1.7.0]
### Added
- Add `gtp` git trigger pipeline alias
### Changed
- Make `glog` and ghist aliases better
### Fixed
- Corrected Google Chrome and Slack install commands

## [1.6.3]
### Fixed
- Made `gtc` alias cope with the branch not being in the remote yet

## [1.6.2]
### Fixed
- Fallback to using default Node.js when no `.nvmrc` instead of borking up

## [1.6.1]
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
