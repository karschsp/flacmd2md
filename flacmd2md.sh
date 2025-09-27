#!/usr/bin/env bash
# flacmd2md.sh

OUTPUT="flac_album_metadata.md"
TMP="tmp_album_rows.txt"

> "$TMP"
declare -A SEEN

# Function: escape Markdown table pipes and brackets
escape_md() {
    local str="$1"
    str="${str//|/\\|}"
    str="${str//[/\\[}"
    str="${str//]/\\]}"
    str="${str//(/\\(}"
    str="${str//)/\\)}"
    echo "$str"
}

# Function: URL encode (basic, enough for our queries)
urlencode() {
    local LANG=C
    local length="${#1}"
    for (( i = 0; i < length; i++ )); do
        local c="${1:i:1}"
        case $c in
            [a-zA-Z0-9.~_-]) printf "%s" "$c" ;;
            ' ') printf "+" ;;
            *) printf '%%%02X' "'$c"
        esac
    done
}

# Recursively find album folders (Artist/Album)
find . -mindepth 2 -maxdepth 2 -type d -print0 | while IFS= read -r -d '' folder; do
    ARTIST=$(basename "$(dirname "$folder")")
    ALBUM=$(basename "$folder")

    # Skip if already processed
    KEY="$ARTIST|||$ALBUM"
    if [ -n "${SEEN[$KEY]}" ]; then
        continue
    fi
    SEEN[$KEY]=1

    # Grab metadata from the first FLAC in this folder
    first_flac=$(find "$folder" -maxdepth 1 -type f -iname "*.flac" | head -n1)
    if [ -n "$first_flac" ]; then
        YEAR=$(metaflac --show-tag=DATE "$first_flac" | head -n1 | cut -d= -f2-)
        UPC=$(metaflac --show-tag=UPC "$first_flac" | head -n1 | cut -d= -f2-)
    fi

    # Escape Markdown text
    ARTIST_ESC=$(escape_md "$ARTIST")
    ALBUM_ESC=$(escape_md "$ALBUM")
    YEAR_ESC=$(escape_md "$YEAR")
    UPC_ESC=$(escape_md "$UPC")

    # URL encode queries
    MB_QUERY=$(urlencode "$ARTIST $ALBUM")
    MB_URL="https://musicbrainz.org/search?query=${MB_QUERY}&type=release&method=advanced"

    if [ -n "$UPC" ]; then
        DISC_URL="https://www.discogs.com/search/?q=$(urlencode "$UPC")&type=release"
    else
        DISC_QUERY=$(urlencode "$ARTIST $ALBUM")
        DISC_URL="https://www.discogs.com/search/?q=${DISC_QUERY}&type=release"
    fi

    # Markdown link: safe album link
    ALBUM_LINK="[$ALBUM_ESC]($MB_URL) [[Discogs]($DISC_URL)]"

    echo "$ARTIST_ESC|$ALBUM_LINK|$YEAR_ESC|$UPC_ESC" >> "$TMP"
done

# Count albums
ALBUM_COUNT=$(wc -l < "$TMP")

# Write Markdown header with count and timestamp
{
#    echo "# Album Metadata"
#    echo
    echo "**Total Albums:** $ALBUM_COUNT  "
    echo "**Last Updated:** $(date '+%Y-%m-%d %H:%M:%S')"
    echo
    echo "| Artist | Album | Year | UPC |"
    echo "|--------|-------|------|-----|"
} > "$OUTPUT"

# Sort and append rows
sort -t'|' -k1,1 -k3,3n "$TMP" >> "$OUTPUT"

rm "$TMP"
echo "Markdown table generation complete. Saved to $OUTPUT"
