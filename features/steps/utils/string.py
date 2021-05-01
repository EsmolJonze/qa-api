from difflib import SequenceMatcher


def similar_words_score(a, b):
    return SequenceMatcher(None, a.lower(), b.lower()).ratio()


def to_upper_snake_case(a):
    return a.replace(' ', '_').upper()
