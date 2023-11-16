extends CharacterBody2D


const SPEED = 700.0
const JUMP_VELOCITY = -400.0

@onready var wall_detection := $wall_detection as RayCast2D
@onready var texture := $textura as Sprite2D
@onready var anim := $AnimationPlayer as AnimationPlayer

var direction := -1

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
		
	if wall_detection.is_colliding():
		direction *= -1
	wall_detection.scale.x *= -1
		
		
	if direction == 1:
		texture.flip_h = false
	else:
		texture.flip_h = true	

	velocity.x = direction * SPEED * delta

	move_and_slide()


func _on_animation_player_animation_finished(anim_name: String) -> void:
	if anim_name == "hurt":
		Globals.score += 1000
		queue_free()
