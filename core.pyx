#cython:language_level=3
cimport cython
from libc.stdio cimport *
import sys
sys.setrecursionlimit=10**100
import tqdm

cdef int pp=0
cdef int anno=1
cdef int ps=2
cdef int sp=3
cdef int ss=4
cdef size_t loc=0
cdef FILE* file=fopen("tmp.txt","rb")
cdef int status=pp
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

cdef int parse():
    global loc
    global status
    global c
    fseek(file,loc,SEEK_SET)
    if status==pp and fread(&c,1,1,file)==1 and c==lb:
        if fread(&c,1,1,file)==1 and c==ex:
            status=anno
        else:
            status=ss
    if status==anno and fread(&c,1,1,file)==1 and c==rb:
        status=pp
    if status==ss and fread(&c,1,1,file)==1:
        if c==sl:
            if fread(&c,1,1,file)==1 and c==rb:
                status=pp
        elif c==rb:
            status=ps
    if status==ps and fread(&c,1,1,file)==1 and c==lb:
        if fread(&c,1,1,file)==1 and c==sl:
            status=sp
    if status==sp and fread(&c,1,1,file)==1 and c==rb:
        status=pp
    loc=ftell(file)
    return status
def _parse():
    fseek(file,0,SEEK_END)
    length=ftell(file)
    for _ in tqdm.trange(length):
        result=parse()
    return result