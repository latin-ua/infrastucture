import json
import logging
from dstu_a import text_translate_dstu_a
from kmu import text_translate_kmu


logger = logging.getLogger(__name__)


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

def get_translation_methods():
    return ALL_TRANSLATION_METHODS
    
def lambda_handler(event, context):
    source_data = json.loads(event["body"])
    translation_method = source_data.get("translationMethod")
    source_text = source_data.get("text")

    logger.info(f"Received request: {source_text}")

    if translation_method == "KMU":
        return text_translate_kmu(source_text)
    elif translation_method == "DSTU_A":
        return text_translate_dstu_a(source_text)
        