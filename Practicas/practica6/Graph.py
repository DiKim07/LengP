# -*- coding: utf-8 -*-
class Graph(object):

		direccion = 0
		vertices = [] #arreglo vacío
		aristas = [] #arreglo vacío

		#Crea una gráfica 	
		def crearGrafica(d, v, a):	
			direccion = d
			vertices = v
			aristas = a

		#devuelve true si d=1 (es dirigida)
		#devuelve false si d=0 (no es dirigida)
		def directed(d):
			if (d == 0) :
				return True
			else:
				return False


		def vertices():
			return vertices
		
		def edges():
			return aristas	

		
