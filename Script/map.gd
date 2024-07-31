extends Node

# Tempo total em segundos (30 minutos)
var total_time : int = 30 * 60
var remaining_time : int = total_time

# Referência ao Timer
@onready var timer : Timer = $Timer

func _ready():
	# Conectar o sinal timeout do Timer à função
	timer.connect("timeout", self, "_on_Timer_timeout")
	# Iniciar o Timer
	timer.start()

func _on_Timer_timeout():
	# Decrementar o tempo restante
	remaining_time -= 1
	
	# Atualizar o Timer
	if remaining_time <= 0:
		# Tempo acabou
		remaining_time = 0
		_on_timer_end()
	else:
		# Atualizar a UI com o tempo restante (se necessário)
		update_ui()

func update_ui():
	# Atualizar sua interface com o tempo restante
	var minutes : int = int(remaining_time / 60)
	var seconds : int = remaining_time % 60
	print("%02d:%02d" % [minutes, seconds]) # Exemplo de como imprimir o tempo restante

func _on_timer_end():
	# O que acontece quando o tempo acaba
	print("Tempo acabou!")


func _on_timer_timeout():
	pass # Replace with function body.
