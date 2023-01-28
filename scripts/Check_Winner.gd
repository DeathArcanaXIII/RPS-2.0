extends Label

signal SCORE()

func draw():
	print("Empate")
	self.text = str("Empate")
	Global.state = Global.PLAYER_TURN
	
func winner():
	print("Você Ganhou")
	self.text = str("Você Ganhou")
	Global.state = Global.PLAYER_TURN
	Global.score_player += 1

func loser():
	print("Você Perdeu")
	self.text = str("Você Perdeu")
	Global.state = Global.PLAYER_TURN
	Global.score_enemy += 1

func check_winner():
	if(Global.player_choice == Global.enemy_choice):
		draw()
	elif(Global.player_choice == Global.JOKER):
		winner()
	elif(Global.enemy_choice == Global.JOKER):
		loser()
	elif(Global.player_choice == Global.PAPER && Global.enemy_choice == Global.SCISSORS):
		loser()
	elif(Global.player_choice == Global.PAPER && Global.enemy_choice == Global.ROCK):
		winner()
	elif(Global.player_choice == Global.ROCK && Global.enemy_choice == Global.PAPER):
		loser()
	elif(Global.player_choice == Global.ROCK && Global.enemy_choice == Global.SCISSORS):
		winner()
	elif(Global.player_choice == Global.SCISSORS && Global.enemy_choice == Global.PAPER):
		winner()
	elif(Global.player_choice == Global.SCISSORS && Global.enemy_choice == Global.ROCK):
		loser()
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
