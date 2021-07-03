#cython:language_level=3
cimport cython
import tkinter.filedialog
import shutil

cdef void find():
	cdef str file=tkinter.filedialog.askopenfilename(filetypes=(("html files","*.html"),("all files","*.*")))
	#end-cdef
	shutil.copyfile(file,"tmp.txt")
	print("get it")