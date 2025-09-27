-- Creator Aggregator Database Schema

-- Enable necessary extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pg_trgm";

-- Platforms enum
CREATE TYPE platform_type AS ENUM (
    'snapchat',
    'instagram', 
    'tiktok',
    'youtube',
    'twitter',
    'facebook',
    'reddit'
);

-- Content types enum
CREATE TYPE content_type AS ENUM (
    'post',
    'story',
    'reel',
    'video',
    'comment',
    'live',
    'article'
);

-- Creators table
CREATE TABLE creators (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    username VARCHAR(255) NOT NULL,
    display_name VARCHAR(255),
    platform platform_type NOT NULL,
    platform_id VARCHAR(255) NOT NULL,
    bio TEXT,
    profile_image_url TEXT,
    follower_count BIGINT DEFAULT 0,
    following_count BIGINT DEFAULT 0,
    verified BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    last_scraped_at TIMESTAMP WITH TIME ZONE,
    
    UNIQUE(platform, platform_id),
    INDEX idx_creators_platform ON creators(platform),
    INDEX idx_creators_username ON creators USING gin(username gin_trgm_ops),
    INDEX idx_creators_follower_count ON creators(follower_count DESC)
);

-- Content table
CREATE TABLE content (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    creator_id UUID NOT NULL REFERENCES creators(id) ON DELETE CASCADE,
    platform platform_type NOT NULL,
    platform_content_id VARCHAR(255) NOT NULL,
    content_type content_type NOT NULL,
    title VARCHAR(500),
    description TEXT,
    content_url TEXT,
    thumbnail_url TEXT,
    view_count BIGINT DEFAULT 0,
    like_count BIGINT DEFAULT 0,
    comment_count BIGINT DEFAULT 0,
    share_count BIGINT DEFAULT 0,
    engagement_rate DECIMAL(5,4),
    hashtags TEXT[],
    mentions TEXT[],
    published_at TIMESTAMP WITH TIME ZONE,
    scraped_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    
    UNIQUE(platform, platform_content_id),
    INDEX idx_content_creator ON content(creator_id),
    INDEX idx_content_platform ON content(platform),
    INDEX idx_content_type ON content(content_type),
    INDEX idx_content_published_at ON content(published_at DESC),
    INDEX idx_content_engagement ON content(engagement_rate DESC),
    INDEX idx_content_hashtags ON content USING gin(hashtags)
);

-- Analytics aggregations table
CREATE TABLE analytics_daily (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    creator_id UUID NOT NULL REFERENCES creators(id) ON DELETE CASCADE,
    platform platform_type NOT NULL,
    date DATE NOT NULL,
    follower_count BIGINT DEFAULT 0,
    content_count INTEGER DEFAULT 0,
    total_views BIGINT DEFAULT 0,
    total_likes BIGINT DEFAULT 0,
    total_comments BIGINT DEFAULT 0,
    avg_engagement_rate DECIMAL(5,4),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    
    UNIQUE(creator_id, platform, date),
    INDEX idx_analytics_creator_date ON analytics_daily(creator_id, date DESC),
    INDEX idx_analytics_platform_date ON analytics_daily(platform, date DESC)
);

-- Scraping jobs table
CREATE TABLE scraping_jobs (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    platform platform_type NOT NULL,
    job_type VARCHAR(50) NOT NULL, -- 'creator_discovery', 'content_scraping', 'analytics_update'
    target_id VARCHAR(255), -- creator ID or content ID
    status VARCHAR(20) DEFAULT 'pending', -- 'pending', 'running', 'completed', 'failed'
    attempts INTEGER DEFAULT 0,
    max_attempts INTEGER DEFAULT 3,
    scheduled_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    started_at TIMESTAMP WITH TIME ZONE,
    completed_at TIMESTAMP WITH TIME ZONE,
    error_message TEXT,
    metadata JSONB,
    
    INDEX idx_scraping_jobs_status ON scraping_jobs(status),
    INDEX idx_scraping_jobs_platform ON scraping_jobs(platform),
    INDEX idx_scraping_jobs_scheduled ON scraping_jobs(scheduled_at)
);

-- Rate limiting table
CREATE TABLE rate_limits (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    platform platform_type NOT NULL,
    endpoint VARCHAR(255) NOT NULL,
    requests_made INTEGER DEFAULT 0,
    window_start TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    window_duration_minutes INTEGER DEFAULT 15,
    max_requests INTEGER DEFAULT 100,
    
    UNIQUE(platform, endpoint, window_start),
    INDEX idx_rate_limits_platform ON rate_limits(platform, endpoint)
);

-- Update timestamps function
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Apply update timestamp triggers
CREATE TRIGGER update_creators_updated_at BEFORE UPDATE ON creators
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Create indexes for performance
CREATE INDEX CONCURRENTLY IF NOT EXISTS idx_content_full_text 
ON content USING gin(to_tsvector('english', coalesce(title, '') || ' ' || coalesce(description, '')));

-- Grant permissions (adjust as needed for your application user)
-- GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO your_app_user;
-- GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO your_app_user;