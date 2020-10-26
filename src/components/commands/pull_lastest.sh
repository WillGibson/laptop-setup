

pull_latest_laptop_setup_code() {
    fancy_echo "Ensure laptop-setup up to date ..."
    # shellcheck disable=SC2154
    if [ ! -f "${basePath}/../.git" ]; then
        currentDirectory=$(pwd)
        cd "${basePath}/../" || exit
        git config pull.ff only
        git pull origin "$(git rev-parse --abbrev-ref HEAD)"
        cd "${currentDirectory}" || exit
    fi
}
