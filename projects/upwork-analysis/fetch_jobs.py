#!/usr/bin/env python3
"""
Upwork Job Analyzer - Om Patel Playbook Implementation
Fetches jobs via RSS, analyzes for automation opportunities
"""

import feedparser
import json
import re
from datetime import datetime
from urllib.parse import quote

# Categories to analyze
SEARCH_TERMS = [
    "AI automation",
    "workflow automation", 
    "voice assistant",
    "chatbot",
    "lead generation automation",
    "appointment scheduling",
    "phone answering service",
    "virtual receptionist",
    "data entry automation",
    "CRM automation",
    "email automation",
    "customer service automation",
    "booking system",
    "call center",
    "AI agent",
    "zapier integration",
    "make.com integration",
    "n8n automation"
]

def get_rss_url(query):
    """Construct Upwork RSS feed URL for a search query"""
    encoded = quote(query)
    return f"https://www.upwork.com/ab/feed/jobs/rss?q={encoded}&sort=recency"

def parse_budget(text):
    """Extract budget from job description"""
    # Fixed price patterns
    fixed = re.findall(r'\$[\d,]+(?:\.\d{2})?', text)
    # Hourly patterns  
    hourly = re.findall(r'\$(\d+(?:\.\d{2})?)\s*[-–]\s*\$(\d+(?:\.\d{2})?)/hr', text)
    
    if hourly:
        low, high = hourly[0]
        return {"type": "hourly", "low": float(low), "high": float(high)}
    elif fixed:
        amounts = [float(f.replace('$','').replace(',','')) for f in fixed]
        return {"type": "fixed", "amount": max(amounts) if amounts else 0}
    return None

def fetch_jobs(query):
    """Fetch jobs for a single search term"""
    url = get_rss_url(query)
    print(f"Fetching: {query}...")
    
    try:
        feed = feedparser.parse(url)
        jobs = []
        
        for entry in feed.entries[:20]:  # Top 20 per category
            job = {
                "title": entry.get("title", ""),
                "link": entry.get("link", ""),
                "summary": entry.get("summary", "")[:500],
                "published": entry.get("published", ""),
                "category": query,
                "budget": parse_budget(entry.get("summary", ""))
            }
            jobs.append(job)
            
        return jobs
    except Exception as e:
        print(f"Error fetching {query}: {e}")
        return []

def main():
    all_jobs = []
    
    for term in SEARCH_TERMS:
        jobs = fetch_jobs(term)
        all_jobs.extend(jobs)
        
    # Dedupe by link
    seen = set()
    unique_jobs = []
    for job in all_jobs:
        if job["link"] not in seen:
            seen.add(job["link"])
            unique_jobs.append(job)
    
    # Save raw data
    with open("jobs_raw.json", "w") as f:
        json.dump(unique_jobs, f, indent=2)
    
    print(f"\nCollected {len(unique_jobs)} unique jobs across {len(SEARCH_TERMS)} categories")
    return unique_jobs

if __name__ == "__main__":
    main()
