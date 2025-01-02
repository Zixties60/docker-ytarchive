From golang:1.23-alpine

# Install required packages
RUN apk update && apk add --no-cache \
    bash \
    ffmpeg \
    su-exec \
    tzdata

RUN go install github.com/Kethsar/ytarchive@dev

# Create directories
RUN mkdir -p /app /config /data

COPY --chmod=0755 entrypoint.sh /app/entrypoint.sh

# Set environment variable for update
ENV YTARCHIVE_VERBOSE=true
ENV OUTPUT_VIDEO="/data/%(channel)s/%(title)s (%(upload_date)s)/%(title)s"
ENV CHANNEL_URL=""

WORKDIR /config

VOLUME ["/config", "/data"]
CMD [ "/app/entrypoint.sh" ]
