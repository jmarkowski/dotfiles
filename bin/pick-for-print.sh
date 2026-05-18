#!/usr/bin/env bash
# pick-for-print.sh — copies current Ristretto photo to print queue
#
# Source:  ~/memories/2023/summer_holiday/day2/IMG_001.jpg
# Dest:    ~/Desktop/usb-photo-prints/2023__summer_holiday__day2/IMG_001.jpg
#
# Dependencies: xdotool, libnotify
# Install: sudo pacman -S xdotool libnotify

MEMORIES_DIR="${HOME}/memories"
PRINT_DIR="${HOME}/Desktop/usb-photo-prints/cottage-prints/selected"

# --- Detect current file ---
WINDOW_TITLE=$(xdotool getactivewindow getwindowname 2>/dev/null)
BASENAME=$(echo "$WINDOW_TITLE" | sed 's/ - Image Viewer.*//')

SOURCE_PATH=$(find "$MEMORIES_DIR" -type f -name "$BASENAME" 2>/dev/null | head -n 1)

if [[ -z "$SOURCE_PATH" ]]; then
    [[ -f "$BASENAME" ]] && SOURCE_PATH="$BASENAME"
fi

if [[ -z "$SOURCE_PATH" ]]; then
    notify-send -u critical "Failed to add to print album" \
        "❌ Could not resolve path from:\n'${WINDOW_TITLE}'" \
        --icon=dialog-error
    exit 1
fi

# --- Build destination ---
# e.g. 2023/summer_holiday/day2/IMG_001.jpg
REL_PATH="${SOURCE_PATH#${MEMORIES_DIR}/}"
REL_DIR=$(dirname "$REL_PATH")
FILENAME=$(basename "$REL_PATH")

# e.g. 2023__summer_holiday__day2__IMG_001.jpg
FLAT_NAME=$(echo "$REL_PATH" | tr '/' '__')

mkdir -p "$PRINT_DIR"

DEST_FILE="${PRINT_DIR}/${FLAT_NAME}"

# Handle duplicates
if [[ -f "$DEST_FILE" ]]; then
    NAME="${FLAT_NAME%.*}"
    EXT="${FLAT_NAME##*.}"
    COUNTER=2
    while [[ -f "${PRINT_DIR}/${NAME}_${COUNTER}.${EXT}" ]]; do
        ((COUNTER++))
    done
    DEST_FILE="${PRINT_DIR}/${NAME}_${COUNTER}.${EXT}"
fi

cp "$SOURCE_PATH" "$DEST_FILE"

notify-send "Added to print album ✅" \
    "<b>${FLAT_NAME}</b>" \
    --icon=document-save
