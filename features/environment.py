from features.steps.utils.account import get_auth_token, get_account_id_from_token
from features.steps.utils.data_model import DataModel
from features.steps.utils.reference_manager import ReferenceManager



def before_all(context):

    environment = context.config.userdata.get("env") or "dev"

    default_email = 'qaapi@bloobirds.com'
    default_password = 'tesla'

    userdata = context.config.userdata
    email = userdata.get('email', default_email)
    password = userdata.get('password', default_password)

    context.jwt_url = 'https://jwt-api.' + environment + '-bloobirds.com'
    context.web_url = 'https://web-api.' + environment + '-bloobirds.com'
    context.bobject_url = 'https://bobject-api.' + environment + '-bloobirds.com'
    context.rest_url = 'https://bobject-api.' + environment + '-bloobirds.com'

    context.token = get_auth_token(context, email, password)
    context.account_id = get_account_id_from_token(context.token)
    context.data_model = DataModel(context)
    context.initial_value = 0
    # TODO: When wipe data is faster, do it before each scenario
    # wipe_account_data(context)


def before_scenario(context, scenario):
    context.reference_manager = ReferenceManager()
    context.account_settings = {
        'duplicateValidation': False
    }
