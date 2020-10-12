import sys

import numpy as np
import matplotlib.pyplot as plt
from argparse import ArgumentParser

parser = ArgumentParser()
parser.add_argument("-f", "--file", dest="filename", help="f0 file", metavar="FILE")
parser.add_argument("-s", dest="start", type=int, default=0)
parser.add_argument("-e", dest="end", type=int, default=-1)
args = parser.parse_args()

if args.filename is not None:
    with open(args.filename, 'r') as f:
        data = np.loadtxt(f, dtype=np.float32)
else:
    data = np.loadtxt(sys.stdin, dtype=np.float32)

if args.end == -1:
    args.end = data.shape[0]
print("args.start", args.start, file=sys.stderr)
print("args.end", args.end, file=sys.stderr)
d = data[args.start: args.end]
d[d < -100] = 0

dv = d[d > 2]
print("Min: ", np.min(dv), file=sys.stderr)
print("Max:", np.max(dv), file=sys.stderr)

plt.figure(1)
n, bins, patches = plt.hist(dv, 50, facecolor='blue', alpha=0.5)

plt.figure(2)
plt.title("F0")
pd = d
pd[pd < 2] = np.nan
x = np.arange(pd.shape[0]) * 0.005
plt.plot(x, pd)
plt.savefig(sys.stdout.buffer, format="pdf")  
# plt.show()
