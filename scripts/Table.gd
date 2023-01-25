extends Node

signal ENEMY_TURN()
signal PLAYED_CARD()
signal ENEMY_TURN_STRONGEST_PLAY()
var scene_player_deck = preload("res://scenes/Player_Deck.tscn")
var scene_enemy_deck = preload("res://scenes/Enemy_Deck.tscn")

var enemy_choice
var player_choice

func delete(card_type,node):
	player_choice = card_type
	Global.player_choice = player_choice
	print(card_type)
	node.queue_free()
	Global.player_actual_hand -= 1
	if(Global.score_enemy >= Global.score_player):
		emit_signal("ENEMY_TURN")
	elif(Global.score_enemy < Global.score_player):
		emit_signal("ENEMY_TURN_STRONGEST_PLAY")
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
	create_player_deck()
	create_enemy_deck()
	$Enemy_Deck.connect("CHECK_WINNER", $Check_Winner, "check_winner")
	$Player_Deck.connect("UPDATE_SCORE", $Check_Winner, "_emit_score")
	$Player_Deck.connect("EMPTY_DECK", $Declare_Winner, "declare_winner")
	pass # Replace with function body.
