import sys
from conv_functions import ct2hz

for line in sys.stdin:
    number = float(line)
    v = ct2hz(number)
    print('%.10f' % v)
