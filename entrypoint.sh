#!/bin/bash

# Define the URL to download ytarchive from
YTARCHIVE_URL="https://github.com/Kethsar/ytarchive/releases/download/v0.4.0/ytarchive_linux_amd64.zip"
YTARCHIVE_ZIP="ytarchive_linux_amd64.zip"
YTARCHIVE_BIN="ytarchive"

# Function to download and unzip ytarchive
download_ytarchive() {
    echo "Downloading ytarchive..."
    curl -Lo $YTARCHIVE_ZIP $YTARCHIVE_URL
    echo "Unzipping ytarchive..."
    unzip -o $YTARCHIVE_ZIP
    chmod u+x $YTARCHIVE_BIN
    rm $YTARCHIVE_ZIP
    echo "ytarchive downloaded and unzipped successfully."
}

# Check if CHANNEL_URL is provided
if [ -z "$CHANNEL_URL" ]; then
    echo "Error: CHANNEL_URL is not provided. Exiting."
    exit 1
fi

# Check for the "UPDATE_YTARCHIVE" argument or download when not exists
if [ "$UPDATE_YTARCHIVE" = "true" ] || [ ! -f "./$YTARCHIVE_BIN" ]; then
    download_ytarchive
    if [ ! -f "./$YTARCHIVE_BIN" ]; then
        echo "Error: Cannot download ytarchive. Exiting."
        exit 1
    fi
fi

# Run ytarchive with the remaining arguments
./$YTARCHIVE_BIN --monitor-channel --add-metadata --merge --mkv -r 600 -t -w --write-description --write-thumbnail  -o "/data/%%(channel)s/%%(upload_date)s/%%(title)s" $CHANNEL_URL best
