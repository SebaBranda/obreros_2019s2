import obra.*
import uocra.*

class Obrero {
	
	var property licencia = false
	var property obrasTrabajadas = #{}
	var property diasTrabajados = 0
	var property cobrar = 0
	
	method jornalesAdeudados(){
		return diasTrabajados
	}
	method jornalesACobrar()
	
	method jornadaLaboral(unaObra){
		diasTrabajados+=1
	}
	method agregarObra(unaObra){
		obrasTrabajadas.add(unaObra)
	}
	method pasoPor(unaObra){
		return obrasTrabajadas.contains(unaObra)
	}
}
class Albanil inherits Obrero{
	
	override method jornadaLaboral(unaObra){
		super(unaObra)
		unaObra.sacarLadrillos(100)
		unaObra.metrosCuadradosConstruidos(unaObra.metrosCuadradosConstruidos()+3)
	}
	override method jornalesACobrar(){
		return self.jornalesAdeudados() * uocra.jornalAlbanil()
	}
}
class Plomero inherits Obrero{
	override method jornadaLaboral(unaObra){
		super(unaObra)
		unaObra.metrosDeCanio(0.max(unaObra.metrosDeCanio()-10))
		unaObra.arandelas(0.max(unaObra.arandelas()-30))
		unaObra.implementosDeAguaColocados(unaObra.implementosDeAguaColocados()*0.5)
	}
	override method jornalesACobrar(){
		return self.jornalesAdeudados() * uocra.jornalEspecialistaBanioCocina()
	}
}
class Electricista inherits Obrero{
	
	override method jornadaLaboral(unaObra){
		super(unaObra)
		unaObra.metrosDeCable(0.max(unaObra.metrosDeCable()-4))
		unaObra.cinta(0.max(unaObra.cinta()-1))
		unaObra.cablesElectricosColocados(unaObra.cablesElectricosColocados()+4)
	}
	override method jornalesACobrar(){
		return self.jornalesAdeudados() * uocra.jornalElectricista()
	}
}
class Gasista inherits Obrero{
	
	override method jornadaLaboral(unaObra){
		super(unaObra)
		unaObra.metrosDeCanio(0.max(unaObra.metrosDeCanio()-3))  
		unaObra.fosforos(0.max(unaObra.fosforos()-20))
		unaObra.implementosDeGasColocados(unaObra.implementosDeGasColocados()+1)
	}
	override method jornalesACobrar(){
		return self.jornalesAdeudados() * uocra.jornalEspecialistaBanioCocina()
	}
}