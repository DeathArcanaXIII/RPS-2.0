extends Node2D

signal SHUFFLE()
signal DRAW_CARD()
signal MULLIGAN_DELETE_CARD()

var scene_paper = preload("res://scenes/Paper_Card.tscn")
var scene_rock = preload("res://scenes/Rock_Card.tscn")
var scene_scissors = preload("res://scenes/Scissors_Card.tscn")
var scene_joker = preload("res://scenes/Joker_Card.tscn")

var card

var player_deck = [0,0,0,0,1,1,1,1,2,2,2,2,3,3,3] #Esquerda é o topo do deck
var player_hand = [7,7,7]

var player_deck_size = 15

var xAxys = 250
var drawed_3 = 0

var first_mulligan = false
var drawed_all_cards = false
var mouse_over_deck = false


func create_player_hand(): #COLOCA A CARTA NA MÃO DO JOGADOR, FAZ UM POP DO DECK, E INSTANCEIA A CARTA DA MÃO DO JOGADOR NA ORDEM 1,2,3 
	for n in range(3):
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
	xAxys = 250
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
	xAxys = 250

# Called when the node enters the scene tree for the first time.
func _ready():
	emit_signal("SHUFFLE", player_deck)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_action_just_pressed("left_click") && mouse_over_deck == true && player_deck_size > 0 && Global.state == Global.PLAYER_TURN):
		emit_signal("DRAW_CARD")#CONECTADO A SI MESMO
	pass


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
		first_mulligan = true
	pass # Replace with function body.
