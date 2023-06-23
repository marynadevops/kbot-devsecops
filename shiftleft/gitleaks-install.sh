#!/bin/sh

echo "Hello! I am ensuring gitleaks installation."

set -e
SCRIPT_DIR=$1

# Get the current operating system and architecture
OS=$(uname -s)
ARCH=$(uname -m)
is_windows() {
    case "$OS" in
        Windows|MINGW*) return 0;;
        *) return 1;;
    esac
}

if ! "$SCRIPT_DIR/gitleaks" version 2>/dev/null
then
    echo "gitleaks is not installed or not found."

    GITLEAKS_VERSION="8.17.0"
    GITLEAKS_BASE_URL="https://github.com/gitleaks/gitleaks/releases/download/v$GITLEAKS_VERSION"

    # Define the gitleaks binary URL based on the OS and ARCH
    if [ "$OS" = "Linux" ]; then
        if [ "$ARCH" = "x86_64" ]; then
            GITLEAKS_URL="$GITLEAKS_BASE_URL/gitleaks_${GITLEAKS_VERSION}_linux_x64.tar.gz"
        elif [ "$ARCH" = "armv7l" ]; then
            GITLEAKS_URL="$GITLEAKS_BASE_URL/gitleaks_${GITLEAKS_VERSION}_linux_armv7.tar.gz"
        elif [ "$ARCH" = "aarch64" ]; then
            GITLEAKS_URL="$GITLEAKS_BASE_URL/gitleaks_${GITLEAKS_VERSION}_linux_arm64.tar.gz"
        else
            echo "Unsupported architecture: $ARCH"
            exit 1
        fi
    elif [ "$OS" = "Darwin" ]; then
        if [ "$ARCH" = "arm64" ]; then
            GITLEAKS_URL="$GITLEAKS_BASE_URL/gitleaks_${GITLEAKS_VERSION}_darwin_arm64.tar.gz"
        elif [ "$ARCH" = "x86_64" ]; then
            GITLEAKS_URL="$GITLEAKS_BASE_URL/gitleaks_${GITLEAKS_VERSION}_darwin_x64.tar.gz"
        else
            echo "Unsupported architecture: $ARCH"
            exit 1
        fi
    elif is_windows; then
        if [ "$ARCH" = "arm64" ]; then
            GITLEAKS_URL="$GITLEAKS_BASE_URL/gitleaks_${GITLEAKS_VERSION}_windows_arm64.zip"
        elif [ "$ARCH" = "armv7l" ]; then
            GITLEAKS_URL="$GITLEAKS_BASE_URL/gitleaks_${GITLEAKS_VERSION}_windows_armv7.zip"
        elif [ "$ARCH" = "x86_64" ]; then
            GITLEAKS_URL="$GITLEAKS_BASE_URL/gitleaks_${GITLEAKS_VERSION}_windows_x64.zip"
        else
            echo "Unsupported architecture: $ARCH"
            exit 1
        fi
    else
        echo "Unsupported operating system: $OS"
        exit 1
    fi

    # Download and extract gitleaks binary
    echo "Downloading and extracting gitleaks..."
    echo "From: $GITLEAKS_URL"
    CURRENT_DIR=$(pwd)
    cd "$SCRIPT_DIR"

    if is_windows; then
        rm -rf gitleaks.zip
        curl -sL "$GITLEAKS_URL" -o "gitleaks.zip"
        unzip -o gitleaks.zip
    else
        rm -rf gitleaks
        curl -sL "$GITLEAKS_URL" | tar -xz
    fi
    chmod +x gitleaks
    ./gitleaks version
    if [ -z "$(git config --get devsecops.protect.enabled)" ]; then
        git config --bool devsecops.protect.enabled true
    fi

    cd "$CURRENT_DIR"
fi

echo "Bye, thanks! Installation of gitleaks ensured."
