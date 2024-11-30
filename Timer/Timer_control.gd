extends Control

# Aqui estão sendo definidas as variáveis de tempo
var segundos = 0
var minutos = 0
var Dsegundos = 0
var Dminutos = 1


func _ready():
	Resetar_timer()
	pass

# Função ligada ao timeout do timer
func _on_timer_timeout():
	if segundos == 0:
		if minutos > 0:
			minutos -= 1
			segundos = 60
	segundos -= 1
	
	$Label.text = str(minutos) + ":" + str(segundos)
	pass
	
# Resentando o temporizador
func Resetar_timer():
	segundos = Dsegundos
	minutos = Dminutos
