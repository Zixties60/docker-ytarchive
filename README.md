# Docker for ytarchive
[![GitHub Package](https://github.com/Zixties60/docker-ytarchive/actions/workflows/docker-publish.yml/badge.svg)](https://github.com/Zixties60/docker-ytarchive/actions/workflows/docker-publish.yml)

This repository contains a Docker setup for downloading YouTube archive streams using ytarchive. The setup includes a customizable shell script and Docker Compose configuration to automate the download process.

## Docker run command

```shell
docker run --env=CHANNEL_URL=your_channel_url --env=YTARCHIVE_VERBOSE=true --env=OUTPUT_VIDEO="/data/%(channel)s/%(title)s (%(upload_date)s)/%(title)s" --restart=unless-stopped -d ghcr.io/zixties60/docker-ytarchive:main
```

## Docker Compose Configuration

The docker-compose.yml file sets up the service, environment variables, and volume mounts:

```yaml
version: "3.8"

services:
    ytarchive:
        image: ghcr.io/zixties60/docker-ytarchive:main
        environment:
            - CHANNEL_URL="your_channel_url" # Ensure this environment variable is set
            - OUTPUT_VIDEO="output_file_name" # Ensure this environment variable is set
            - YTARCHIVE_VERBOSE=true # Enable verbose logging
        volumes:
            - host/path/to/config:/config
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
