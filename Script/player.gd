extends CharacterBody2D

@onready var texture: Sprite2D = get_node("texture")
@onready var animation: AnimationPlayer = get_node("animation")

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
			animation.play("walk_down")
		elif velocity.y < 0:
			animation.play("walk_up")
		elif velocity.x > 0:
			texture.flip_h = false
			animation.play("walk")
		elif velocity.x < 0:
			texture.flip_h = true
			animation.play("walk")
		return
	animation.play("idle")
 
