extends Node2D

signal SHUFFLE()
signal DRAW_CARD()
signal MULLIGAN_DELETE_CARD()
signal PLAYED_CARD()
signal DECK_SIZE()
signal UPDATE_SCORE()
signal EMPTY_DECK()
var scene_paper = preload("res://scenes/Paper_Card.tscn")
var scene_rock = preload("res://scenes/Rock_Card.tscn")
var scene_scissors = preload("res://scenes/Scissors_Card.tscn")
var scene_joker = preload("res://scenes/Joker_Card.tscn")

var texture_paper = preload("res://sprites/Paper.png")
var texture_rock = preload("res://sprites/Rock.png")
var texture_scissors = preload("res://sprites/Scissors.png")
var texture_joker = preload("res://sprites/Joker.png")

var card

var player_deck = [0,0,0,0,1,1,1,1,2,2,2,2,3,3,3] #Esquerda é o topo do deck
var player_hand = [7,7,7]

var player_deck_size = 15

var xAxys = 250
var drawed_3 = 0
var actual_hand = 0

var first_mulligan = false
var drawed_all_cards = false
var mouse_over_deck = false

func create_player_hand(): #COLOCA A CARTA NA MÃO DO JOGADOR, FAZ UM POP DO DECK, E INSTANCEIA A CARTA DA MÃO DO JOGADOR NA ORDEM 1,2,3 
	for n in range(3):
		Global.player_actual_hand += 1
		player_hand[n] = player_deck[0]
		player_deck.pop_front()
		if(player_hand[n] == Global.PAPER):
			create_card(scene_paper)
		elif(player_hand[n] == Global.ROCK):
			create_card(scene_rock)
		elif(player_hand[n] == Global.SCISSORS):
			create_card(scene_scissors)
		elif(player_hand[n] == Global.JOKER):
			create_card(scene_joker)
	if(drawed_3 == 3):#CORRIGE O POSICIONAMENTO E HABILITA O MULLIGAN UMA UNICA VEZ
		xAxys = 250
		drawed_all_cards = true
		drawed_3 = 0
	print("PLAYER:",player_hand)

func create_card(scene):#INSTANCEIA A CENA, ADICIONA COMO FILHO, CONECTA A CARTA, POSICIONA A CENA
	card = scene.instance()
	add_child(card)
	card.connect("CARD_SELECTED", $"/root/Table", "delete")
	card.set_position(Vector2(xAxys,0))
	xAxys += 194
	drawed_3 += 1
	player_deck_size -= 1

func mulligan():#CORRIGE POSIÇÃO, EMITE SINAL DELETAR A MÃO ATUAL, MÂO PRO DECK, POP DA MÂO, SHUFFLE DECK, DECK PRA MÃO, POP DECK, INSTANCEIA
	emit_signal("MULLIGAN_DELETE_CARD")
	for n in range(3):
		player_deck.push_back(player_hand[0])
		player_hand.pop_front()
		emit_signal("SHUFFLE", player_deck)
		player_hand.push_back(player_deck[0])
		player_deck.pop_front()
		if(player_hand[n] == Global.PAPER):
			create_card(scene_paper)
		elif(player_hand[n] == Global.ROCK):
			create_card(scene_rock)
		elif(player_hand[n] == Global.SCISSORS):
			create_card(scene_scissors)
		elif(player_hand[n] == Global.JOKER):
			create_card(scene_joker)
	if(drawed_3 == 3):#CORRIGE O POSICIONAMENTO E HABILITA O MULLIGAN UMA UNICA VEZ
		xAxys = 250
		drawed_all_cards = true
		drawed_3 = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	emit_signal("SHUFFLE", player_deck)
	$"/root/Table".connect("PLAYED_CARD", self,"_on_Player_Deck_PLAYED_CARD")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_action_just_pressed("left_click") && mouse_over_deck == true && player_deck_size > 0 && Global.state == Global.PLAYER_TURN && Global.player_actual_hand == 0):
		emit_signal("DRAW_CARD")#CONECTADO A SI MESMO
		emit_signal("DECK_SIZE", player_deck_size)
	if(player_deck_size == 0 && Global.player_actual_hand == 0):
		emit_signal("EMPTY_DECK")
	pass

func played_card(texture):
	var sprite = Sprite.new()
	sprite.texture = texture
	sprite.scale = Vector2(0.7, 0.7)
	sprite.set_position(Vector2(638,-200))
	add_child(sprite)

func _on_Area2D_mouse_entered():
	mouse_over_deck = true
	pass # Replace with function body.


func _on_Area2D_mouse_exited():
	mouse_over_deck = false
	pass # Replace with function body.


func _on_Player_Deck_DRAW_CARD():
	create_player_hand()
	pass # Replace with function body.


func _on_Mulligan_pressed():
	if(first_mulligan == false && drawed_all_cards == true):
		mulligan()
		Global.score_enemy += 1
		emit_signal("UPDATE_SCORE")
		first_mulligan = true
	pass # Replace with function body.


func _on_Player_Deck_PLAYED_CARD():
	if(Global.player_choice == Global.PAPER):
		played_card(texture_paper)
	elif(Global.player_choice == Global.ROCK):
		played_card(texture_rock)
	elif(Global.player_choice == Global.SCISSORS):
		played_card(texture_scissors)
	elif(Global.player_choice == Global.JOKER):
		played_card(texture_joker)
	pass # Replace with function body.
