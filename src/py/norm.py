import sys

import numpy as np
import matplotlib.pyplot as plt
from argparse import ArgumentParser

from conv_functions import hz2ct, ct2hz


def normalize(hz, fix):
    if hz < -100:
        return hz
    v = np.power(np.e, hz)
    v = hz2ct(v)
    v = v + fix
    v = ct2hz(v)
    v = np.log(v)
    return v


if __name__ == '__main__':
    parser = ArgumentParser()
    parser.add_argument("-in", "--file", dest="filename", help="f0 file", metavar="FILE")
    parser.add_argument("-f", dest="fix", type=float, default=0)
    args = parser.parse_args()

    if args.filename is not None:
        with open(args.filename, 'r') as f:
            data = np.loadtxt(f, dtype=np.float32)
    else:
        data = np.loadtxt(sys.stdin, dtype=np.float32)

    f = lambda x: normalize(x, args.fix)
    data = np.vectorize(f)(data)
    np.savetxt(sys.stdout, data, fmt='%.10f')