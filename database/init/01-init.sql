-- Database initialization script
-- This runs automatically when the PostgreSQL container first starts

-- Create the database if it doesn't exist (for Docker)
-- SELECT 'CREATE DATABASE creator_aggregator_dev' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'creator_aggregator_dev')\gexec

-- Connect to the database and run schema
\i /docker-entrypoint-initdb.d/schema.sql