#cython:language_level=3
cimport cython
import sys
sys.path.append('.')
import input
import output
import core

def main():
	input.find()
	result=core.parse()
	output.export(result)