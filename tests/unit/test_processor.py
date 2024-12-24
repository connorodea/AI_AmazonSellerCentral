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
