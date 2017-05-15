#!/bin/bash

set -e

export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY
export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_KEY

: ${MONGO_HOST:?}
: ${S3_BUCKET:?}
: ${AWS_ACCESS_KEY_ID:?}
: ${AWS_SECRET_ACCESS_KEY:?}
: ${DATE_FORMAT:?}
: ${FILE_PREFIX:?}

FOLDER=/backup
DUMP_OUT=dump

FILE_NAME=${FILE_PREFIX}$(date -u +${DATE_FORMAT}).tar.gz

echo "Creating backup folder..."

rm -fr ${FOLDER} && mkdir -p ${FOLDER} && cd ${FOLDER}

echo "Starting backup..."

if [ -z ${MONGO_DB} ]; then
    mongodump --host=${MONGO_HOST} --db=${MONGO_DB} --out=${DUMP_OUT}
else
    mongodump --host=${MONGO_HOST} --out=${DUMP_OUT}
fi

echo "Compressing backup..."

tar -zcvf ${FILE_NAME} ${DUMP_OUT} && rm -fr ${DUMP_OUT}

echo "Uploading to S3..."

aws s3api put-object --bucket ${S3_BUCKET} --key ${FILE_NAME} --body ${FILE_NAME}

echo "Removing backup file..."

rm -f ${FILE_NAME}

echo "Done!"
