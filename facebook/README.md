# Facebook Module

This module handles data collection and processing for Facebook creators and content.

## Features

- Page and profile scraping
- Post and video collection
- Engagement metrics tracking
- Audience insights
- Rate limiting compliance

## API Integration

Uses Facebook Graph API and Instagram Graph API.

## Configuration

Set the following environment variables:
- `FACEBOOK_APP_ID`
- `FACEBOOK_APP_SECRET`

## Usage

```javascript
const facebookScraper = require('./facebook');
await facebookScraper.scrapeCreator('pageId');
```