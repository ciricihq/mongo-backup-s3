# MongoDB S3 Backup Docker image

Docker image that performs periodic backups on a MongoDB database and then uploads the results to Amazon S3.

Based on the [dbader/schedule](https://github.com/dbader/schedule) Python scheduling package.

## Configuration

The following table describes the available configuration environment variables.

Name | Description | Default
--- | --- | ---
`MONGO_HOST` | MongoDB instance hostname | *Required*
`MONGO_DB` | MongoDB database name | *Required*
`S3_BUCKET` | Amazon S3 bucket name | *Required*
`AWS_ACCESS_KEY_ID` | Amazon AWS access key | *Required*
`AWS_SECRET_ACCESS_KEY` | Amazon AWS secret | *Required*
`BACKUP_INTERVAL` | Interval between each backup (hours) | 24
`DATE_FORMAT` | Date format string used as the suffix of the backup filename | `%Y%m%d-%H%M%S`
`FILE_PREFIX` | Prefix of the backup filename | `backup-`

## Example

The following command starts a *mongodb-s3-backup* container that will stay in the background uploading backups of the *testdb* database on the *my-mongo-host* MongoDB instance every hour. The backups will be uploaded to an S3 bucket named *my-s3-bucket*:

```
docker run -d -e MONGO_HOST=my-mongo-host -e MONGO_DB=testdb -e S3_BUCKET=my-s3-bucket -e AWS_ACCESS_KEY_ID=<your_access_key> -e AWS_SECRET_ACCESS_KEY=<your_access_secret> -e BACKUP_INTERVAL=1 --name mongo_backups agmangas/mongodb-backup-s3
```
