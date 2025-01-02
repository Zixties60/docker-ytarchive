# Docker for ytarchive

[![GitHub Package](https://github.com/Zixties60/docker-ytarchive/actions/workflows/docker-publish.yml/badge.svg)](https://github.com/Zixties60/docker-ytarchive/actions/workflows/docker-publish.yml)

This repository contains a Docker setup for downloading YouTube archive streams using [Kethsar/ytarchive](https://github.com/Kethsar/ytarchive). The setup includes a customizable shell script and Docker Compose configuration to automate the download process.

## Docker run command

```shell
docker run -d \
  --name ytarchive \
  -e PUID=1000 \  # Replace with your host user ID
  -e PGID=1000 \  # Replace with your host group ID
  -e CHANNEL_URL="your_channel_url" \  # Replace with the YouTube channel URL
  -e OUTPUT_VIDEO="output_file_name" \  # Replace with the desired output file name format
  -e YTARCHIVE_VERBOSE=true \  # Set to true for verbose logging
  -v /host/path/to/config:/config \  # Map the config directory
  -v /host/path/to/data:/data \  # Map the data directory
  ghcr.io/zixties60/docker-ytarchive:main
```

## Docker Compose Configuration

The docker-compose.yml file sets up the service, environment variables, and volume mounts:

```yaml
services:
    ytarchive:
        image: ghcr.io/zixties60/docker-ytarchive:main
        environment:
            # PUID and PGID specify the user and group IDs for running the container processes.
            # Use these to match the permissions of the host system files.
            # Example: If your host user's UID is 1000 and GID is 1000, set PUID=1000 and PGID=1000.
            PUID: 1000 # Replace with the correct User ID
            PGID: 1000 # Replace with the correct Group ID

            # Specify the YouTube channel URL to monitor.
            CHANNEL_URL: "your_channel_url" # Replace with the desired YouTube channel URL

            # Specify the output file name format for videos.
            OUTPUT_VIDEO: "output_file_name" # Replace with the desired output file name format

            # Enable verbose logging if set to true.
            YTARCHIVE_VERBOSE: "true" # Set to "true" to enable verbose logging

        volumes:
            # Map the host path for configuration files.
            - host/path/to/config:/config

            # Map the host path for storing downloaded videos and data.
            - host/path/to/data:/data
```

## Environment Variables

-   `CHANNEL_URL`: The URL of the YouTube channel to monitor and download.
-   `OUTPUT_VIDEO`: ytarchive output video file name.\
-   `YTARCHIVE_VERBOSE`: Set to `true` to enable verbose logging for debugging.

## How to Use

1. **Clone the repository:**

    ```sh
    git clone https://github.com/Zixties60/docker-ytarchive.git
    cd docker-ytarchive
    ```

2. **Build the Docker image:**

    ```sh
    docker-compose build --no-cache
    ```

3. **Run Docker Compose:**

    ```sh
    docker-compose up
    ```

4. **Set Environment Variables:**

    - `CHANNEL_URL`: The YouTube channel URL to monitor and download videos from. **(required)**
    - `OUTPUT_VIDEO` (default: `/data/%(channel)s/%(upload_date)s/%(title)s`): ytarchive output video file name.
    - `YTARCHIVE_VERBOSE` (default: `false`): Set to `true` to enable verbose logging.

## Troubleshooting

-   Ensure that `CHANNEL_URL` is set in the environment variables.
-   Check permissions of `entrypoint.sh` to ensure it is executable.
-   Verify the file paths and volume mounts are correct in `docker-compose.yml`.

## License

This project is licensed under the GNU General Public License v3.0 (GPL-3.0).
