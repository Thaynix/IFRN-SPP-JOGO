extends CharacterBody2D

@onready var animation: AnimatedSprite2D = get_node("animate")

@export var speed: float = 256.0

func _physics_process(_delta: float) -> void:
	move()
	animate()
	
func move() -> void:
	var direction: Vector2 = Vector2 (
		Input.get_axis("ui_left", "ui_right"),
		Input.get_axis("ui_up", "ui_down"),
	).normalized()

	velocity = direction * speed
	move_and_slide()

func animate() -> void:
	if velocity != Vector2.ZERO:
		if velocity.y > 0:
			animation.play("walk-left-if")
		elif velocity.y < 0:
			animation.play("walk-left-if")
		elif velocity.x > 0:
			animation.play("walk-right-if")
		elif velocity.x < 0:
			animation.play("walk-left-if")
		return
	animation.play("idle-if")
 
