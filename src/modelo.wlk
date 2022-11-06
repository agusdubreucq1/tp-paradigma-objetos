
class Receta{
	const property ingredientes = []
	const property nivelDeDificultad
	
	method esDificil() = nivelDeDificultad > 5 ||
		self.cantIngredientes() > 10
	
	method cantIngredientes() = ingredientes.size() 
	
	method experienciaAportada() = 
		nivelDeDificultad * self.cantIngredientes()
}


class Cocinero{
	
	var property preparaciones = []   /* lista de comidas */
	
	var property nivelDeAprendizaje  /*principiante | experto | chef */
	
	
	/// MÉTODOS PARA TESTS ///
	
	method preparoReceta(receta) = preparaciones.any({comida=>comida.receta()==receta})  
	method experienciaQueLeAporto(receta){
		
		if(self.preparoReceta(receta)){
			
			return preparaciones.find({comida=>comida.receta() == receta}).experienciaQueAporta()
		}else{
			throw new PreparacionFallida(message="no preparó esa receta")
		}	
	}
	
	//////////////////////////
	
	
	method nivelDeExperiencia() =
		preparaciones.sum({comida => comida.experienciaQueAporta()})
		
	
	method preparar(receta){
		
		const calidad = nivelDeAprendizaje.calidadComida(receta,self)
		    			
   		preparaciones.add(new Comida(receta = receta, calidadComida = calidad, experienciaQueAporta = calidad.calculoExperienciaComida(receta)))
   		 
   		 /* manejar error en caso de que no se pueda preparar la receta/ el error lo tira el metodo realizarPreparacion(recta) de nivelDeAprendizaje */
			
			if(nivelDeAprendizaje.superaNivelDeAprendizaje(self)){
			self.pasarAlSiguienteNivel() /* implementar */
			}
			
		}
		
	
	
	method pasarAlSiguienteNivel()
	{
	nivelDeAprendizaje = nivelDeAprendizaje.siguienteNivel()}
	
	
	
	method laComidaQueMasExperienciaLeAporta(recetario)=recetario.filter({receta=>nivelDeAprendizaje.puedePreparar(receta)}).max({receta=>receta.experienciaAportada()})
	//se podria romper con un recetario vacio, pero nose si hay q manejar ese error //sí 
	
	method realizoPreparacionSimilar(receta) =
		preparaciones.any({comida => comida.receta().ingredientes() == receta.ingredientes() ||
			(comida.receta().nivelDeDificultad() - receta.nivelDeDificultad()).abs() <= 1 })
	
	
	method cantPreparacionesSimilares(receta) =
		preparaciones.count({comida => comida.receta().ingredientes() == receta.ingredientes() ||
			(comida.receta().nivelDeDificultad() - receta.nivelDeDificultad()).abs() <= 1 })
		
	
	method perfeccionar(receta)= self.nivelDeExperiencia() == 3*receta.experienciaAportada()
		
	
}

object principiante{
	
	///MANEJO DE NIVEL
	const property siguienteNivel = experimentado
	
	method superaNivelDeAprendizaje(cocinero) = cocinero.nivelDeExperiencia() > 100
		
	//MANEJO DE COMIDAS
	method puedePreparar(receta) = not receta.esDificil()	
	
	method calidadPreparacion(receta,cocinero){ 
		
		if(self.puedePreparar(receta)){
			
			
			if(receta.cantIngredientes()<4){
				
				return normal
				
			}else{
				
				return pobre
			}
			
			}else{
				
				throw new PreparacionFallida(message="el cocinero no puede preparar esa receta")
				
			}
		
		
		}
	
}

object experimentado{
	
	//MANEJO DE NIVEL 
	var property siguienteNivel = chef
		
	method superaNivelDeAprendizaje(cocinero) =
		cocinero.preparaciones().count({comida => comida.receta().esDificil()}) > 5
		
	//MANEJO DE COMIDA
	method puedePreparar(receta) = not receta.esDificil()

	method calidadComida(receta,cocinero){
		
		if(self.puedePreparar(receta) && cocinero.perfeccionar(receta)){
			
			superior.plus(superior.calculoPlus(cocinero,receta)) //siempre que se calcule la calidad superior, se actualiza el plus y luego el calculo queda guardado en la clase comida /*ver cocinero.preparar(receta)*/
			
			return superior
			
		}else if (self.puedePreparar(receta)){
			
			return normal
			
		}else{
			
			throw new PreparacionFallida(message="preparacion fallida")
			
		}
	}

}

object chef{
	
	//MANEJO DE NIVEL
	var property siguienteNivel = self
	
	method superaNivelDeAprendizaje(cocinero) = false
	
	
	//MANEJO COMIDA
	method puedePreparar(receta) = true 
	
	method calidadComida(receta,cocinero){
		
		if(self.puedePreparar(receta) && cocinero.perfeccionar(receta)){
			
			///antes de mandarle la calidad le modifico el plus
			
			superior.plus(superior.calculoPlus(cocinero,receta)) //siempre que se calcule la calidad superior, se actualiza el plus y luego el calculo queda guardado en la clase comida /*ver cocinero.preparar(receta)*/
			
			return superior
			
		}else if(self.puedePreparar(receta)){
			
			return normal
		}else{
			
			throw new PreparacionFallida(message="preparacion fallida")
		}
	}
	

	
	
}	



class Comida{
	
	const property receta 
	
	const property calidadComida   /* pobre | normal | superior */
	
	const property experienciaQueAporta  

	/* USO:  al instanciar una comida, le asignamos una receta y una calidad. A su vez, se le asigna la experiencia que aporta la comida mediante calidadComida.calculoExperienciaComida(receta)
	 * 		 ese metodo se encarga de interactuar con la calidadComida, quien hace el calculo de la experiencia interactuando con la receta de la comida y parametros extras
	  * 
	  * NOTA: si la comida es superior, la lógica del objeto "experimentado" o "chef" se encarga de asignarle el plus correspondiente al objeto "superior" previo la instanciacion de una comida, 
	  * asi que todo funciona bien 
	  * 
	  * Luego, para consultar la experiencia que aporta una comida hacemos comida.experienciaQueAporta() lo que retorna el valor constante que se calculó en la instanciacion de la comida.
	  */
}

object pobre{
	
	var property experienciaMax = configurarComidaPobre.experienciaMax()
	
	method calculoExperienciaComida(receta) = receta.experienciaAportada().min(experienciaMax)
	
}

object configurarComidaPobre{
	
	var property experienciaMax = 0
	
}


object superior{ // está bien que sea un object, porque no lo vamos a usar para que recuerde nada, solo queremos que haga el calculo 

	var property plus = 0 // el cocinero experimentado/chef se encargan de asignar el plus apropiado 

	method calculoPlus(cocinero,receta)=cocinero.cantPreparacionesSimilares(receta)/10
	
	method  calculoExperienciaComida(receta) = receta.experienciaAportada() + plus
}


object normal{
	
	method calculoExperienciaComida(receta) = receta.experienciaAportada()
}




class RecetaGourmet inherits Receta{
	
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
		
		estudiantes.forEach({estudiante => estudiante.preparar(estudiante.laComidaQueMasExperienciaLeAporta(recetario))})
	}
	
}

////////////////////////////////ERRORES////////////

class PreparacionFallida inherits DomainException{}


