#cython:language_level=3
cimport cython
import sys,tkinter

cdef void export(int status):
    if status==0:
        print("alright")
    elif status==-1:
        window=tkinter.Tk()
        window.title("error")
        with open("tmp.txt","rt") as file:
            lbl=tkinter.Label(window,text=file.read())
            lbl.grid(column=0,row=0)
            window.mainloop()
    else:
        sys.exit()
def _export(result=0):
    export(result)