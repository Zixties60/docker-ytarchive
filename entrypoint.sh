#!/bin/sh

# Define the URL to download ytarchive from
VERBOSE=""

echo "Live channel: [$CHANNEL_URL]"
echo "Output video file name: [$OUTPUT_VIDEO]"
echo "Verbose: [$YTARCHIVE_VERBOSE]" 
echo "User PUID: [$PUID], Group PGID: [$PGID]"

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

# Check if CHANNEL_URL is provided
if [ "$YTARCHIVE_VERBOSE" = "true" ]; then
    VERBOSE="--verbose --debug"
fi

# Ensure PUID and PGID are set; default to root if not provided
PUID=${PUID:-0}
PGID=${PGID:-0}

echo "        _                       _      _              "
echo "       | |                     | |    (_)             "
echo " _   _ | |_   __ _  _ __   ___ | |__   _ __   __  ___ "
echo "| | | || __| / _\` || '__| / __|| '_ \ | |\ \ / / / _ \\"
echo "| |_| || |_ | (_| || |   | (__ | | | || | \ V / |  __/"
echo " \__, | \__| \__,_||_|    \___||_| |_||_|  \_/   \___|"
echo "  __/ |                                               "
echo " |___/                                                "

# Run ytarchive with the remaining arguments
su-exec $PUID:$PGID ytarchive $VERBOSE \
    --monitor-channel \
    --wait \
    --retry-stream 600 \
    --directory-permissions 0777 \
    --file-permissions 0666 \
    --merge \
    --mkv \
    --add-metadata \
    --write-description \
    --write-thumbnail \
    --newline \
    --output "$OUTPUT_VIDEO" $CHANNEL_URL best

