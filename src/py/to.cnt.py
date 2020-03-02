import sys

from conv_functions import hz2ct

for line in sys.stdin:
    number = float(line)
    v = hz2ct(number)
    print('%.10f' % v)
