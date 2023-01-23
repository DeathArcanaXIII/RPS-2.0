extends Label

func score_player():
	self.text = str("Score: ", Global.score_player)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Check_Winner_SCORE():
	score_player()
	pass # Replace with function body.
