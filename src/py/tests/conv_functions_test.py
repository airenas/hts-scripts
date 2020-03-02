import unittest

import numpy as np

import conv_functions


class Hz2CtTestCase(unittest.TestCase):
    def test_fromAndTos(self):
        self.assertAlmostEqual(conv_functions.ct2hz(conv_functions.hz2ct(200)), 200)
        self.assertAlmostEqual(conv_functions.ct2hz(conv_functions.hz2ct(100)), 100)
        self.assertAlmostEqual(conv_functions.ct2hz(conv_functions.hz2ct(300)), 300)
        self.assertAlmostEqual(conv_functions.ct2hz(conv_functions.hz2ct(50)), 50)
        self.assertAlmostEqual(conv_functions.ct2hz(conv_functions.hz2ct(2000)), 2000)

    def test_array(self):
        mat = np.array([100, 200, 300, 100])
        res = np.vectorize(conv_functions.hz2ct)(mat)
        print (res)
        self.assertTrue(np.allclose(res, [4334.99556734, 5534.99557438, 6236.95057937, 4334.99556734]))


if __name__ == '__main__':
    unittest.main()
