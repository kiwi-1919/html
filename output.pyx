#cython:language_level=3
cimport cython
import sys,os

cdef void export(int status):
    if status==0:
        print("alright")
    elif status==1:
        print("error:anno")
    elif status==2:
        print("error:ps")
    elif status==3:
        print("error:sp")
    elif status==4:
        print("error:ss")
    else:
        sys.exit()
    os.system("pause")
def _export(result=0):
    export(result)