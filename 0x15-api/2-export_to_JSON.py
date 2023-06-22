#!/usr/bin/python3
"""Exports tasks owned by specified USER_ID in JSON format"""

if __name__ == "__main__":
    import json
    import requests
    from sys import argv

    USER_ID = argv[1]
    user_dict = {}
    r = requests.get("https://jsonplaceholder.typicode.com/users/{}".
                     format(argv[1])).json()
    USERNAME = r.get("username")
    r = requests.get("https://jsonplaceholder.typicode.com/todos?userId={}".
                     format(argv[1])).json()
    user_dict[USER_ID] = [{"task": i.get("title"),
                           "completed": i.get("completed"),
                           "username": USERNAME} for i in r]

    with open(USER_ID + ".json", "w") as jsonfile:
        json.dump(user_dict, jsonfile)
