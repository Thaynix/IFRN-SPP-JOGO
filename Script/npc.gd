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
func _process(delta):
	if Input.is_action_just_pressed("chat"):
		print("huuuum npczinho")
		$Dialogue.start()
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
