const { neon } = require('@neondatabase/serverless');
require('dotenv').config();

// Neon serverless connection
const sql = neon(process.env.DATABASE_URL || process.env.NEON_DATABASE_URL);

// Database configuration
const dbConfig = {
  // For local development with Docker
  development: {
    host: process.env.DB_HOST || 'localhost',
    port: process.env.DB_PORT || 5432,
    database: process.env.DB_NAME || 'creator_aggregator_dev',
    username: process.env.DB_USER || 'postgres',
    password: process.env.DB_PASSWORD || 'postgres',
    dialect: 'postgres',
    logging: process.env.NODE_ENV === 'development'
  },
  
  // For production with Neon
  production: {
    use_env_variable: 'DATABASE_URL',
    dialect: 'postgres',
    dialectOptions: {
      ssl: {
        require: true,
        rejectUnauthorized: false
      }
    },
    logging: false
  },
  
  // For testing
  test: {
    host: process.env.TEST_DB_HOST || 'localhost',
    port: process.env.TEST_DB_PORT || 5432,
    database: process.env.TEST_DB_NAME || 'creator_aggregator_test',
    username: process.env.TEST_DB_USER || 'postgres',
    password: process.env.TEST_DB_PASSWORD || 'postgres',
    dialect: 'postgres',
    logging: false
  }
};

module.exports = {
  sql, // Neon serverless connection
  config: dbConfig[process.env.NODE_ENV || 'development']
};