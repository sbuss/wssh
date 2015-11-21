import base64
import six


def encode(data):
    if isinstance(data, six.string_types):
        data = bytes(data, 'utf-8')
    return str(base64.b64encode(data), 'utf-8')


def decode(data):
    return base64.b64decode(bytearray(data, 'utf-8'))
