#!/usr/bin/env bash
#rclone sync /home/paperless/paperless_scans google-drive_extra-lion-w:paperless_scans &

NOW="$(date)"

DOCUMENT_ID=${1}
DOCUMENT_FILE_NAME=${2}
DOCUMENT_SOURCE_PATH=${3}
DOCUMENT_THUMBNAIL_PATH=${4}
DOCUMENT_DOWNLOAD_URL=${5}
DOCUMENT_THUMBNAIL_URL=${6}
DOCUMENT_CORRESPONDENT=${7}
DOCUMENT_TAGS=${8}
DOCUMENT_ORIGINAL_PATH=${9}
DOCUMENT_ORIGINAL_FILE_NAME=$(basename "${DOCUMENT_ORIGINAL_PATH}")

echo "[${NOW}] processed file from ${DOCUMENT_SOURCE_PATH} with id: ${DOCUMENT_ID}; and name ${DOCUMENT_FILE_NAME}; from original path: ${DOCUMENT_ORIGINAL_PATH}; original name: ${DOCUMENT_ORIGINAL_FILE_NAME}" >> /hooks/log

# Create an empty file with the original name in finished, another process will periodically check this and delete filenames in here from the server
touch "/hooks/finished/${DOCUMENT_ORIGINAL_FILE_NAME}"

# This makes sure the logfile doesn't get to big
tail -c 1G /hooks/log > /hooks/log.tmp
mv /hooks/log.tmp /hooks/log
