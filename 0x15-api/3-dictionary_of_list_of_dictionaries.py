#!/usr/bin/python3
"""Python script to export data in the JSON format"""

import json
import requests

user = requests.get("https://jsonplaceholder.typicode.com/users").json()

todo_data = {}

for u in user:
    user_id = u.get("id")

    todos = requests.get("https://jsonplaceholder.typicode.com/todos",
                         params={"userId": user_id}).json()

    user_tasks = [{
        "task": todo.get('title'),
        "completed": todo.get('completed'),
        "username": u.get("username")
    } for todo in todos]

    todo_data[user_id] = user_tasks

if __name__ == "__main__":
    with open('todo_all_employees.json', 'w') as jsonfile:
        json.dump(todo_data, jsonfile)
