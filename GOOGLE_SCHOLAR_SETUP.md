# Google Scholar Integration Configuration

# To set up real-time Google Scholar integration:

## Method 1: Direct Google Scholar (Limited, for demo only)
1. Find your Google Scholar profile URL (e.g., https://scholar.google.com/citations?user=ABC123&hl=en)
2. Extract your user ID (the part after `user=`, e.g., `ABC123`)
3. Replace `YOUR_SCHOLAR_ID` in `lib/personal_web_web/live/dashboard_live.ex` with your actual ID

## Method 2: SerpApi (Recommended for production)
1. Sign up for SerpApi at https://serpapi.com/
2. Get your API key from the dashboard
3. Add your API key to your environment variables:
   ```
   export SERPAPI_KEY="your_api_key_here"
   ```
4. Update the GoogleScholar.get_live_metrics call in dashboard_live.ex:
   ```elixir
   GoogleScholar.get_live_metrics(@scholar_user_id, use_serpapi: true, api_key: System.get_env("SERPAPI_KEY"))
   ```

## Method 3: Scholarly Python Library (Advanced)
For more sophisticated scraping, you can use the Python `scholarly` library:
1. Install Python and the scholarly library
2. Create a Python script to fetch data and save to JSON
3. Read the JSON file from Elixir

## Configuration Variables

### Environment Variables (set in your system or .env file):
- `SCHOLAR_USER_ID`: Your Google Scholar user ID
- `SERPAPI_KEY`: Your SerpApi API key (if using Method 2)
- `SCHOLAR_REFRESH_INTERVAL`: Refresh interval in milliseconds (default: 300000 = 5 minutes)

### Example Scholar User IDs:
- Replace with your actual ID from your Google Scholar profile URL
- Example format: "ABC123DEF456" (letters and numbers)

## Setting up Environment Variables

### Development:
Create a `.env` file in your project root:
```
SCHOLAR_USER_ID=YOUR_ACTUAL_ID_HERE
SERPAPI_KEY=your_serpapi_key_if_using
SCHOLAR_REFRESH_INTERVAL=300000
```

### Production:
Set environment variables in your deployment platform:
- Heroku: `heroku config:set SCHOLAR_USER_ID=your_id`
- Railway: Set in the environment variables section
- Fly.io: Add to fly.toml or set via CLI

## Features:
- ✅ Real-time citation count updates
- ✅ Live h-index and i10-index tracking
- ✅ Publication metrics by year
- ✅ Citation timeline visualization
- ✅ Automatic refresh every 5 minutes
- ✅ Manual refresh button
- ✅ Live/static data indicator
- ✅ Trend analysis (growing/stable/accelerating)

## Notes:
- The system falls back to static data if live fetching fails
- Charts update smoothly without full page reload
- Data is cached to avoid excessive API calls
- Implements rate limiting for Google Scholar requests
