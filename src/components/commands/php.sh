#!/bin/bash

ensure_php_is_installed() {
    installApplicationHomebrewStyle "php@8.0"
    brew link --force --overwrite php@8.0
    brew services restart php
    brew unlink php && brew link php
}
