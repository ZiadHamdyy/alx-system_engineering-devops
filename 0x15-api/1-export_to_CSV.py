#!/usr/bin/python3
"""Python script to export data in the CSV format"""

import csv
import json
import requests
import sys

if __name__ == '__main__':
    """main function to excute only with this file"""
    user = requests.get("https://jsonplaceholder.typicode.com/users/{}".format(
            sys.argv[1])).json()
    todo = requests.get("https://jsonplaceholder.typicode.com/todos",
                        params={"userId": sys.argv[1]}).json()
    for todo in todo:
        to_csv = [sys.argv[1], user.get("username")]
        to_csv.append(todo.get("completed"))
        to_csv.append(todo.get("title"))
        print(to_csv)
        with open('{}.csv'.format(sys.argv[1]), 'a', newline='') as file:
            writer = csv.writer(file, quoting=csv.QUOTE_ALL)
            writer.writerow(to_csv)
        to_csv = []
