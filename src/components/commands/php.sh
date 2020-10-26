#!/bin/bash

ensure_php_is_installed() {
    brew reinstall php@7.4
    brew link --force --overwrite php@7.4
    brew services restart php
    brew unlink php && brew link php
}
