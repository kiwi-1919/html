#cython:language_level=3
cimport cython
from libc.stdio cimport *
import sys
sys.setrecursionlimit=10**100
import tqdm

cdef size_t loc=0
cdef FILE* file=fopen("tmp.txt","rb")
cdef int status1=0
cdef int status2=0
cdef char c
cdef bytes b1='<'.encode()
cdef bytes b2='>'.encode()
cdef bytes b3='/'.encode()
cdef bytes b4='!'.encode()
cdef char lb=<char>int.from_bytes(b1,'big')
cdef char rb=<char>int.from_bytes(b2,'big')
cdef char sl=<char>int.from_bytes(b3,'big')
cdef char ex=<char>int.from_bytes(b4,'big')
#end-cdef

cdef void parse():
    global loc
    global status1
    global status2
    global c
    fseek(file,loc,SEEK_SET)
    if fread(c,1,1,file)==1:
        if c==lb:
            if fread(c,1,1,file)==1 and c==sl:
                status1+=1
                status2-=1
            elif c==ex:
                status1+=1
            else:
                status1+=1
                status2+=1
        elif c==sl:
            if fread(c,1,1,file)==1 and c==rb:
                status1-=1
                status2-=1
        elif c==rb:
            status1-=1
    loc=ftell(file)
def _parse():
    fseek(file,0,SEEK_END)
    length=ftell(file)
    for _ in tqdm.trange(length):
        parse()
    if status1==0 and status2==0:
        return 0
    else:
        return -1