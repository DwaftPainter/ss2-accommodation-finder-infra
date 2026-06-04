# Accommodation Finder Infrastructure

Local infrastructure for Accommodation Finder search indexing.

This stack runs OpenSearch, OpenSearch Dashboards, and Logstash. Logstash reads active listings from PostgreSQL with JDBC and writes them into the `listings` OpenSearch index.

## Files

- `docker-compose.yml` - defines OpenSearch, OpenSearch Dashboards, and Logstash services.
- `logstash.conf` - Logstash JDBC pipeline and OpenSearch output configuration.
- `logstash-query.sql` - SQL query used to fetch active listings.
- `postgresql-42.7.9.jar` - PostgreSQL JDBC driver mounted into Logstash.

## Prerequisites

- Docker
- Docker Compose
- A reachable PostgreSQL database with the expected application schema

## Environment

Create a `.env` file in this directory:

```env
DB_USER=neondb_owner
DB_PASSWORD=your_database_password
JDBC_CONNECTION_STRING=jdbc:postgresql://host:5432/database
```

`DB_USER` defaults to `neondb_owner` if omitted. `DB_PASSWORD` is required. `JDBC_CONNECTION_STRING` defaults to `jdbc:postgresql://postgres:5432/neondb`.

## Run

```sh
docker compose up -d
```

OpenSearch is available at:

```text
http://127.0.0.1:9200
```

OpenSearch Dashboards is available at:

```text
http://127.0.0.1:5601
```

## Useful Commands

View running services:

```sh
docker compose ps
```

View Logstash logs:

```sh
docker compose logs -f logstash
```

Restart Logstash after changing the pipeline or query:

```sh
docker compose restart logstash
```

Stop all services:

```sh
docker compose down
```

Remove services and Logstash tracking data:

```sh
docker compose down -v
```

## Indexing Notes

Logstash runs once per minute. It tracks the latest processed `updatedAt` timestamp in the `logstash_data` Docker volume and only indexes rows where `Listing.status = 'ACTIVE'` and `Listing.updatedAt` is newer than the last recorded value.

Documents are written to the `listings` index using the listing `id` as the OpenSearch document ID.
