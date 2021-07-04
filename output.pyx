#cython:language_level=3
cimport cython
import sys

cdef void export(int status):
    if status==0:
        print("alright")
    elif status==-1:
        print("error")
    else:
        sys.exit()
def _export(result=0):
    export(result)