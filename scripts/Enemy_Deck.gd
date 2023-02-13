extends Node2D

signal SHUFFLE()
signal PLAYED_CARD()
signal DECK_SIZE()
signal CHECK_WINNER()
signal EMPTY_DECK()

var texture_paper = preload("res://sprites/Enemy_Paper.png")
var texture_rock = preload("res://sprites/Enemy_Rock.png")
var texture_scissors = preload("res://sprites/Enemy_Scissors.png")
var texture_joker = preload("res://sprites/Enemy_Joker.png")

var enemy_deck = [0,0,0,0,1,1,1,1,2,2,2,2,3,3,3]
var enemy_hand = [7,7,7]

var enemy_deck_size = 15
var cards_in_hand = 0

var drawed_3 = 0
var card

var drawed_all_cards = false
var mouse_over_deck = false

var xAxys = 250

# Called when the node enters the scene tree for the first time.
func _ready():
	emit_signal("SHUFFLE", enemy_deck)
	create_enemy_hand()
	$"/root/Table".connect("ENEMY_TURN", self, "play_random_card")
	$"/root/Table".connect("ENEMY_TURN_STRONGEST_PLAY", self, "_play_strongest_card")
	$"/root/Table".connect("ENEMY_TURN_PAPER_LOVER", self, "_play_paper")
	$"/root/Table".connect("ENEMY_TURN_HOLD_JOKER", self, "_hold_joker")
	$"/root/Table".connect("ENEMY_TURN_ROCK_LOVER", self, "_play_rock")
	$"/root/Table".connect("ENEMY_TURN_SCISSOR_LOVER", self, "_play_scissors")
	pass # Replace with function body.


func create_card(texture):#INSTANCEIA A CENA, ADICIONA COMO FILHO, CONECTA A CARTA, POSICIONA A CENA
	card = Sprite.new()
	card.texture = texture
	add_child(card)
	card.connect("CARD_SELECTED", $"/root/Table", "delete")
	card.set_position(Vector2(xAxys,0))
	xAxys += 194
	drawed_3 += 1
	cards_in_hand += 1
	enemy_deck_size -= 1

func create_enemy_hand(): #COLOCA A CARTA NA MÃO DO JOGADOR, FAZ UM POP DO DECK, E INSTANCEIA A CARTA DA MÃO DO JOGADOR NA ORDEM 1,2,3 
	for n in range(3):
		enemy_hand[n] = enemy_deck[0]
		enemy_deck.pop_front()
		if(enemy_hand[n] == Global.PAPER):
			create_card(texture_paper)
		elif(enemy_hand[n] == Global.ROCK):
			create_card(texture_rock)
		elif(enemy_hand[n] == Global.SCISSORS):
			create_card(texture_scissors)
		elif(enemy_hand[n] == Global.JOKER):
			create_card(texture_joker)
	if(drawed_3 == 3):#CORRIGE O POSICIONAMENTO AO COMPRAR 3 CARTAS
		xAxys = 250
		drawed_3 = 0
	print("ENEMY:", enemy_hand)

func _enemy_pick(card, texture):
	Global.enemy_choice = card
	Global.state = Global.CHECK_WINNER
	cards_in_hand -= 1
	enemy_hand.pop_at(enemy_hand.find(card))
	played_card(texture)
	if(cards_in_hand == 0 && enemy_deck_size > 0):
		enemy_hand = [7,7,7]
		create_enemy_hand()
	emit_signal("CHECK_WINNER")
	emit_signal("DECK_SIZE", enemy_deck_size)

func _play_scissors():
	if(Global.SCISSORS in enemy_hand):
		_enemy_pick(Global.SCISSORS, texture_scissors)
	else:
		play_random_card()

func _play_rock():
	if(Global.ROCK in enemy_hand):
		_enemy_pick(Global.ROCK, texture_rock)
	else:
		play_random_card()

func _hold_joker():
	if(Global.SCISSORS in enemy_hand):
		_enemy_pick(Global.SCISSORS, texture_scissors)
	elif(Global.PAPER in enemy_hand):
		_enemy_pick(Global.PAPER, texture_paper)
	elif(Global.ROCK in enemy_hand):
		_enemy_pick(Global.ROCK, texture_rock)
	else:
		_enemy_pick(Global.JOKER, texture_joker)

func _play_paper():
	if(Global.PAPER in enemy_hand):
		_enemy_pick(Global.PAPER, texture_paper)
	else:
		play_random_card()

func _play_strongest_card():
	if(Global.player_choice == Global.JOKER):
		play_random_card()

	elif(Global.player_choice == Global.PAPER):
		if(Global.SCISSORS in enemy_hand):
			_enemy_pick(Global.SCISSORS, texture_scissors)
		elif(Global.JOKER in enemy_hand):
			_enemy_pick(Global.JOKER, texture_joker)
		elif(Global.PAPER in enemy_hand):
			_enemy_pick(Global.PAPER, texture_paper)
		elif(Global.ROCK in enemy_hand):
			_enemy_pick(Global.ROCK, texture_rock)

	elif(Global.player_choice == Global.ROCK):
		if(Global.PAPER in enemy_hand):
			_enemy_pick(Global.PAPER, texture_paper)
		elif(Global.JOKER in enemy_hand):
			_enemy_pick(Global.JOKER, texture_joker)
		elif(Global.ROCK in enemy_hand):
			_enemy_pick(Global.ROCK, texture_rock)
		elif(Global.SCISSORS in enemy_hand):
			_enemy_pick(Global.SCISSORS, texture_scissors)

	elif(Global.player_choice == Global.SCISSORS):
		if(Global.ROCK in enemy_hand):
			_enemy_pick(Global.ROCK, texture_rock)
		elif(Global.JOKER in enemy_hand):
			_enemy_pick(Global.JOKER, texture_joker)
		elif(Global.SCISSORS in enemy_hand):
			_enemy_pick(Global.SCISSORS, texture_scissors)
		elif(Global.PAPER in enemy_hand):
			_enemy_pick(Global.PAPER, texture_paper)
			

func play_random_card():
	randomize()
	var temp = randi() % enemy_hand.size()
	var choosed_card = enemy_hand[temp]
	enemy_hand.pop_at(temp)
	Global.enemy_choice = choosed_card
	Global.state = Global.CHECK_WINNER
	cards_in_hand -= 1
	if(cards_in_hand == 0 && enemy_deck_size > 0):
		enemy_hand = [7,7,7]
		create_enemy_hand()
	emit_signal("PLAYED_CARD", choosed_card)
	emit_signal("DECK_SIZE", enemy_deck_size)
	emit_signal("CHECK_WINNER")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func played_card(texture):
	var sprite = Sprite.new()
	sprite.texture = texture
	sprite.scale = Vector2(0.7, 0.7)
	sprite.set_position(Vector2(250,200))
	add_child(sprite)

func _on_Enemy_Deck_PLAYED_CARD(choosed_card):
	if(choosed_card == Global.PAPER):
		played_card(texture_paper)
	elif(choosed_card == Global.ROCK):
		played_card(texture_rock)
	elif(choosed_card == Global.SCISSORS):
		played_card(texture_scissors)
	elif(choosed_card == Global.JOKER):
		played_card(texture_joker)
	pass # Replace with function body.
