great now with that groundwork I need to setup a work flow for each of these plateforms and start collecting asap. layout a prompt for me to direct and oversee  the various LLM models to code up a feasible system quickly. starting with a GitHub repo and neon server

To oversee rapid development of a multi-platform creator data collection system using LLM code agents, here is an actionable prompt/workflow outline for initializing your GitHub repo and Neon server, ensuring modular, parallel development across social platforms[1][2][3][4][5].

### Multi-Platform Scraper System LLM Prompt

"Act as a lead AI engineer managing a team of LLM agents. The goal is to create a scalable, automated system to collect, store, and serve creator-relevant data from all major social platforms (Snapchat, Instagram, TikTok, YouTube, Twitter/X, Facebook, Reddit).

#### Initial Setup
- Create a new public GitHub repository (suggest name: creator-aggregator).
- Integrate a Neon serverless Postgres instance for immediate, cloud-native data storage.
- Scaffold the repo with a directory for each major platform (e.g., `/snapchat`, `/instagram`, etc.).
- Include a monorepo root README detailing system goals, orchestration overview, platform modules, and database schema plans.
- Ensure robust environment setup using a single Docker Compose file to unify dev/testing.

#### Platform Workflow
For each platform:
1. Research open-source, LLM-assisted web scraping agents and existing scraper libraries for fast bootstrapping[1][2][6][7].
2. Build an agent that:
   - Authenticates (if needed) and fetches public profile, trending content, engagement stats, follower counts, and recent posts.
   - Outputs data in a standardized format (JSON, ready for database ingest).
3. Sync each platform scraper to push structured results to the Neon Postgres server using the Neon MCP server or direct integration[3][4][5].
4. Document APIs, endpoints, and schema for both scraping code and the database.
5. Build automated tests to verify correct data extraction and storage.
6. Provide a single entry-point orchestrator script that can launch all scrapers in parallel or via scheduled jobs.

#### Tech & Code Guidance
- Use TypeScript + llm-scraper for easy LLM-based structured scraping[1].
- Support custom schema models for each platform, standardizing key fields (e.g., username, followers, posts, engagement).
- Integrate the Neon server using official Neon MCP server tools for natural-language DB ops, simplified DDL/DML creation, and connection setup[4][5].
- Document workflow in Markdown, including example commands and usage.

#### LLM Coding Agents: Instructions
- For each module, generate robust, reusable code that handles authentication, data fetching, error handling, and schema mapping.
- Use GitHub Actions or similar CI/CD to automatically test code and push updates.
- Prioritize speed: leverage open-source projects where possible, rapidly prototype, and iterate modules in parallel.

### Example Output Structure
- `/snapchat/scraper.ts` (LLM scraper agent for Snapchat)
- `/instagram/scraper.ts`
- `/twitter/scraper.ts`
- `/database/schema.sql` (Neon-compatible schema)
- `/orchestrator/index.ts` (runs, monitors, and logs jobs; easy scaling)
- `/README.md` (detailed setup and usage)

***

Direct the LLM agents to start with the above workflow, ensuring documentation, modularity, and immediate database and repo readiness for rapid creator onboarding and data baiting[1][2][3][4][5].

