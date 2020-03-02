import sys

import numpy as np
import matplotlib.pyplot as plt
from argparse import ArgumentParser

parser = ArgumentParser()
parser.add_argument("-f", "--file", dest="filename", help="f0 file", metavar="FILE")
args = parser.parse_args()

if args.filename is not None:
    with open(args.filename, 'r') as f:
        data = np.loadtxt(f, dtype=np.float32)
else:
    data = np.loadtxt(sys.stdin, dtype=np.float32)

v = data[data >= -100]
data[data >= -100] = np.power(np.e, v)
data[data < -100] = 0
np.savetxt(sys.stdout, data, fmt='%.10f')
