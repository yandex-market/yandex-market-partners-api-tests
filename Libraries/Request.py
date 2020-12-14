import uuid


def generate_unique() -> str:
    return uuid.uuid4().hex
