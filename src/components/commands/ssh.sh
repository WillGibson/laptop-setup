#!/bin/bash

ensure_ssh_rsa_works() {
    append_text_to_file ~/.ssh/ssh_config "HostkeyAlgorithms +ssh-rsa" 1
    append_text_to_file ~/.ssh/ssh_config "PubkeyAcceptedAlgorithms +ssh-rsa" 1
}
