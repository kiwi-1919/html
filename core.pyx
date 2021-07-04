#cython:language_level=3
cimport cython
from libc.stdio cimport *
import sys
sys.setrecursionlimit=10**100

cdef int pp=0
cdef int anno=1
cdef int ps=2
cdef int sp=3
cdef int ss=4

cdef int parse():
    cdef FILE* file=fopen("tmp.txt","rb")
    cdef int status=pp
    cdef char c
    cdef char lb=<char>'<'.encode()
    cdef char rb=<char>'>'.encode()
    cdef char sl=<char>'/'.encode()
    cdef char ex=<char>'!'.encode()
    #end-cdef
    while True:
        if status==pp and fread(&c,1,1,file)==1 and c==lb:
            if fread(&c,1,1,file)==1 and c==ex:
                status=anno
            else:
                status=ss
        if status==anno and fread(&c,1,1,file)==1 and c==rb:
            status=pp
        if status==ss and fread(&c,1,1,file)==1 and c==sl:
            if fread(&c,1,1,file)==1 and c==rb:
                status=pp
        if status==ss and fread(&c,1,1,file)==1 and c==rb:
            status==ps
        if status==ps and fread(&c,1,1,file)==1 and c==lb:
            if fread(&c,1,1,file)==1 and c==sl:
                status=sp
        if status==sp and fread(&c,1,1,file)==1 and c==rb:
            status=pp
        if ftell(file)==SEEK_END:
            break
    fclose(file)
    print("succeed")
    return status
def _parse():
    try:
        return parse()
    except Exception as error:
        print(error)