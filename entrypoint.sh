#!/bin/sh

# Define the URL to download ytarchive from
VERBOSE=""

echo "Live channel: [$CHANNEL_URL]"
echo "Output video file name: [$OUTPUT_VIDEO]"
echo "Verbose: [$YTARCHIVE_VERBOSE]" 

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

echo "        _                       _      _              "
echo "       | |                     | |    (_)             "
echo " _   _ | |_   __ _  _ __   ___ | |__   _ __   __  ___ "
echo "| | | || __| / _\` || '__| / __|| '_ \ | |\ \ / / / _ \\"
echo "| |_| || |_ | (_| || |   | (__ | | | || | \ V / |  __/"
echo " \__, | \__| \__,_||_|    \___||_| |_||_|  \_/   \___|"
echo "  __/ |                                               "
echo " |___/                                                "

# Run ytarchive with the remaining arguments
ytarchive $VERBOSE --monitor-channel -w -r 600 --directory-permissions 0777 --file-permissions 0666 --merge --mkv --add-metadata --write-description --write-thumbnail --newline -o "$OUTPUT_VIDEO" $CHANNEL_URL best
