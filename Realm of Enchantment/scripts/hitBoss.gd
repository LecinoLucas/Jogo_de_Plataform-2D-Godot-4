extends Area2D

@onready var audio_stream_player = $"../AudioStreamPlayer" as AudioStreamPlayer

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		audio_stream_player.play()
		body.velocity.y = body.JUMP_VELOCITY
		owner.anim.play("hurt")
