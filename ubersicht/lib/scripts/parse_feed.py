#!/usr/bin/env python3

import sys
import json
import html
import feedparser


def main():
    entries = []
    try:
        [title, url, limit] = sys.argv[1:4]
        feed = feedparser.parse(url)
        feed_entries = feed['entries'][:int(limit)]
        for entry in feed_entries:
            entries.append({
                'title': sanitize(entry['title']),
                'link': entry['link'],
            })
    finally:
        print(json.dumps(entries))


def sanitize(string):
    return html.unescape(string.encode('utf-8').decode())


if __name__ == '__main__':
    main()
