const redis = require('redis');
require('dotenv').config();

const redisConfig = {
  url: process.env.REDIS_URL || 'redis://localhost:6379',
  retry_strategy: (options) => {
    if (options.error && options.error.code === 'ECONNREFUSED') {
      console.error('Redis connection refused');
      return new Error('Redis connection refused');
    }
    if (options.total_retry_time > 1000 * 60 * 60) {
      console.error('Redis retry time exhausted');
      return new Error('Retry time exhausted');
    }
    if (options.attempt > 10) {
      console.error('Redis max attempts reached');
      return undefined;
    }
    // Exponential backoff
    return Math.min(options.attempt * 100, 3000);
  }
};

const client = redis.createClient(redisConfig);

client.on('error', (err) => {
  console.error('Redis client error:', err);
});

client.on('connect', () => {
  console.log('Connected to Redis');
});

module.exports = client;