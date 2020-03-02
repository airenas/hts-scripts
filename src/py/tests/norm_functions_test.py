import unittest
from norm import normalize


class NormalizeTestCase(unittest.TestCase):
    def test_fromAndTos(self):
        self.assertAlmostEqual(normalize(5, 20), 5.011552452941506)



if __name__ == '__main__':
    unittest.main()
