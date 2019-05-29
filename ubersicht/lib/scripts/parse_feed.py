import sys
import json
import html
import feedparser

# Get arguments
# parse_feed.py [limit] [title1] [link1] [title2] [link2] ...
LIMIT = int(sys.argv[1])
TITLES = sys.argv[2::2]
URLS = sys.argv[3::2]


def main():
    feeds = []
    try:
        for i, title in enumerate(TITLES):
            feed = feedparser.parse(URLS[i])
            feed_entries = feed['entries'][:LIMIT]
            entries = []
            for entry in feed_entries:
                entries.append({
                    'title': sanitize(entry['title']),
                    'link': entry['link'],
                })
            feeds.append({
                'title': title,
                'link': feed['feed']['link'],
                'entries': entries
            })
    finally:
        print(json.dumps(feeds))


def sanitize(string):
    return html.unescape(string.encode('utf-8').decode())


if __name__ == '__main__':
    main()
