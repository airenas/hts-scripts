import sys

import numpy as np
from argparse import ArgumentParser

parser = ArgumentParser()
parser.add_argument("-f", "--file", dest="filename",
                    help="f0 file", metavar="FILE")
args = parser.parse_args()

if args.filename is not None:
    with open(args.filename, 'rb') as f:
        data = np.fromfile(f, dtype=np.float32)
else:
    data = np.frombuffer(sys.stdin.buffer.read(), dtype=np.float32)

np.savetxt(sys.stdout, data, fmt='%.10f')
