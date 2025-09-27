# Twitter/X Module

This module handles data collection and processing for Twitter/X creators and content.

## Features

- User profile scraping
- Tweet collection and analysis
- Engagement metrics tracking
- Thread and reply analysis
- Rate limiting compliance

## API Integration

Uses Twitter API v2 and X API.

## Configuration

Set the following environment variables:
- `TWITTER_API_KEY`
- `TWITTER_API_SECRET`
- `TWITTER_BEARER_TOKEN`

## Usage

```javascript
const twitterScraper = require('./twitter');
await twitterScraper.scrapeCreator('username');
```