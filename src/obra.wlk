import obrero.*

class Obra {
	var property ladrillos = 0
	var property metrosDeCanio = 0
	var property metrosDeCable = 0
	var property cinta = 0
	var property fosforos = 0
	var property arandelas = 0
	var property efectivo = 0
	var property metrosCuadradosConstruidos = 0
	var property implementosDeAguaColocados = 0
	var property implementosDeGasColocados = 0
	var property cablesElectricosColocados = 0
	var property plantilla = []
	
	
	method habitaciones()	
	method pisos()
	method banios() 
	
	method sacarLadrillos(cant){
		ladrillos = 0.max(ladrillos-cant)
	}
	method sacarFosforos(cant){
		
	}
	
	method agregarAPlantilla(unObrero){
		plantilla.add(unObrero)
		unObrero.agregarObra(self)
	}
	method sacarDePlantilla(unObrero){
		if (unObrero.licencia()){
			self.error("Las leyes laborales están para respetarse - 
						licencia implica estabilidad laboral")
		}
		plantilla.remove(unObrero)
	}
	
	method licenciar(unObrero){
		unObrero.licencia(true)
	}
	method cantidadLicendiada(){
		return plantilla.count({ op => op.licencia() })
	}
	method obrerosDisponibles(){
		return plantilla.filter({ op => not op.licencia() })
	}
	
	method todosLicenciados(){
		return plantilla.all({obrero=>obrero.licencia()})
	}
	
	method registroDeMaterialesTrabajados(){
		if (plantilla==[] or self.todosLicenciados()){
			self.error("No hay obreros disponibles para trabajar")
		}
		plantilla.forEach({obrero=>obrero.jornadaLaboral(self)})
		
	}
	method recibirLadrillos(cant){ladrillos += cant	}
	method agregarMetrosDeCanio(cuantos){ metrosDeCanio += cuantos }
	method agregarMetrosDeCable(cuantos){metrosDeCable += cuantos}
	method agregarCinta(cuantos){cinta += cuantos}
	method agregarFosforos(cuantos){fosforos += cuantos}
	method agregarArandelas(cuantos){arandelas += cuantos}
	method estaElObrero(unObrero){return plantilla.contains(unObrero)}
	method obraFinalizada(){
		return self.paredesLevantadas()
			and self.caniosDeAguaColocados()
			and self.instalacionDeGas()
			and self.instalacionElectrica()
	}
				
	method instalacionElectrica() {
		 return cablesElectricosColocados > self.habitaciones() * 50
		 	and cablesElectricosColocados > self.pisos() * 100
	}
	method instalacionDeGas() {
		 return implementosDeGasColocados > self.banios() * 8
		 	and implementosDeGasColocados > self.habitaciones() * 3
	}
	method caniosDeAguaColocados() {
		 return implementosDeAguaColocados > self.banios() * 10
	}
	method paredesLevantadas() {
		 return metrosCuadradosConstruidos > self.habitaciones() * 50
	}
	
	method pagar(monto, unObrero){
		efectivo-=0.max(monto)
		unObrero.cobrar(unObrero.cobrar() + monto)
		
	}
	method importeTotalAdeudado(){
		return plantilla.sum({obrero=>obrero.jornalesACobrar()})
	}
	
	method pagarObreros(){
		plantilla.forEach({obrero=>self.pagar(obrero.jornalesACobrar(),obrero)})
		plantilla.forEach({obrero=>obrero.diasTrabajados(0)})
	}
	
}	

class Casa inherits Obra {
	var property habitaciones = 3
	var property banios = 1
	
	override method habitaciones() = habitaciones
	override method banios() = banios
	
	override method pisos() = 1
}

class Edificio inherits Obra {
	var property pisos = 4
	var property banios = 1
	var property cantidadDeDeptosPorPiso = 3
	var property cantidadAscensores = 0
	
	override method cablesElectricosColocados(){
		return cablesElectricosColocados + (300 * cantidadAscensores) 
	}
	override method pisos() = pisos
	override method banios() = banios
	override method habitaciones() = cantidadDeHabitacionesDeEdificio
	
	method agregarAscensores(cant){
		  cantidadAscensores+=cant

	}
}
object cantidadDeHabitacionesDeEdificio{
	var property habitaciones = 0
}


