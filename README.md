# Ory Kratos Database Cleaner 🧹

A lightweight, containerized solution for cleaning up expired records from your Ory Kratos PostgreSQL database.

## Overview

This tool automatically removes expired records from your Ory Kratos database by scanning for tables with an `expires_at` column and deleting any rows where the expiration date has passed. It's designed to run as a scheduled job to keep your database lean and performant.

## Why This Exists

Ory Kratos stores various temporary records (like verification flows, recovery tokens, and session tokens) with expiration times. While Kratos handles some cleanup, this utility ensures comprehensive removal of all expired records across all relevant tables.

## Key Features

- 🚀 **Automatic Cleanup**: Scans and cleans all tables with `expires_at` columns
- 🐳 **Dockerized**: Easy to deploy anywhere Docker runs
- 🔄 **Idempotent**: Safe to run multiple times
- 🔒 **Minimal Dependencies**: Just PostgreSQL and Docker

## Tech Stack

- **Containerization**: Docker
- **Database**: PostgreSQL
- **Deployment**: Railway (with configuration provided)
- **Scripting**: Bash

## Getting Started

### Prerequisites

- Docker and Docker Compose
- PostgreSQL database (local or remote)

### Local Development

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/ory-kratos-db-cleaner.git
   cd ory-kratos-db-cleaner
   ```

2. Set up environment variables:
   ```bash
   echo "DATABASE_URL=postgresql://user:password@host:port/dbname" > .env
   ```

3. Run with Docker:
   ```bash
   docker build -t kratos-db-cleaner .
   docker run --env-file .env kratos-db-cleaner
   ```

## Deployment

### Railway

The project includes a `railway.toml` configuration for easy deployment to Railway:

1. Install Railway CLI and login
2. Link your project
3. Set the `DATABASE_URL` environment variable
4. Deploy!

## Project Structure

```
.
├── Dockerfile        # Container configuration
├── entrypoint.sh     # Main cleanup script
└── railway.toml      # Railway deployment config
```

## Usage

The cleaner will:
1. Connect to your PostgreSQL database using the `DATABASE_URL` environment variable
2. Find all tables with an `expires_at` column
3. Delete all rows where `expires_at` is in the past
4. Log the number of rows deleted from each table

## Scheduled Execution

For production use, set up a scheduled job to run this container periodically. For example, using cron:

```bash
# Run daily at 3 AM
0 3 * * * docker run --env-file /path/to/.env kratos-db-cleaner
```

## Future Improvements

- [ ] Add monitoring and alerting for cleanup operations
- [ ] Support for multiple database types
- [ ] Configurable logging levels
- [ ] Dry-run mode for testing
- [ ] Metrics collection

