# Infrastructure - Docker & Services

## Overview
This directory contains the Docker configuration for the external services required by the application.

## Services
- **PostgreSQL:** Primary relational database.
- **Redis:** Caching and session management.
- **OpenSearch:** Search engine for listings.
- **Logstash:** Data pipeline for syncing PostgreSQL to OpenSearch.

## Usage
- Start services: `docker-compose up -d`
- Stop services: `docker-compose down`
- View logs: `docker-compose logs -f`

## Configuration
- `docker-compose.yml`: Main orchestration file.
- `logstash.conf`: Configuration for Logstash pipeline.
- `logstash-query.sql`: SQL query used by Logstash to fetch data from PostgreSQL.

## Important Notes
- Ensure that the PostgreSQL port (5432) is not blocked or used by another local instance.
- OpenSearch may require `vm.max_map_count` to be set on Linux systems.
- Logstash requires the PostgreSQL JDBC driver (`postgresql.jar`) included in this directory.
