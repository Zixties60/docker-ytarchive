#!/bin/sh

# Define the URL to download ytarchive from
VERBOSE=""
YTARCHIVE_URL="https://github.com/Kethsar/ytarchive/releases/download/v0.4.0/ytarchive_linux_amd64.zip"
YTARCHIVE_ZIP="ytarchive_linux_amd64.zip"
YTARCHIVE_BIN="ytarchive"

echo "Live channel: [$CHANNEL_URL]"
echo "Output video file name: [$OUTPUT_VIDEO]"
echo "Update ytarchive: [$UPDATE_YTARCHIVE]" 
echo "Verbose: [$YTARCHIVE_VERBOSE]" 

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
    VERBOSE="--verbose --debug"
fi

ARGS="$VERBOSE --monitor-channel -w -r 600 -dp 777 -fp 666 --merge --mkv --add-metadata --thumbnail --write-description --write-thumbnail --newline -o $OUTPUT_VIDEO $CHANNEL_URL best"

echo "ytarchive args: [$ARGS]"

echo "        _                       _      _              "
echo "       | |                     | |    (_)             "
echo " _   _ | |_   __ _  _ __   ___ | |__   _ __   __  ___ "
echo "| | | || __| / _\` || '__| / __|| '_ \ | |\ \ / / / _ \\"
echo "| |_| || |_ | (_| || |   | (__ | | | || | \ V / |  __/"
echo " \__, | \__| \__,_||_|    \___||_| |_||_|  \_/   \___|"
echo "  __/ |                                               "
echo " |___/                                                "

# Run ytarchive with the remaining arguments
./$YTARCHIVE_BIN $ARGS
