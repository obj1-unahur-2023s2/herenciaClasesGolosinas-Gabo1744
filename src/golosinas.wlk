/*
 * Los sabores
 */
object frutilla { }
object chocolate { }
object vainilla { }
object naranja { }
object limon { }


/*
 * Golosinas
 */

class Golosinas{
	
	method estaBaniada()= false
}

class Bombon inherits Golosinas{
	var peso = 15
	
	method precio() { return 5 }
	method peso() { return peso }
	method mordisco() { peso = peso * 0.8 - 1 }
	method sabor() { return frutilla }
	method libreGluten() { return true }
}


class Alfajor inherits Golosinas {
	var peso = 15
	
	method precio() { return 12 }
	method peso() { return peso }
	method mordisco() { peso = peso * 0.8 }
	method sabor() { return chocolate }
	method libreGluten() { return false }
}

class Caramelo inherits Golosinas {
	var peso = 5
	var sabor

	method precio() { return 12 }
	method peso() { return peso }
	method mordisco() { peso = peso - 1 }
	method sabor() { return sabor }
	method libreGluten() { return true }
}


class Chupetin inherits Golosinas {
	var peso = 7
	
	method precio() { return 2 }
	method peso() { return peso }
	method mordisco() { 
		if (peso >= 2) {
			peso = peso * 0.9
		}
	}
	method sabor() { return naranja }
	method libreGluten() { return true }
}

class Oblea inherits Golosinas {
	var peso = 250
	
	method precio() { return 5 }
	method peso() { return peso }
	method mordisco() {
		if (peso >= 70) {
			// el peso pasa a ser la mitad
			peso = peso * 0.5
		} else { 
			// pierde el 25% del peso
			peso = peso - (peso * 0.25)
		}
	}	
	method sabor() { return vainilla }
	method libreGluten() { return false }
}

class Chocolatin inherits Golosinas {
	// hay que acordarse de *dos* cosas, el peso inicial y el peso actual
	// el precio se calcula a partir del precio inicial
	// el mordisco afecta al peso actual
	var pesoInicial
	var comido = 0
	
	method pesoInicial(unPeso) { pesoInicial = unPeso }
	method precio() { return pesoInicial * 0.50 }
	method peso() { return (pesoInicial - comido).max(0) }
	method mordisco() { comido = comido + 2 }
	method sabor() { return chocolate }
	method libreGluten() { return false }

}

class GolosinaBaniada inherits Golosinas {
	var golosinaInterior
	var pesoBanio = 4
	
	method golosinaInterior(unaGolosina) { golosinaInterior = unaGolosina }
	method precio() { return golosinaInterior.precio() + 2 }
	method peso() { return golosinaInterior.peso() + pesoBanio }
	method mordisco() {
		golosinaInterior.mordisco()
		pesoBanio = (pesoBanio - 2).max(0) 
	}	
	method sabor() { return golosinaInterior.sabor() }
	method libreGluten() { return golosinaInterior.libreGluten() }
	override method estaBaniada()= true	
}


class Tuttifrutti inherits Golosinas {
	var libreDeGluten
	const sabores = [frutilla, chocolate, naranja]
	var saborActual = 0
	
	method mordisco() { saborActual += 1 }	
	method sabor() { return sabores.get(saborActual % 3) }	

	method precio() { return (if(self.libreGluten()) 7 else 10) }
	method peso() { return 5 }
	method libreGluten() { return libreDeGluten }	
	method libreGluten(valor) { libreDeGluten = valor }
}

class BombonDuro inherits Bombon{
	
	override method mordisco(){
		peso = peso -1
	}
	
	method primergradoDureza(){
		return if(peso < 8){1}else{2}
	}
	
	method gradoDeDureza(){
		return if(peso > 12){3}else{self.primergradoDureza()}
	}
}

class CarameloRelleno inherits Caramelo{
	
	
	override method mordisco(){
		super()
		sabor = chocolate
	}
	override method precio() = 13
}

class ObleaCrujiente inherits Oblea{
	var cantidadMordida = 0
	
	method estaDebil() = cantidadMordida > 3
	
	override method mordisco(){
		super()
		if (not self.estaDebil()){
			peso = peso - 3
		}
		cantidadMordida ++
	}
}

class ChocolatinVip inherits Chocolatin{
	var property humedad = 0
	
	override method peso() = super() * 1 + humedad
}

class ChocolatinPremium inherits ChocolatinVip{
	
	override method peso() = (pesoInicial - comido).max(0) * (1 + (humedad /2))
	
}