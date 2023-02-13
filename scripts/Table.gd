extends Node

signal ENEMY_TURN()
signal PLAYED_CARD()
signal ENEMY_TURN_STRONGEST_PLAY()
signal ENEMY_TURN_PAPER_LOVER()
signal ENEMY_TURN_HOLD_JOKER()
signal ENEMY_TURN_ROCK_LOVER()
signal ENEMY_TURN_SCISSOR_LOVER()

var scene_player_deck = preload("res://scenes/Player_Deck.tscn")
var scene_enemy_deck = preload("res://scenes/Enemy_Deck.tscn")

var enemy_choice
var player_choice

var ai_chooser

func _ai_chooser():
	randomize()
	ai_chooser = randi() % Global.AI.size()
	
	if(ai_chooser == Global.AI.AGRESSIVE):
		print("Agressive")
	elif(ai_chooser == Global.AI.PASSIVE):
		print("Passive")
	elif(ai_chooser == Global.AI.HOLD_JOKER):
		print("Hold Joker")
	elif(ai_chooser == Global.AI.PAPER_LOVER):
		print("Paper Play")
	elif(ai_chooser == Global.AI.ROCK_LOVER):
		print("Rock Play")
	elif(ai_chooser == Global.AI.SCISSOR_LOVER):
		print("Scissors Play")

func delete(card_type,node):
	player_choice = card_type
	Global.player_choice = player_choice
	node.queue_free()
	Global.player_actual_hand -= 1
	emit_signal("PLAYED_CARD")
	
func shuffle_deck(deck): #EMBARALHA A ARRAY DO DECK
	randomize()
	deck.shuffle()

func create_player_deck():
	var player_deck = scene_player_deck.instance()
	player_deck.connect("SHUFFLE", self, "shuffle_deck")
	add_child(player_deck)
	player_deck.set_position(Vector2(200,500))
	
func create_enemy_deck():
	var enemy_deck = scene_enemy_deck.instance()
	enemy_deck.connect("SHUFFLE", self, "shuffle_deck")
	add_child(enemy_deck)
	enemy_deck.set_position(Vector2(200,100))

func check_winner():
	if(Global.player_choice == Global.enemy_choice):
		print("Empate")
		Global.state = Global.PLAYER_TURN
	elif(Global.player_choice == Global.JOKER):
		print("Você Ganhou")
		Global.state = Global.PLAYER_TURN
	elif(Global.enemy_choice == Global.JOKER):
		print("Você Perdeu")
		Global.state = Global.PLAYER_TURN
	elif(Global.player_choice == Global.PAPER && Global.enemy_choice == Global.SCISSORS):
		print("Você Perdeu")
		Global.state = Global.PLAYER_TURN
	elif(Global.player_choice == Global.PAPER && Global.enemy_choice == Global.ROCK):
		print("Você Ganhou")
		Global.state = Global.PLAYER_TURN
	elif(Global.player_choice == Global.ROCK && Global.enemy_choice == Global.PAPER):
		print("Você Perdeu")
		Global.state = Global.PLAYER_TURN
	elif(Global.player_choice == Global.ROCK && Global.enemy_choice == Global.SCISSORS):
		print("Você Ganhou")
		Global.state = Global.PLAYER_TURN
	elif(Global.player_choice == Global.SCISSORS && Global.enemy_choice == Global.PAPER):
		print("Você Ganhou")
		Global.state = Global.PLAYER_TURN
	elif(Global.player_choice == Global.SCISSORS && Global.enemy_choice == Global.ROCK):
		print("Você Perdeu")
		Global.state = Global.PLAYER_TURN
# Called when the node enters the scene tree for the first time.
func _ready():
	_ai_chooser()
	create_player_deck()
	create_enemy_deck()
	$Enemy_Deck.connect("CHECK_WINNER", $Check_Winner, "check_winner")
	$Player_Deck.connect("UPDATE_SCORE", $Check_Winner, "_emit_score")
	$Player_Deck.connect("EMPTY_DECK", $Declare_Winner, "declare_winner")
	pass # Replace with function body.


func _on_Table_PLAYED_CARD():
	if(ai_chooser == Global.AI.PASSIVE):
		emit_signal("ENEMY_TURN")
	elif(ai_chooser == Global.AI.AGRESSIVE):
		emit_signal("ENEMY_TURN_STRONGEST_PLAY")
	elif(ai_chooser == Global.AI.PAPER_LOVER):
		emit_signal("ENEMY_TURN_PAPER_LOVER")
	elif(ai_chooser == Global.AI.HOLD_JOKER):
		emit_signal("ENEMY_TURN_HOLD_JOKER")
	elif(ai_chooser == Global.AI.SCISSOR_LOVER):
		emit_signal("ENEMY_TURN_SCISSOR_LOVER")
	else:
		emit_signal("ENEMY_TURN_ROCK_LOVER")
	pass # Replace with function body.
