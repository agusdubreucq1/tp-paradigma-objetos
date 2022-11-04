class Receta{
	const property ingredientes = []
	const property nivelDeDificultad
	
	method esDificil() = nivelDeDificultad > 5 ||
		self.cantIngredientes() > 10
	
	method cantIngredientes() = ingredientes.size() 
	
	method experienciaAportada() = 
		nivelDeDificultad * self.cantIngredientes()
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// OPCION CON NIVELES DE APRENDIZAJE COMO OBJETOS

class Cocinero{
	var property preparaciones = []
	
	var property nivelDeAprendizaje  /*principiante | experto | chef */
	
	method nivelDeExperiencia() =
		preparaciones.sum({comida => comida.calculoExperiencia()})
		
	
	method preparar(receta){
   			
   		 preparaciones.add(nivelDeAprendizaje.realizarPreparacion(receta,self))
   		 
   		 /* manejar error en caso de que no se pueda preparar la receta/ el error lo tira el metodo realizarPreparacion(recta) de nivelDeAprendizaje */
			
			if(nivelDeAprendizaje.superaNivelDeAprendizaje(self)){
				self.pasarAlSiguienteNivel() /* implementar */
			}
			
		}
		
	
	
	method pasarAlSiguienteNivel()
	{
	nivelDeAprendizaje = nivelDeAprendizaje.siguienteNivel()}
	
	
	
	method laComidaQueMasExperienciaLeAporta(recetario)=recetario.filter({receta=>nivelDeAprendizaje.puedePreparar(receta)}).max({receta=>receta.experienciaAportada()})
	//se podria romper con un recetario vacio, pero nose si hay q manejar ese error
	
	
	//implementar en concinero
	method realizoPreparacionSimilar(receta) =
		preparaciones.any({comida => comida.ingredientes() == receta.ingredientes() ||
			(comida.nivelDeDificultad() - receta.nivelDeDificultad()).abs() <= 1 })
	
	//implementar en concinero
	method cantPreparacionesSimilares(receta) =
		preparaciones.count({comida => comida.ingredientes() == receta.ingredientes() ||
			(comida.nivelDeDificultad() - receta.nivelDeDificultad()).abs() <= 1 })
		
	//implementar en cocinero	
	method perfeccionar(receta)= self.nivelDeExperiencia() == 3*receta.experienciaAportada()
		
	
}

object principiante{
	
	var property siguienteNivel = experimentado
	
	
	method realizarPreparacion(receta,cocinero){ 
		 //otra variante es que el objeto principiante tenga un metodo calidadPreparacion() y retorne el objeto normal/superior/pobre si estos se modelan así
		 //capaz es mejor intentar implementarlo así para que sea el cocinero quien se encargue de literalmente cocinar 
	
		if(self.puedePreparar(receta)){
			
			
			if(receta.cantIngredientes()<4){
				
				return new ComidaNormal(receta = receta)
				
			}else{
				
				return new ComidaNormal(receta = receta)
			}
			
		}else{
			throw new PreparacionFallida(message="preparacion fallida")
		}
		
		
		}
			
	
	
	
	///////////////////////////////
	method superaNivelDeAprendizaje(cocinero) = 
		cocinero.nivelDeExperiencia() > 100
		
	method puedePreparar(receta)=
		not receta.esDificil()
		
	/////////////////////////////
}

object experimentado{
	
	var property siguienteNivel = chef
	
	/* solcuciono mandandose a sí mismo en la clase cocinero */

	////////////////////////////////////	
	method superaNivelDeAprendizaje(cocinero) =
		cocinero.preparaciones().count({comida => comida.receta().esDificil()}) > 5
		
		
	method puedePreparar(receta)=
		not receta.esDificil()
	///////////////////////////////////
	
	
	/*soluciono pasandole el cocinero como self en cocinero  */
	method realizarPreparacion(receta,cocinero){
		
		if(cocinero.perfeccionar(receta)){
			
			return new ComidaSuperior(receta=receta, plus = self.calculoPlus(cocinero,receta))
			
		}else{
			
			return new ComidaNormal(receta=receta)
		}
	}
	
	method calculoPlus(cocinero,receta)=cocinero.cantPreparacionesSimilares(receta)/10
		

}

object chef{
	
	 method puedePreparar(receta) = true 
	
	 method superaNivelDeAprendizaje(cocinero) = false
	
	/*soluciono pasandole el cocinero como self en cocinero  */
	method realizarPreparacion(receta,cocinero){
		
		if(cocinero.perfeccionar(receta)){
			
			return new ComidaSuperior(receta=receta, plus = self.calculoPlus(cocinero,receta))
			
		}else{
			
			return new ComidaNormal(receta=receta)
		}
	}
	
	method calculoPlus(cocinero,receta)=cocinero.cantPreparacionesSimilares(receta)/10
	
	
	}	



////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

object configurarComidaPobre{
	
	var property experienciaMax = 0
	
}


///está bien que las comidas sean clases porque cada instancia de comida tiene una receta particular

class ComidaPobre{
	
	const property receta
	
	var property experienciaMax = configurarComidaPobre.experienciaMax()
	
	method calculoExperiencia() = receta.experienciaAportada().min(experienciaMax)
	
}


class ComidaSuperior{
	
	const property receta
	
	var property plus
	
	method  calculoExperiencia() = receta.experienciaAportada() + plus
	 
}


class ComidaNormal{
	
	const property receta
	
	method calculoExperiencia() = receta.experienciaAportada()
}




class RecetaGourmet inherits Receta{
	
	override method experienciaAportada() = super() * 3
	
	override method esDificil() = true 
	
	
}



object academia{
	
	
	const property estudiantes = []
	
	const property recetario = []
	
	method agregarEstudiante(estudiante){
		estudiantes.add(estudiante)
	}
	
	method entrenarEstudiantes(){
		
		estudiantes.forEach({estudiante => estudiante.preparar(estudiante.laComidaQueMasExperienciaLeAporta(recetario))})
	}
	
}

////////////////////////////////ERRORES////////////

class PreparacionFallida inherits DomainException{}


