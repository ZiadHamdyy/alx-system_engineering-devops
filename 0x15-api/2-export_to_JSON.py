#!/usr/bin/python3
"""Python script to export data in the JSON format"""

import json
import requests
import sys

if __name__ == '__main__':
    user = requests.get("https://jsonplaceholder.typicode.com/users/{}".format(
            sys.argv[1])).json()
    todos = requests.get("https://jsonplaceholder.typicode.com/todos",
                         params={"userId": sys.argv[1]}).json()

    employee_id = sys.argv[1]

    data_to_dump = {employee_id: []}

    for todo in todos:
        task_data = {
            "task": todo.get("title"),
            "completed": todo.get("completed"),
            "username": user.get("username")
        }
        data_to_dump[employee_id].append(task_data)

    with open(f"{employee_id}.json", "w") as file:
        json.dump(data_to_dump, file)
