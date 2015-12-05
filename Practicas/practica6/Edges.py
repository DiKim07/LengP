from Vertex import Vertex
class Edges(object):
		origen = Vertex()
		destino = Vertex()
		peso = 0


		#Recibe o = origen
		#d = destino del tipo vertex
		#p = peso del tipo vertex
		def crearArista(o, d, p):
			origen = o
			destino = d
			peso = p

		#devuelve el vertice origen
		def svertex():
			return origen

		#devuelve el vertice destino
		def tvertex():
			return destino
