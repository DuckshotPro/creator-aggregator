const express = require('express');
const cors = require('cors');
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Health check endpoint
app.get('/health', (req, res) => {
  res.status(200).json({
    status: 'ok',
    timestamp: new Date().toISOString(),
    uptime: process.uptime(),
    environment: process.env.NODE_ENV || 'development'
  });
});

// Basic API routes
app.get('/', (req, res) => {
  res.json({
    name: 'Creator Aggregator',
    version: '1.0.0',
    description: 'Multi-Platform Creator Data Aggregation System',
    endpoints: {
      health: '/health',
      api: '/api'
    }
  });
});

// API routes placeholder
app.use('/api', (req, res) => {
  res.status(501).json({
    message: 'API endpoints not yet implemented',
    availableModules: [
      'snapchat',
      'instagram', 
      'tiktok',
      'youtube',
      'twitter',
      'facebook',
      'reddit'
    ]
  });
});

// Error handling
app.use((err, req, res, _next) => {
  console.error(err.stack);
  res.status(500).json({
    error: 'Something went wrong!',
    message: process.env.NODE_ENV === 'development' ? err.message : 'Internal server error'
  });
});

// 404 handler
app.use((req, res) => {
  res.status(404).json({
    error: 'Not Found',
    message: `Route ${req.originalUrl} not found`
  });
});

// Start server
app.listen(PORT, () => {
  console.log(`Creator Aggregator server running on port ${PORT}`);
  console.log(`Environment: ${process.env.NODE_ENV || 'development'}`);
  console.log(`Health check: http://localhost:${PORT}/health`);
});

module.exports = app;