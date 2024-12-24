#!/bin/bash
set -e

# Activate virtual environment if it exists
if [ -d "venv" ]; then
    source venv/bin/activate
fi

echo "Running tests..."
python -m unittest discover tests -v
