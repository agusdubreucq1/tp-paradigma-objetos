class Receta{
	const property nombre
	const property ingredientes = []
	const property nivelDeDificultad
	
	method esDificil() = nivelDeDificultad > 5 ||
		self.cantIngredientes() > 10
	
	method cantIngredientes() = ingredientes.size() 
	
	method experienciaAportada() = 
		nivelDeDificultad * self.cantIngredientes()
}

class Cocinero{
	const property nombre
	var property preparaciones = []
	var property nivelDeAprendizaje
	
	method nivelDeExperiencia() =
		preparaciones.sum({comida => comida.experienciaAportada()})
		
	method puedePreparar(receta)=
		not receta.esDificil()
	
	method pasarAlSiguienteNivel()
	{
	self.error("implementar")}
}

class Principiante inherits Cocinero{
	method preparar(receta){
		if(self.puedePreparar(receta)){
			preparaciones.add(new Comida(receta = receta, calidad = normal))
			if(self.superaNivelDeAprendizaje()){
				self.pasarAlSiguienteNivel()
			}
		}
	}
	
	method superaNivelDeAprendizaje() = 
		self.nivelDeExperiencia() > 100
}

class Experimentado inherits Cocinero{
	method existePreparacionSimilar(receta) =
		preparaciones.any({comida => comida.ingredientes() == receta.ingredientes() ||
			(comida.nivelDeDificultad() - receta.nivelDeDificultad()).abs() <= 1 })
		
	method superaNivelDeAprendizaje() =
		preparaciones.count({comida => comida.esDificil()}) > 5
}

class Comida{
	const property receta
	
}