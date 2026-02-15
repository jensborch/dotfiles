#!/bin/bash

# Default directories
FLAC_DIR="${1:-/tank/media/Flac}"
MP3_DIR="${2:-/tank/media/Mp3}"

# Step 1: Add ReplayGain to new FLAC folders (albums)
echo "Adding ReplayGain to new FLAC folders..."
find "$FLAC_DIR" -mindepth 2 -type d -newermt "$(date -d '10 day ago' +%Y-%m-%d)" -print0 | while IFS= read -r -d '' folder; do
    echo "Processing folder: $folder"
    metaflac --add-replay-gain "$folder"/*.flac
done

# Step 2: Convert new FLAC files to MP3
cd "$FLAC_DIR" || exit
fdfind -t d -x mkdir -p "$MP3_DIR/{}"
fdfind -t f -e flac -e mp3 -x ffmpeg -n -i "{}" -qscale:a 5 "$MP3_DIR/{.}.mp3"

echo "Done!"