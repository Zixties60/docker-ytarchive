From alpine:3.20.0

# Install required packages
RUN apk add --no-cache curl unzip ffmpeg

# Create directories
RUN mkdir -p /config /data

WORKDIR /config

COPY --chmod=0755 entrypoint.sh entrypoint.sh

# Set environment variable for update
ENV UPDATE_YTARCHIVE=false

VOLUME ["/config", "/data"]
CMD [ "./entrypoint.sh" ]
