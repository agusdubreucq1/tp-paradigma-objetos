
/*
 * Cocineros:
 * 				-preparan una receta --> (instancian una nueva comida) y la agregan a su lista de preparaciones
 * 				-pasan de nivel
 * 
 * Objetos que refieren al nivelDeAprendizaje (principiante - experimentado - chef):
 *
 * 				-determinan si el cocinero puede o no preparar una receta y con qué calidad
 * 					(*)si la calidad es superior tambien se encarga de configurar el plus correspondiente para asignarle a la comida
 * 				-determinan si el cocinero puede o no pasar de nivel y a cuál
 * 
 * Objetos que refieren a la calidadComida (pobre - normal -superior):
 * 
 * 				-se encargan de calcular la experiencia que le aporta al cocinero preparar una comida según: la experiecia que aporta la receta y el plus de la comida o la experiencia max de la calidad
 * 
 * 
 * Comidas: 
 * 
 * 				-sus instancias refieren a recetas preparadas por los cocineros 
 * 				-tienen una calidad, un plus y una receta
 * 				-aportan una experiencia que se obtiene mediante el cálculo que indique su calidad
 * 
 * Recetas:
 * 				-tienen una lista de ingredientes, un nivel de dificultad y un calculo para su experienciaAportada, entre otros métodos de consulta
 */


//CLASES-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

class Receta{
	
	//ATRIBUTOS 
	
	const property ingredientes = []
	const property nivelDeDificultad
	
	//MÉTODOS DE CONSULTA
	
	method esDificil() = nivelDeDificultad > 5 ||
		self.cantIngredientes() > 10
	
	method cantIngredientes() = ingredientes.size() 
	
	method experienciaAportada() = 
		nivelDeDificultad * self.cantIngredientes().roundUp()
		
	method esSimilarA(otraReceta) = 
		otraReceta.ingredientes() == self.ingredientes() ||
		(otraReceta.nivelDeDificultad() - self.nivelDeDificultad()).abs() <= 1 
}


class Cocinero{
	
	//ATRIBUTOS 
	
	var property preparaciones = []   /* lista de comidas */
	
	var property nivelDeAprendizaje  /*principiante | experto | chef */
	

	//MÉTODOS CON EFECTO 
		
	
	method preparar(receta){
		
		const calidad = nivelDeAprendizaje.calidadComida(receta,self)
		    			
   		preparaciones.add(new Comida(receta = receta, calidadComida = calidad/*, plus = calidad.configuracionPlus()) */ ))
   		 
   		 /* manejar error en caso de que no se pueda preparar la receta/ el error lo tira el metodo realizarPreparacion(recta) de nivelDeAprendizaje */
			
			if(self.puedePasarDeNivel()) {
			self.pasarAlSiguienteNivel() 
			}
			
	}
		
	
	
	method pasarAlSiguienteNivel()
	{
	nivelDeAprendizaje = nivelDeAprendizaje.siguienteNivel()}
	
	//MÉTODOS DE CONSULTA
	
	method nivelDeExperiencia() =
		preparaciones.sum({comida => comida.experienciaQueAporta()}).roundUp() 
	
	method laRecetaQueMasExperienciaLeAporta(recetario)=recetario.filter({receta=>nivelDeAprendizaje.puedePreparar(receta,self)}).max({receta=>receta.experienciaAportada()})
	
	method preparacionesSimilares(receta) = preparaciones.filter({comida => receta.esSimilarA(comida.receta())})
	
	method realizoPreparacionSimilar(receta) = self.preparacionesSimilares(receta).size() > 0
	
	method cantPreparacionesSimilares(receta) = self.preparacionesSimilares(receta).size()
		
	method experienciaAdquiridaPreparacionesSimilares(receta) = self.preparacionesSimilares(receta).sum({preparacionSimilar => preparacionSimilar.receta().experienciaAportada()}).roundUp()
	
	method puedePasarDeNivel() = nivelDeAprendizaje.superaNivelDeAprendizaje(self) //consulta para el cocinero pero en realidad la logica para pasar o no de nivel la maneja el nivelDeAprendizaje

	method perfeccionar(receta)= self.experienciaAdquiridaPreparacionesSimilares(receta) >= 3*receta.experienciaAportada().roundUp()
	
	method puedeRealizarlo(unaReceta) = nivelDeAprendizaje.puedePreparar(unaReceta, self)
	
}



class Comida{
	
	//ATRIBUTOS 
	
	const property receta 
	
	const property calidadComida   /* pobre | normal | superior */
	
	//var property plus = 0
	
	//MÉTODOS DE CONSULTA
	
	method experienciaQueAporta()  = calidadComida.calculoExperienciaComida(self)
	
	method ingredientes() = receta.ingredientes()
	
	method nivelDeDificultad() = receta.nivelDeDificultad()

	/* USO:
	 * 	La instanciacion de una comida implica asignarle una receta y una calidad.
	 */
}


// OBJETOS PARA NIVEL DE APRENDIZAJE---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

class NivelDeAprendizaje{
	

	method puedePreparar(receta, cocinero)= not receta.esDificil()	
	
	
	//MANEJO DE COMIDAS

	method calidadComida(receta,cocinero){ 
		
		if(self.puedePreparar(receta,cocinero)){
			
			return self.asignarCalidad(receta,cocinero)
			
		}else{
				
				throw new PreparacionFallida(message="el cocinero no puede preparar esa receta")
				
			}
			
	}
		
	method asignarCalidad(receta,cocinero)

}

object principiante inherits NivelDeAprendizaje{
	
	///MANEJO DE NIVEL
	const property siguienteNivel = experimentado
	
	method superaNivelDeAprendizaje(cocinero) = cocinero.nivelDeExperiencia() > 100
	
	override method asignarCalidad(receta,cocinero){
		
		
		if(receta.cantIngredientes()<4){
				
				return normal
				
			}else{
				
				return pobre
			}
			
			
	}
		
}

class NivelExperimentado inherits NivelDeAprendizaje{
	
	//MANEJO DE COMIDAS

	
	method calculoPlus(cocinero,receta) = cocinero.cantPreparacionesSimilares(receta)/10
	
	override method asignarCalidad(receta,cocinero){
		
		
		if(cocinero.perfeccionar(receta)){
				
				return new Superior(configuracionPlus= self.calculoPlus(cocinero,receta))
				
			}else{
				
				return normal
			}
			
			
	}
	
	
}


object experimentado inherits NivelExperimentado{
	

	//MANEJO DE NIVEL 
	const property siguienteNivel = chef
		
	method superaNivelDeAprendizaje(cocinero) =
		cocinero.preparaciones().count({comida => comida.receta().esDificil()}) > 5
		
	//MANEJO DE COMIDA
	override method puedePreparar(receta,cocinero) = cocinero.realizoPreparacionSimilar(receta) || super(receta,cocinero)

}

object chef inherits NivelExperimentado{
	

	//MANEJO DE NIVEL
	const property siguienteNivel = self
	
	method superaNivelDeAprendizaje(cocinero) = false
	
	//MANEJO COMIDA
	override method puedePreparar(receta,cocinero) = true 
}	


// OBJETOS PARA CALIDAD DE COMIDAS ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

class Calidad{
	
	method calculoExperienciaComida(comida) = comida.receta().experienciaAportada()
	
}

object pobre inherits Calidad{
	
	var property experienciaMax = 0 //default
	
	//MÉTODOS DE CONSULTA

	//siempre realiza el calculo teniendo en cuenta experienciaMax, el cual se puede configurar, EN EL MOMENTO DE CONSULTA DEL CALCULO
	override method calculoExperienciaComida(comida) = super(comida).min(self.experienciaMax())
	
}

class Superior inherits Calidad{ 

	// el cocinero experimentado/chef se encargan de asignar el plus apropiado al instanciar la calidad
	const property configuracionPlus  
	
	//MÉTODOS DE CONSULTA
	
	//siempre realiza el calculo con el atributo configuracionPlus instanciado
	override method  calculoExperienciaComida(comida) = super(comida) + configuracionPlus
}

const normal = new Calidad()

// EXTRAS --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


class RecetaGourmet inherits Receta{
	
	//MÉTODOS DE CONSULTA
	
	override method experienciaAportada() = super() * 3
	
	override method esDificil() = true 
	
	
}



object academia{
	
	var property estudiantes = []
	
	var property recetario = []
	
	method agregarEstudiante(estudiante){
		estudiantes.add(estudiante)
	}
	
	method entrenarEstudiantes(){
		if(not self.puedenPrepararSusRecetasSeleccionadas())
			self.error("el entrenamiento fallo")
		estudiantes.forEach({estudiante => estudiante.preparar(estudiante.laRecetaQueMasExperienciaLeAporta(recetario))})
	}
	
	method puedenPrepararSusRecetasSeleccionadas(){
		return estudiantes.all({estudiante => estudiante.puedeRealizarlo(estudiante.laRecetaQueMasExperienciaLeAporta(recetario))})
	}
}


//CLASES DE ERRORES ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

class PreparacionFallida inherits DomainException{}
