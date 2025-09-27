# Creator Aggregator

A scalable, cloud-native multi-platform creator data aggregation system built with Node.js, Neon Postgres, and Docker.

## 🎯 System Goals

The Creator Aggregator is designed to:

- **Collect** creator-relevant data from all major social platforms
- **Store** data efficiently in a cloud-native Neon Postgres database
- **Serve** aggregated insights through APIs and analytics dashboards
- **Scale** horizontally across multiple platforms and data sources
- **Monitor** creator performance and engagement trends

## 🏗️ Architecture Overview

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Platform      │    │   Application   │    │   Database      │
│   Scrapers      │───▶│   Orchestrator  │───▶│   (Neon)        │
└─────────────────┘    └─────────────────┘    └─────────────────┘
│                      │                      │
├─ Snapchat           ├─ Rate Limiting       ├─ Creators
├─ Instagram          ├─ Job Scheduling      ├─ Content  
├─ TikTok             ├─ Data Processing     ├─ Analytics
├─ YouTube            ├─ API Endpoints       └─ Jobs
├─ Twitter/X          └─ Health Monitoring
├─ Facebook
└─ Reddit
```

## 📁 Platform Modules

This monorepo contains dedicated modules for each supported platform:

### `/snapchat`
- Snapchat Marketing API integration
- Story and Spotlight content collection
- Creator profile and metrics scraping

### `/instagram` 
- Instagram Basic Display & Graph API
- Posts, Stories, Reels, and IGTV collection
- Hashtag trend analysis and engagement tracking

### `/tiktok`
- TikTok for Developers API integration
- Video content and creator profile scraping
- Trending hashtag and sound analysis

### `/youtube`
- YouTube Data API v3 integration
- Channel analytics and video metadata
- Comment sentiment analysis

### `/twitter`
- Twitter API v2 integration
- Tweet collection and thread analysis
- Real-time engagement monitoring

### `/facebook`
- Facebook Graph API integration
- Page insights and post analytics
- Cross-platform Facebook/Instagram data

### `/reddit`
- Reddit API (PRAW) integration
- Subreddit content analysis
- User karma and engagement tracking

## 🗄️ Database Schema

The system uses **Neon Postgres** for cloud-native, serverless data storage:

### Core Tables

- **`creators`** - Creator profiles across all platforms
- **`content`** - Posts, videos, and media content
- **`analytics_daily`** - Aggregated daily metrics
- **`scraping_jobs`** - Background job management
- **`rate_limits`** - API rate limiting tracking

### Key Features

- **UUID primary keys** for distributed scaling
- **JSONB fields** for flexible metadata storage
- **Full-text search** capabilities
- **Time-series optimization** for analytics
- **Automatic timestamps** and triggers

See [`database/schema.sql`](./database/schema.sql) for the complete schema definition.

## 🚀 Getting Started

### Prerequisites

- Node.js 18+
- Docker and Docker Compose
- A Neon database instance (sign up at [neon.tech](https://neon.tech))

### Development Setup

1. **Clone and install dependencies:**
   ```bash
   git clone <repository-url>
   cd creator-aggregator
   npm install
   ```

2. **Configure environment:**
   ```bash
   cp .env.example .env
   # Edit .env with your Neon database URL and API keys
   ```

3. **Start development environment:**
   ```bash
   npm run dev
   ```

   This will start:
   - PostgreSQL (local development database)
   - Redis (caching and rate limiting)
   - Application server

4. **Run database migrations:**
   ```bash
   npm run db:migrate
   ```

### Production Deployment

The application is designed for cloud deployment with:
- **Neon Postgres** for managed database hosting
- **Docker containers** for consistent deployment
- **Environment-based configuration** for security

## 🔧 Development & Orchestration

### NPM Scripts

- `npm run dev` - Start development environment
- `npm run dev:logs` - View application logs
- `npm run dev:down` - Stop development environment
- `npm run db:migrate` - Run database migrations
- `npm run test` - Run tests across all modules
- `npm run lint` - Lint code across all modules
- `npm run build` - Build all modules

### Docker Compose Services

- **postgres** - Local PostgreSQL for development
- **redis** - Caching and rate limiting
- **app** - Main application service
- **migrate** - Database migration service

### API Rate Limiting

Each platform module implements:
- **Respectful rate limiting** following API guidelines
- **Exponential backoff** for failed requests
- **Request queuing** and prioritization
- **Health monitoring** and alerting

### Job Scheduling

Background jobs are managed through:
- **Database-driven job queue** using PostgreSQL
- **Retry logic** with exponential backoff
- **Dead letter queue** for failed jobs
- **Monitoring and alerting** for job health

## 📊 API Endpoints

Once deployed, the system provides REST APIs for:

- `GET /api/creators` - List creators across platforms
- `GET /api/creators/:id/content` - Get creator content
- `GET /api/analytics/daily` - Daily analytics data
- `GET /api/platforms/:platform/trending` - Platform trending data

## 🧪 Testing

Run the test suite:
```bash
npm test
```

Individual module testing:
```bash
npm test --workspace=instagram
```

## 📈 Monitoring & Analytics

The system includes:
- **Health check endpoints** for uptime monitoring
- **Prometheus metrics** for observability
- **Structured logging** with correlation IDs
- **Performance dashboards** via Grafana integration

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🆘 Support

For questions and support:
- Open an [issue](https://github.com/DuckshotPro/creator-aggregator/issues)
- Check the [documentation](./docs/)
- Review platform-specific README files in each module directory
