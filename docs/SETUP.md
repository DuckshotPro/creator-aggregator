# Setup Guide

## Prerequisites

- Node.js 18 or higher
- Docker and Docker Compose
- A Neon database account ([neon.tech](https://neon.tech))

## Quick Start

### 1. Environment Setup

```bash
# Clone the repository
git clone <repository-url>
cd creator-aggregator

# Install dependencies
npm install

# Copy environment template
cp .env.example .env
```

### 2. Configure Neon Database

1. Sign up for a free Neon account at [neon.tech](https://neon.tech)
2. Create a new database
3. Copy the connection string to your `.env` file:

```env
DATABASE_URL=postgresql://username:password@ep-example-123456.us-east-1.aws.neon.tech/neondb?sslmode=require
NEON_DATABASE_URL=postgresql://username:password@ep-example-123456.us-east-1.aws.neon.tech/neondb?sslmode=require
```

### 3. Platform API Keys

Configure API keys for the platforms you want to scrape:

```env
# Example for Instagram
INSTAGRAM_ACCESS_TOKEN=your_access_token
INSTAGRAM_CLIENT_ID=your_client_id
```

### 4. Start Development Environment

```bash
# Start all services
npm run dev

# View logs
npm run dev:logs

# Stop services
npm run dev:down
```

### 5. Run Database Migrations

```bash
npm run db:migrate
```

## Development Workflow

1. Make changes to platform modules in their respective directories
2. Test changes with `npm test`
3. Lint code with `npm run lint`
4. Build with `npm run build`

## Troubleshooting

### Database Connection Issues
- Ensure your Neon database is active
- Check that your connection string is correct
- Verify SSL settings are configured properly

### Docker Issues
- Ensure Docker is running
- Try `docker-compose down` and `docker-compose up` to restart services
- Check logs with `docker-compose logs`