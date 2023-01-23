extends Sprite

signal CARD_SELECTED()

var card_type = Global.SCISSORS
var node = self
var mouse_over_scissors = false
# Called when the node enters the scene tree for the first time.
func _ready():
	var parent = get_parent()
	parent.connect("MULLIGAN_DELETE_CARD", self, "delete")
	pass # Replace with function body.

func delete():
	node.queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_action_just_pressed("left_click") && mouse_over_scissors == true && Global.state == Global.PLAYER_TURN):
		emit_signal("CARD_SELECTED", card_type, node)
	pass


func _on_Area2D_mouse_entered():
	mouse_over_scissors = true
	pass # Replace with function body.


func _on_Area2D_mouse_exited():
	mouse_over_scissors = false
	pass # Replace with function body.
