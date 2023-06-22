#!/usr/bin/python3
"""Exports all tasks in JSON format"""

if __name__ == "__main__":
    import json
    import requests

    all_dict = {}
    r1 = requests.get("https://jsonplaceholder.typicode.com/users").json()
    r2 = requests.get("https://jsonplaceholder.typicode.com/todos").json()
    all_dict = {j.get("id"): [{"task": i.get("title"),
                               "completed": i.get("completed"),
                               "username": j.get("username")} for i in r2
                              if i.get("userId") == j.get("id")]
                for j in r1}

    with open("todo_all_employees.json", "w") as jsonfile:
        json.dump(all_dict, jsonfile)
