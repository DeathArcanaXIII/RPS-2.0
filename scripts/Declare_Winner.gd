extends Label

func declare_winner():
	if(Global.score_enemy == Global.score_player):
		print("Empate")
		self.text = str("Empate")
	elif(Global.score_enemy > Global.score_player):
		print("Derrota")
		self.text = str("Derrota")
	else:
		print("Vitoria")
		self.text = str("Vitoria")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
