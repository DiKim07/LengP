
# -*- coding: utf-8 -*-
from Graph import Graph
from Vertex import Vertex
from Edges import Edges

class GraphReader(Graph): #hereda de la clase Graph

	direccion = 1 #suponemos que es dirigida


	global arista
	arista = Edges()
	longitud = 0
	bandera = False

	global vecinos
	vecinos = []



	#Calcula el numero de lineas de un archivo .csv para determinar
	#la longitud del arreglo que contendrá a todas las aristas de la gráfica
	def leerArchivo(self):
	
		iterlen = lambda it: sum(1 for _ in it) #el iterador
		lineas = iterlen(file("petersen.csv"))#calculamos la longitud del iterador
		
		global longitud #declaramos longitud como global
		longitud = lineas
		global vertices
		vertices = [longitud] #arreglo vacío
		
		archivo.seek(0)#devolvemos el puntero al inicio del archivo para poder leer posteriormente




	#Lee caracter por caracter hasta el digito que indica si la grafica es dirigida o no
	def leerDireccion(self):

		archivo = open("petersen.csv", "r")#declaramos el archivo a leer, lo abrimos en modo lectura

		while True:
       			letra = archivo.read(1)#los bytes que va a leer

         		if not letra:
           			print "End of file"
           			break
           		if (letra == 0):
           			global direccion #declaramos la variable como global
           			direccion = 0
           	
		#cerramos el archivo
		archivo.close()
		archivo.seek(0)#devolvemos el puntero al inicio del archivo para poder leer posteriormente


	#lee el archivo para conseguir los datos de las aristas y los vertices.
	def leerGrafica(self):
		archivo = open("petersen.csv", "r")#declaramos el archivo a leer, lo abrimos en modo lectura

		archivo.readline()#leemos la primera para que el puntero apunte a la segunda linea
		#y así comenzar a leer los demas datos
		for line in archivo:
				long = len(line)

				#vertice1.crearVertice(line[1],0,vecinos)
				#vertice2.crearVertice(line[6],0,vecinos)

				#arista.crearArista(vertice1,vertice2, 0)#crea una arista
				

		archivo.seek(0)#devolvemos el puntero al inicio del archivo para poder leer posteriormente

		#cerramos el archivo
		archivo.close()
		


metodo = GraphReader()
metodo.leerDireccion()
metodo.leerArchivo()
metodo.leerGrafica()






