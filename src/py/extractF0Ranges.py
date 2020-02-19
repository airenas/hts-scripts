import re
import sys
from argparse import ArgumentParser
from collections import namedtuple

minMax = namedtuple("minMax", "min max")

parser = ArgumentParser()
parser.add_argument("-f", "--file", dest="filename", help="f0 file", metavar="FILE")
args = parser.parse_args()

if args.filename is not None:
    f = open(args.filename, 'r')
else:
    f = sys.stdin

res = {}
for line in f:
    s = line.split(" ")
    if (s is not None) and (s[0] is not None):
        search = re.search('.*\\\\(.*)_A.*', s[0], re.IGNORECASE)
        if search is not None:
            sp = search.group(1)
            min = float(s[3])
            max = float(s[5])
            # print(sp, min, max)
            if sp in res:
                spData = res[sp]
                if spData.min < min:
                    min = spData.min
                if spData.max > max:
                    max = spData.max
            res[sp] = minMax(min, max)

for k, v in res.items():
    print(k, round(v.min) - 1, round(v.max) + 2)
