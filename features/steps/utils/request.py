import requests

base_headers = {
    'content-type': 'application/json',
    'accept': 'application/json',
}


def build_header(context):
    headers = base_headers.copy()
    if 'tags' in context and 'unauthenticated' not in context.tags:
        headers['Authorization'] = 'Bearer ' + context.token
    return headers


def get_json(context, url):
    return requests.get(url, headers=build_header(context))


def post_json(context, url, body):
    return requests.post(url, json=body, headers=build_header(context))


def patch_json(context, url, body):
    return requests.patch(url, json=body, headers=build_header(context))


def delete_json(context, url):
    return requests.delete(url, headers=build_header(context))
