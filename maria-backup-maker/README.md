# MARIA-BACKUP-MAKER

Containerized MariaDB backup job that runs on cron, dumps all databases, compresses the dump, and uploads it to S3.

## Environment variables

Create a `.env` file in this directory (or copy from `.env.example`):

```bash
cp .env.example .env
```

| Variable | Required | Default | Description |
|---|---|---|---|
| `AWS_REGION` | No | `us-east-1` | AWS region used by AWS CLI |
| `AWS_ACCESS_KEY_ID` | Yes | - | AWS access key |
| `AWS_SECRET_ACCESS_KEY` | Yes | - | AWS secret key |
| `AWS_BUCKET` | Yes | - | Full S3 destination path, for example `s3://my-backups/mariadb` |
| `DB_HOST` | No | `host.docker.internal` | MariaDB hostname reachable from container |
| `DB_PORT` | No | `3306` | MariaDB port |
| `DB_USER` | Yes | - | MariaDB user with dump permissions |
| `DB_PASSWORD` | Yes | - | MariaDB user password |

## Setup

1. Copy env template and fill real values:
   ```bash
   cp .env.example .env
   ```
2. Build and start:
   ```bash
   docker compose up -d --build
   ```
## Run an immediate backup (manual)

```bash
docker compose run --rm maria-backup-maker backup.sh
```
