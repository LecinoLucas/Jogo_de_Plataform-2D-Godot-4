extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body: Node2D) -> void:
	$AnimatedSprite2D.play("colect")
	
	


func _on_animated_sprite_2d_animation_finished() -> void:
	queue_free()
