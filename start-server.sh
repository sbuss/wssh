#!/usr/bin/env bash
if [[ -f `which python` ]]; then
    python examples/flask_server.py &
else
    python3 examples/flask_server.py &
fi
