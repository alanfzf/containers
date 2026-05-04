#!/usr/bin/env bash

set -eou pipefail

ts=$(date -Iseconds)

# aws env vars
AWS_REGION="${AWS_REGION:-'us-east-1'}"
AWS_ACCESS_KEY_ID="${AWS_ACCESS_KEY_ID?:'AWS_ACCESS_KEY_ID is not set'}"
AWS_SECRET_ACCESS_KEY="${AWS_SECRET_ACCESS_KEY?:'AWS_SECRET_ACCESS_KEY is not set'}"
AWS_BUCKET="${AWS_BUCKET?:'AWS_BUCKET is not set'}"

# db env vars
DB_HOST="${DB_HOST:-'host.docker.internal'}"
DB_PORT="${DB_PORT:-3306}"
DB_USER="${DB_USER?:'DB_USER is not set'}"
DB_PASSWORD="${DB_PASSWORD?:'DB_PASSWORD is not set'}"

mariadb-dump \
    --host="${DB_HOST}" --user="${DB_USER}" --password="${DB_PASSWORD}" \
    --ssl=false \
    --routines --events --triggers \
    --single-transaction --all-databases | gzip -c | \
    aws s3 cp - "${AWS_BUCKET}/dump-${ts}.sql.gz"

echo "finished uploading the database dump at: ${ts}"
