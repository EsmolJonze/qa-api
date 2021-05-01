# qa-api

Test bloobirds backend endpoints :beetle:

## Setup

### Using a virtual environment

I strongly recommend using [venv](https://docs.python.org/3/library/venv.html) to isolate the testing environment and avoid polluting the global environment.

Set up the virtual environment and dependencies. This should be done only once usually just after you pulled the repository.

```bash
./setup.sh
```

Everytime you need to work on this environment activate it:

```bash
source activate
```

Once activated you should see that your prompt has changed and added *(venv)* at the beginning.

Now you are safely ready to work isolated from the global environment.

### The "hard way"

Use the python package manager to install the dependencies:

```bash
pip install -r requirements.txt
```

## Usage

Run all the features:

```bash
behave
```

### Configuration

You can use [configuration files](https://behave.readthedocs.io/en/latest/behave.html#configuration-files) to configure behave. Below are the used configuration variables:

```
[behave.userdata]
email=<user email>
password=<user password>
jwt_url=<jwt api url>
web_url=<web api url>
bobject_url=<bobject api url>
```

This is a sample of the contents of a `behave.ini` configuration file:

```
[behave.userdata]
email=testdialer@bloobirds.com
password=tesla
jwt_url=https://jwt-api.preprod-bloobirds.com
web_url=https://web-api.preprod-bloobirds.com
bobject_url=https://bobject-api.preprod-bloobirds.com
```

## Contributing

TODO :writing_hand:
