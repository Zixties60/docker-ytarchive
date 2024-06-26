#!/bin/sh

# Define the URL to download ytarchive from
VERBOSE=""
OUTPUT_VIDEO=""
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

# # Check if CHANNEL_URL is provided
if [ "$CHANNEL_URL" = "" ]; then
    echo "Error: CHANNEL_URL is not provided. Exiting."
    exit 1
fi

# # Check if OUTPUT_VIDEO is provided
if [ "$OUTPUT_VIDEO" = "" ]; then
    echo "Error: OUTPUT_VIDEO is not provided. Exiting."
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

# Check if CHANNEL_URL is provided
if [ "$YTARCHIVE_VERBOSE" = "true" ]; then
    VERBOSE="-v"
fi

# Run ytarchive with the remaining arguments
./$YTARCHIVE_BIN $VERBOSE --monitor-channel -w -r 600 --merge --mkv --add-metadata --thumbnail --write-description --write-thumbnail --newline -o $OUTPUT_VIDEO $CHANNEL_URL best
