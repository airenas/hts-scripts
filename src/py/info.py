import sys

import numpy as np
from argparse import ArgumentParser

parser = ArgumentParser()
parser.add_argument("-f", "--file", dest="filename", help="f0 file", metavar="FILE")
args = parser.parse_args()

if args.filename is not None:
    with open(args.filename, 'r') as f:
        data = np.loadtxt(f, dtype=np.float32)
else:
    data = np.loadtxt(sys.stdin, dtype=np.float32)

print("Len: ", (data.shape[0]/(16000/80)), "s")
dgz = data[data > 0]
print("Min: ", np.min(dgz), "Max: ", np.max(dgz), "Avg: ", np.mean(dgz))
