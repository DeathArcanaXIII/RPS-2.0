extends Label

signal SCORE()

func check_winner():
	if(Global.player_choice == Global.enemy_choice):
		print("Empate")
		self.text = str("Empate")
		Global.state = Global.PLAYER_TURN
	elif(Global.player_choice == Global.JOKER):
		print("Você Ganhou")
		self.text = str("Você Ganhou")
		Global.state = Global.PLAYER_TURN
		Global.score_player += 1
	elif(Global.enemy_choice == Global.JOKER):
		print("Você Perdeu")
		self.text = str("Você Perdeu")
		Global.state = Global.PLAYER_TURN
		Global.score_enemy += 1
	elif(Global.player_choice == Global.PAPER && Global.enemy_choice == Global.SCISSORS):
		print("Você Perdeu")
		self.text = str("Você Perdeu")
		Global.state = Global.PLAYER_TURN
		Global.score_enemy += 1
	elif(Global.player_choice == Global.PAPER && Global.enemy_choice == Global.ROCK):
		print("Você Ganhou")
		self.text = str("Você Ganhou")
		Global.state = Global.PLAYER_TURN
		Global.score_player += 1
	elif(Global.player_choice == Global.ROCK && Global.enemy_choice == Global.PAPER):
		print("Você Perdeu")
		self.text = str("Você Perdeu")
		Global.state = Global.PLAYER_TURN
		Global.score_enemy += 1
	elif(Global.player_choice == Global.ROCK && Global.enemy_choice == Global.SCISSORS):
		print("Você Ganhou")
		self.text = str("Você Ganhou")
		Global.state = Global.PLAYER_TURN
		Global.score_player += 1
	elif(Global.player_choice == Global.SCISSORS && Global.enemy_choice == Global.PAPER):
		print("Você Ganhou")
		self.text = str("Você Ganhou")
		Global.state = Global.PLAYER_TURN
		Global.score_player += 1
	elif(Global.player_choice == Global.SCISSORS && Global.enemy_choice == Global.ROCK):
		print("Você Perdeu")
		self.text = str("Você Perdeu")
		Global.state = Global.PLAYER_TURN
		Global.score_enemy += 1
	emit_signal("SCORE")


func _emit_score():
	emit_signal("SCORE")
# Called when the node enters the scene tree for the first time.
func _ready():
	emit_signal("SCORE")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
