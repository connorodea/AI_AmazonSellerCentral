#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Error handling
set -e

# Function to print colored status messages
print_status() {
    echo -e "${GREEN}==>${NC} $1"
}

print_error() {
    echo -e "${RED}Error:${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}Warning:${NC} $1"
}

# Initialize project structure
init_project() {
    print_status "Initializing project structure..."
    
    # Create source code structure
    mkdir -p src/{processors,utils}
    touch src/__init__.py
    touch src/processors/__init__.py
    touch src/utils/__init__.py
    
    # Create test structure
    mkdir -p tests/{unit,integration}
    touch tests/__init__.py
    touch tests/unit/__init__.py
    touch tests/integration/__init__.py
    
    # Create additional directories with .gitkeep files
    mkdir -p {data,output,logs,docs}
    touch data/.gitkeep output/.gitkeep logs/.gitkeep
    
    print_status "Project structure created"
}

# Create Python package files
create_python_files() {
    print_status "Creating Python files..."
    
    cat > src/processors/amazon_listing_processor.py << 'EOF'
import pandas as pd
import numpy as np
import logging
from datetime import datetime
import os
from pathlib import Path

# Get project root directory
PROJECT_ROOT = Path(__file__).parent.parent.parent
LOG_DIR = PROJECT_ROOT / 'logs'
LOG_FILE = LOG_DIR / 'processor.log'

# Ensure log directory exists
os.makedirs(LOG_DIR, exist_ok=True)

# Setup logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler(LOG_FILE),
        logging.StreamHandler()
    ]
)

class AmazonListingProcessor:
    def __init__(self):
        self.whse_tags = ['SG', 'SN', 'SE', 'TC', 'RE', 'RN', 'IA', 'RC', 'LC2', 'KE', 'RB', 
                         'KB', 'RF', 'LO', 'RO', 'RB', 'HI1', 'LG1', 'FS', 'SO', 'LE', 'RM']
        self.setup_logging()

    def setup_logging(self):
        """Set up logging configuration"""
        self.logger = logging.getLogger(self.__class__.__name__)
        self.logger.setLevel(logging.INFO)

    def process(self):
        """Main processing method"""
        try:
            self.logger.info("Starting inventory processing")
            # Add your processing logic here
            self.logger.info("Processing completed")
        except Exception as e:
            self.logger.error(f"Error processing inventory: {str(e)}")
            raise

if __name__ == "__main__":
    processor = AmazonListingProcessor()
    processor.process()
EOF
    
    print_status "Python files created"
}

# Create test files
create_test_files() {
    print_status "Creating test files..."
    
    cat > tests/unit/test_processor.py << 'EOF'
import unittest
from pathlib import Path
import sys

# Add project root to Python path
project_root = Path(__file__).parent.parent.parent
sys.path.append(str(project_root))

from src.processors.amazon_listing_processor import AmazonListingProcessor

class TestAmazonListingProcessor(unittest.TestCase):
    def setUp(self):
        self.processor = AmazonListingProcessor()

    def test_initialization(self):
        """Test processor initialization"""
        self.assertIsNotNone(self.processor)
        self.assertTrue(len(self.processor.whse_tags) > 0)

if __name__ == '__main__':
    unittest.main()
EOF
    
    print_status "Test files created"
}

# Create utility scripts
create_scripts() {
    print_status "Creating utility scripts..."
    mkdir -p scripts
    
    # Create run-tests script
    cat > scripts/run-tests.sh << 'EOF'
#!/bin/bash
set -e

# Activate virtual environment if it exists
if [ -d "venv" ]; then
    source venv/bin/activate
fi

echo "Running tests..."
python -m unittest discover tests -v
EOF
    
    chmod +x scripts/run-tests.sh
    print_status "Utility scripts created"
}

# Create requirements file
create_requirements() {
    print_status "Creating requirements.txt..."
    
    cat > requirements.txt << 'EOF'
pandas>=1.3.0
openpyxl>=3.0.7
numpy>=1.21.0
pytest>=7.0.0
EOF

    print_status "Requirements file created"
}

# Main initialization
main() {
    print_status "Starting project initialization..."
    
    init_project
    create_python_files
    create_test_files
    create_scripts
    create_requirements
    
    print_status "Project initialized successfully!"
    echo
    print_warning "Next steps:"
    echo "1. Setup virtual environment: python -m venv venv"
    echo "2. Activate virtual environment: source venv/bin/activate"
    echo "3. Install requirements: pip install -r requirements.txt"
    echo "4. Run tests: ./scripts/run-tests.sh"
}

# Run main
main
