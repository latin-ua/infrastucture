import json

ALL_TRANSLATION_METHODS = [
    {
        "code": "DSTU_A",
        "title": "ДСТУ 9112:2021: Cистема А"
    },
    {
        "code": "KMU",
        "title": "Постанова КМУ № 55 від 27 січня 2010 р."
    },
]


def lambda_handler(event, context):
    return json.dumps(ALL_TRANSLATION_METHODS)