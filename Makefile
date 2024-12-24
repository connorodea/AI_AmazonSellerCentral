# Variables
VENV = venv
PYTHON = $(VENV)/bin/python
PIP = $(VENV)/bin/pip

# Default target
.DEFAULT_GOAL := help

# Help target
help:
	@echo "Available targets:"
	@echo "  make install       - Install dependencies"
	@echo "  make test          - Run tests"
	@echo "  make lint          - Lint the code with flake8"
	@echo "  make clean         - Clean up cache files"
	@echo "  make activate      - Activate the virtual environment"
	@echo "  make setup-venv    - Create and set up the virtual environment"
	@echo "  make build         - Package the project"

# Install dependencies
install: $(VENV)
	@echo "Installing dependencies..."
	$(PIP) install -r requirements.txt

# Run tests
test: $(VENV)
	@echo "Running tests..."
	$(PYTHON) -m pytest

# Lint the code
lint: $(VENV)
	@echo "Linting code with flake8..."
	flake8 src tests

# Clean up cache files
clean:
	@echo "Cleaning up Python cache files..."
	find . -name "*.pyc" -delete
	find . -name "__pycache__" -delete

# Create and set up virtual environment
setup-venv:
	@echo "Setting up virtual environment..."
	python3 -m venv $(VENV)
	$(PIP) install --upgrade pip

# Activate the virtual environment
activate:
	@echo "To activate the virtual environment, run:"
	@echo "source $(VENV)/bin/activate"

# Build the project
build: $(VENV)
	@echo "Building the project..."
	$(PYTHON) setup.py sdist

# Dependency to ensure virtual environment exists
$(VENV):
	@echo "Creating virtual environment..."
	python3 -m venv $(VENV)
	$(PIP) install --upgrade pip
