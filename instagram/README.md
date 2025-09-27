# Instagram Module

This module handles data collection and processing for Instagram creators and content.

## Features

- Creator profile scraping
- Posts, Stories, and Reels collection
- Engagement metrics tracking
- Hashtag and mention extraction
- Rate limiting compliance

## API Integration

Uses Instagram Basic Display API and Graph API.

## Configuration

Set the following environment variables:
- `INSTAGRAM_ACCESS_TOKEN`
- `INSTAGRAM_CLIENT_ID`

## Usage

```javascript
const instagramScraper = require('./instagram');
await instagramScraper.scrapeCreator('username');
```