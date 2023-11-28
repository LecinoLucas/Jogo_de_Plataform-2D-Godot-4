extends Node2D

@onready var player:= $Player as CharacterBody2D
@onready var camera := $Camera2D as Camera2D
@onready var control = $HUD/control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	player.follow_camera(camera)
	player.player_has_died.connect(game_over)
	control.time_is_up.connect(game_over)
	
	Globals.coins = 0
	Globals.score = 0
	if Globals.btnfacil == 2:
		Globals.life = 4
	elif Globals.btndificil == 3:
		Globals.life = 3
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Globals.btnfacil == 2:
		#Globals.life = 5
		# Verificar se todas as moedas foram coletadas e a pontuação é pelo menos 2400
		if Globals.coins >= 15 and Globals.score >= 600:
			show_parabens_screen()
			
	elif Globals.btndificil == 3:
		#Globals.life = 3
			# Verificar se todas as moedas foram coletadas e a pontuação é pelo menos 200
		if Globals.coins >= 34 and Globals.score >= 2800:
			show_parabens_screen()
			
			
# Adicione uma nova função para exibir a mensagem de parabéns
func show_congratulations_message():
	var congratulations_label = Label.new()
	congratulations_label.text = "Parabéns! Você venceu o jogo!"
	congratulations_label.rect_min_size = Vector2(300, 100)
	congratulations_label.rect_position = Vector2(100, 100)
	
	# Adicione a etiqueta à cena ou à interface do usuário
	add_child(congratulations_label)
	
func reload_game():
	await get_tree().create_timer(1.5).timeout
	get_tree().reload_current_scene()
	start_game()
	
func game_over():
	get_tree().change_scene_to_file("res://Nova pasta/game_over.tscn")
	
func start_game():
	get_tree().change_scene("res://Nova pasta/title_screen.tscn")

func show_parabens_screen():
	get_tree().change_scene_to_file("res://Nova pasta/parabens.tscn")

