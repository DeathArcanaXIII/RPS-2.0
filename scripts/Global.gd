extends Node

enum {PAPER = 0, ROCK = 1, SCISSORS = 2, JOKER = 3, PLAYER_TURN, ENEMY_TURN}

var state = PLAYER_TURN

var player_choice 
var enemy_choice

var score_player = 0
var score_enemy = 0

var player_actual_hand = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
