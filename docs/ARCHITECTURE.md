# Architecture Overview

## System Design

The Creator Aggregator follows a modular monorepo architecture with clear separation of concerns:

```
┌─────────────────────────────────────────────────────────────┐
│                     Creator Aggregator                      │
├─────────────────────────────────────────────────────────────┤
│  API Layer                                                  │
├─────────────────────────────────────────────────────────────┤
│  Orchestration Layer                                        │
│  ├─ Job Scheduler                                           │
│  ├─ Rate Limiter                                            │
│  └─ Data Processor                                          │
├─────────────────────────────────────────────────────────────┤
│  Platform Modules                                           │
│  ├─ Snapchat    ├─ TikTok      ├─ Twitter                   │
│  ├─ Instagram   ├─ YouTube     ├─ Facebook                  │
│  └─ Reddit                                                  │
├─────────────────────────────────────────────────────────────┤
│  Data Layer                                                 │
│  ├─ Neon Postgres (Primary Storage)                        │
│  ├─ Redis (Caching & Rate Limiting)                        │
│  └─ File Storage (Media Assets)                            │
└─────────────────────────────────────────────────────────────┘
```

## Core Components

### Platform Modules
Each social media platform has its own module containing:
- API clients and authentication
- Data extraction logic
- Rate limiting implementation
- Platform-specific transformations

### Orchestration Layer
- **Job Scheduler**: Manages scraping jobs and retries
- **Rate Limiter**: Enforces API rate limits across platforms
- **Data Processor**: Normalizes and enriches collected data

### Data Layer
- **Neon Postgres**: Serverless PostgreSQL for scalable storage
- **Redis**: Fast caching and rate limiting state
- **File Storage**: Media assets and backups

## Data Flow

1. **Job Creation**: Scheduled or triggered scraping jobs
2. **Platform Selection**: Route job to appropriate platform module
3. **Rate Limiting**: Check and enforce API limits
4. **Data Extraction**: Fetch data from platform APIs
5. **Data Processing**: Normalize and enrich data
6. **Storage**: Store in Neon Postgres with caching
7. **Analytics**: Generate insights and aggregations

## Scalability Considerations

### Horizontal Scaling
- Platform modules can run independently
- Database connections pooled per module
- Redis used for shared state management

### Performance Optimization
- Database indexing for fast queries
- Caching frequently accessed data
- Batch processing for bulk operations
- Connection pooling and reuse

### Fault Tolerance
- Retry logic with exponential backoff
- Dead letter queues for failed jobs
- Health checks and monitoring
- Graceful degradation on API failures

## Security

### Data Protection
- Environment-based configuration
- Secure API key management
- Database SSL connections
- Input validation and sanitization

### Rate Limiting
- Per-platform rate limit enforcement
- Respectful API usage patterns
- Automatic backoff on rate limit hits
- Monitoring and alerting

## Monitoring

### Observability
- Structured logging with correlation IDs
- Metrics collection (Prometheus compatible)
- Health check endpoints
- Performance dashboards

### Alerting
- Failed job notifications
- Rate limit violations
- Database connection issues
- API quota warnings