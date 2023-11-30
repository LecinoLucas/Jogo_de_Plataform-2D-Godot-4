extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_btnfacil_pressed():
		Globals.nivel = 2
		get_tree().change_scene_to_file("res://levels/mundo_01.tscn" )


func _on_btndificil_pressed():
	Globals.nivel = 3
	get_tree().change_scene_to_file("res://levels/mundo_01.tscn" )
	
func _on_btnhard_pressed():
	Globals.nivel = 4
	get_tree().change_scene_to_file("res://levels/mundo_01.tscn" )


func _on_btn_demo_pressed():
	pass # Replace with function body.


func _on_voltar_btn_pressed():
	get_tree().change_scene_to_file("res://Nova pasta/title_screen.tscn")


