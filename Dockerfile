From alpine:3.20.0

# Install required packages
RUN apk add --no-cache curl unzip ffmpeg bash

# Create directories
RUN mkdir -p /app /config /data

COPY --chmod=0755 entrypoint.sh /app/entrypoint.sh

# Set environment variable for update
ENV UPDATE_YTARCHIVE=false
ENV YTARCHIVE_VERBOSE=true
ENV OUTPUT_VIDEO="/data/%(channel)s/%(upload_date)s/%(title)s"
ENV CHANNEL_URL=""

WORKDIR /config

VOLUME ["/config", "/data"]
CMD [ "/app/entrypoint.sh" ]
