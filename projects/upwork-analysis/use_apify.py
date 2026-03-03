#!/usr/bin/env python3
"""
Use Apify free tier to get Upwork job samples
"""
import json
import urllib.request

# Apify public dataset endpoint for Upwork scraper sample
# Try getting sample data from public runs
datasets = [
    "https://api.apify.com/v2/datasets/nec~upwork-job-scraper/items?clean=true&format=json&limit=100",
]

for url in datasets:
    try:
        print(f"Trying: {url[:60]}...")
        req = urllib.request.Request(url, headers={'User-Agent': 'Mozilla/5.0'})
        with urllib.request.urlopen(req, timeout=10) as response:
            data = json.loads(response.read().decode())
            print(f"Got {len(data)} items")
            if data:
                print(json.dumps(data[:2], indent=2))
    except Exception as e:
        print(f"Failed: {e}")
