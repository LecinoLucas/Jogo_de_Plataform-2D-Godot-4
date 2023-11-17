extends CharacterBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -400.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_jumping := false
var knockback_vector := Vector2.ZERO
var direction

@onready var animation := $Anim as AnimatedSprite2D
@onready var remote := $Remote as RemoteTransform2D

signal player_has_died()

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		is_jumping = true
	elif is_on_floor():
		is_jumping = false

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_axis("ui_left", "ui_right")
	
	if direction != 0:
		velocity.x = direction * SPEED
		animation.scale.x = direction
		if not is_jumping:
			animation.play("run")
	elif is_jumping:
		animation.play("jump")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animation.play("idle")
		
		if knockback_vector != Vector2.ZERO:
			velocity = knockback_vector
			
	move_and_slide()

func _on_hurtbox_body_entered(body: Node2D) -> void:
	# Check if the body is in the "inimigos" or "boss" group
	# and perform appropriate actions
	if body.is_in_group("inimigos") or body.is_in_group("boss"):
		take_damage(Vector2(200, -200))

func follow_camera(camera):
	var camera_path = camera.get_path()
	remote.remote_path = camera_path

func take_damage(knockback_force := Vector2.ZERO, duration := 0.25):
	Globals.life -= 1

	if Globals.life <= 0:
		# Se não há vidas restantes, recarrega a cena
		queue_free()
		emit_signal("player_has_died")
	else:
		# Ainda há vidas restantes, aplicar lógica de dano
		if knockback_force != Vector2.ZERO:
			knockback_vector = knockback_force

			var knockback_tween := get_tree().create_tween()
			knockback_tween.parallel().tween_property(self, "knockback_vector", Vector2.ZERO, duration)    
			animation.modulate = Color(1, 0, 0, 1)
			knockback_tween.parallel().tween_property(animation, "modulate", Color(1, 1, 1, 1), duration)

func _input(event):
	if event is InputEventScreenTouch:
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y = JUMP_VELOCITY
			is_jumping = true
		elif is_on_floor():
			is_jumping = false
