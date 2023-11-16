extends Area2D

var coins := 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body: Node2D) -> void:
	$AnimatedSprite2D.play("colect")
	#Evita a colisao de moedas 
	await $CollisionShape2D.call_deferred("queue_free")
	Globals.coins += coins
	print(Globals.coins)
	


func _on_animated_sprite_2d_animation_finished() -> void:
	queue_free()
