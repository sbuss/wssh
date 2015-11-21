import base64


def encode(data):
    return str(base64.b64encode(data), 'utf-8')


def decode(data):
    return base64.b64decode(bytearray(data, 'utf-8'))
