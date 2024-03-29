#!/usr/bin/python3
"""a Python script that, using this REST API, for a given employee ID"""
import requests
import sys


if __name__ == '__main__':
    """main function to excute only with this file"""
    if len(sys.argv) != 2:
        print('Usage: python3 todo.py EMPLOYEE_ID')
        sys.exit(1)
    employee_id = sys.argv[1]

    user = requests.get("https://jsonplaceholder.typicode.com/users/{}".format(
            sys.argv[1])).json()
    todo = requests.get("https://jsonplaceholder.typicode.com/todos",
                        params={"userId": sys.argv[1]}).json()

    completed_tasks = []

    for task in todo:
        if task.get('completed'):
            completed_tasks.append(task['title'])

    print("Employee {:s} is done with tasks({:d}/{:d}):".format(
        user.get('name'), len(completed_tasks), len(todo)))

    for task in completed_tasks:
        print("\t {:s}".format(task))
