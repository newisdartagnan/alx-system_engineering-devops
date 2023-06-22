#!/usr/bin/python3
"""Uses given employee ID to return imformation"""

if __name__ == "__main__":
    import requests
    from sys import argv

    NUMBER_OF_DONE_TASKS = 0
    TASK_TITLE = []
    r = requests.get("https://jsonplaceholder.typicode.com/users/{}".
                     format(argv[1])).json()
    EMPLOYEE_NAME = r.get("name")
    r = requests.get("https://jsonplaceholder.typicode.com/todos?userId={}".
                     format(argv[1])).json()
    for i in r:
        if i.get("completed") is True:
            TASK_TITLE.append(i.get("title"))
            NUMBER_OF_DONE_TASKS += 1
    TOTAL_NUMBER_OF_TASKS = len(r)

    print("Employee {} is done with tasks({}/{}):".
          format(EMPLOYEE_NAME, NUMBER_OF_DONE_TASKS, TOTAL_NUMBER_OF_TASKS))
    for title in TASK_TITLE:
        print("\t {}".format(title))
