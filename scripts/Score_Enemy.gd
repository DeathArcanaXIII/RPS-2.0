extends Label


func score_enemy():
	self.text = str("Score: ", Global.score_enemy)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Check_Winner_SCORE():
	score_enemy()
	pass # Replace with function body.
