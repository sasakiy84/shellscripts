#!/bin/sh
set -Ceu

SERVER_NAME="server1"
S3_BUCKET_NAME="bucketname"

NOW_DATE=$(date +%Y%m%d)
BACKUP_FOLDER="${HOME:?}/backup"
NOW_DATE_BACKUP_FOLDER="${BACKUP_FOLDER:?}/${NOW_DATE:?}"
MONGO_DBNAME1="dbname1"

mkdir -p "${NOW_DATE_BACKUP_FOLDER:?}"

# dump mongo or other db
mongodump -d "${MONGO_DBNAME1:?}" --out "${NOW_DATE_BACKUP_FOLDER:?}/${MONGO_DBNAME1:?}"

# compression folder
tar -zcvf "${NOW_DATE_BACKUP_FOLDER:?}/backup_folder_1.tar.gz" -C "/path/to/backup/parent/folder/" "backup_folder_name_1"

# compression all
tar -zcvf "${NOW_DATE_BACKUP_FOLDER:?}_${SERVER_NAME:?}.tar.gz" -C "${BACKUP_FOLDER:?}" "${NOW_DATE:?}"

# send to s3
aws s3 cp "${NOW_DATE_BACKUP_FOLDER:?}_${SERVER_NAME:?}.tar.gz" s3://${S3_BUCKET_NAME:?} --profile backup_script

rm -r "${NOW_DATE_BACKUP_FOLDER:?}"
# 8日後に消す
find "${BACKUP_FOLDER:?}" -type f -daystart -mtime +8 -exec rm {} \;
