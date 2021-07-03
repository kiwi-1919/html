#cython:language_level=3
cimport cython
import sys
sys.path.append('.')
import input
import output
import core

def main():
	input._find()
	result=core._parse()
	output._export(result)