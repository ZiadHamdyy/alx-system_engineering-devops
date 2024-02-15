#!/usr/bin/python3
"""queries the Reddit API"""
import requests


def number_of_subscribers(subreddit):
    """returns the number of subscribers"""
    headers = {'User-Agent': 'Custom User Agent'}
    url = f'https://www.reddit.com/r/{subreddit}/about.json'

    try:
        req = requests.get(url, headers=headers, allow_redirects=False)
        req.raise_for_status()

        if 'subscribers' in req.json()['data']:
            return req.json()['data']['subscribers']
        else:
            return 0
    except requests.exceptions.HTTPError as e:
        if e.response.status_code == 404:
            return 0
        elif e.response.status_code == 302:
            return 0
        else:
            raise e


if __name__ == '__main__':
    import sys

    if len(sys.argv) < 2:
        print("Please pass an argument for the subreddit to search.")
    else:
        subscribers = number_of_subscribers(sys.argv[1])
        print("{:d}".format(subscribers))
