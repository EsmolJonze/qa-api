import jwt
import requests
from assertpy import assert_that

from features.steps.utils.request import post_json

base_headers = {
    'content-type': 'application/json',
    'accept': 'application/json',
}


def get_auth_token(context, email, password):
    url = f"{context.jwt_url}/service/jwt/"
    body = {
        'email': email,
        'password': password,
        'claimerSystem': 'web_App'
    }
    response = post_json(context, url, body)
    assert_that(response.status_code).described_as('Error authenticating').is_equal_to(200)
    return response.json()['token']


def get_account_id_from_token(token):
    decoded_token = jwt.decode(token, verify=False)
    return decoded_token['account']


def wipe_account_data(context):
    url = f"{context.web_url}/service/accounts/{context.account_id}/wipeData"
    headers = base_headers.copy()
    headers['authorization'] = 'Bearer ' + context.token
    try:
        # TODO: Make wipe account data take less time
        requests.post(url, headers=headers, json={}, timeout=60)
    except requests.exceptions.ReadTimeout:
        pass
    except:
        raise Exception('Something went wrong trying to wipe the data')
