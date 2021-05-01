from time import sleep

from assertpy import assert_that


def wait(seconds):
    def decorator(func):
        def wrapper(*args, **kwargs):
            sleep(seconds)
            return func(*args, **kwargs)

        return wrapper

    return decorator


def retry(attempts):
    def decorator(func):
        def wrapper(*args, **kwargs):
            for i in range(attempts):
                try:
                    return func(*args, **kwargs)
                except Exception as exception:
                    if (i + 1) == attempts:
                        raise exception
                    sleep(2)

        return wrapper

    return decorator


def normalize():
    english_to_bobject_type = {
        "company": "Company",
        "lead": "Lead",
        "task": "Task",
        "activity": "Activity",
        "opportunity": "Opportunity",
        "companies": "Company",
        "leads": "Lead",
        "tasks": "Task",
        "activities": "Activity",
        "opportunities": "Opportunity",
    }

    def decorator(func):
        def wrapper(*args, **kwargs):
            if 'bobject_type' in kwargs:
                bobject_type = kwargs['bobject_type'].lower()
                assert_that(english_to_bobject_type).contains(bobject_type)
                kwargs['bobject_type'] = english_to_bobject_type[bobject_type]
            return func(*args, **kwargs)

        return wrapper

    return decorator
