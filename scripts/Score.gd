extends Label

signal SCORE_FOR_PLAYER()

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func check_winner():
	if(Global.player_choice == Global.enemy_choice):
		print("Empate")
		emit_signal("SCORE_FOR_PLAYER")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_Player_Score_SCORE_FOR_PLAYER():
	Global.score_player += 1
	self.text = str("Score: ", Global.score_player)
	pass # Replace with function body.
