#cython:language_level=3
cimport cython
import sys,tkinter

cdef void export(int status):
    if status==0:
        print("alright")
    elif status==-1:
        window=tkinter.Tk()
        window.title("error")
        window.geometry("350x200")
        with open("tmp.txt","rt",encoding="utf-8") as file:
            it=iter(file.readlines())
        lbl=tkinter.Label(window,text=next(it))
        lbl.grid(column=0,row=0)
        def click():
            lbl.configure(text=next(it))
        btn=tkinter.Button(window,text="next",command=click)
        btn.grid(column=1,row=0)
        window.mainloop()
    else:
        sys.exit()
def _export(result=0):
    export(result)