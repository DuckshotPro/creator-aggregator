# Reddit Module

This module handles data collection and processing for Reddit creators and content.

## Features

- User profile scraping
- Post and comment collection
- Subreddit analysis
- Engagement metrics tracking
- Rate limiting compliance

## API Integration

Uses Reddit API (PRAW) and Reddit Data API.

## Configuration

Set the following environment variables:
- `REDDIT_CLIENT_ID`
- `REDDIT_CLIENT_SECRET`

## Usage

```javascript
const redditScraper = require('./reddit');
await redditScraper.scrapeCreator('username');
```