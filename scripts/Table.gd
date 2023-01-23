extends Node

signal ENEMY_TURN()
signal PLAYED_CARD()

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
	emit_signal("ENEMY_TURN")
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
# Called when the node enters the scene tree for the first time.
func _ready():
	create_player_deck()
	create_enemy_deck()
	pass # Replace with function body.
