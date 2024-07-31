extends CharacterBody2D

# Definindo variaveis para velociade, movimentação e se ta conversando ou nao 
const speed = 30

var dir = Vector2.RIGHT
var start_pos 
var current_state = IDLE
var is_roaming = true 
var is_chatting = false 
var player
var player_in_chat_zone = false

enum {
	IDLE,
	NEW_DIR,
	MOVE
}

func _ready():
	randomize()
	start_pos = position
	
func _process(delta):
		if current_state == 0 or current_state == 1:
			$animation.play("idle")
		elif current_state == 2 and !is_chatting:
			if dir.x == -1:
				$animation.play("walk_left") 
			if dir.x == 1:
				$animation.play("walk_right")
			if dir.y == 1:
				$animation.play("walk_right")
			if dir.y == -1:
				$animation.play("walk_left") 	
		if is_roaming:
			match current_state:
				IDLE:
					pass
			#vai escolher uma direção aleatoria
				NEW_DIR:
					dir = choose([Vector2.RIGHT, Vector2.UP, Vector2.LEFT, Vector2.DOWN])
				MOVE:
					move(delta)
		if Input.is_action_just_pressed("chat"):
			print("huuuum npczinho")
			$Dialogue.start()
			is_roaming = false
			is_chatting = true
			$animation.play("idle") 
	
func choose(array):
	array.shuffle()
	return array.front()

func move(delta):
	if !is_chatting:
		position += dir * speed * delta 


func _on_chat_detection_area_body_entered(body):
	if body.has_method("player"):
		player = body
		player_in_chat_zone = true


func _on_chat_detection_area_body_exited(body):
	if body.has_method("player"):
		player_in_chat_zone = false


func _on_timer_timeout():
	$Timer.wait_time = choose([0.5, 1, 1.5])
	current_state = choose([IDLE, NEW_DIR, MOVE])


func _on_dialogue_dialogue_finished():
	is_chatting = false
	is_roaming = true
