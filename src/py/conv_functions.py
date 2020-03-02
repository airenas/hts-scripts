import numpy as np

FREQ_REF_POINT = 8.1758
HALF_TONE = 1.059463094


def hz2ct(hz):
    if hz < FREQ_REF_POINT:
        return hz
    return 100 * np.log(hz / FREQ_REF_POINT) / np.log(HALF_TONE)


def ct2hz(ct):
    if ct < 1E-6:
        return ct
    return FREQ_REF_POINT * np.power(HALF_TONE, (ct / 100))
