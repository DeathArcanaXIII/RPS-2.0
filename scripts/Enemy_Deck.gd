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


var drawed_all_cards = false
var mouse_over_deck = false

var xAxys = 250

# Called when the node enters the scene tree for the first time.
func _ready():
	emit_signal("SHUFFLE", enemy_deck)
	create_enemy_hand()
	$"/root/Table".connect("ENEMY_TURN", self, "play_random_card")
	pass # Replace with function body.

func create_card(texture):#INSTANCEIA A CENA, ADICIONA COMO FILHO, CONECTA A CARTA, POSICIONA A CENA
	var card = Sprite.new()
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
	if(drawed_3 == 3):#CORRIGE O POSICIONAMENTO E HABILITA O MULLIGAN UMA UNICA VEZ
		xAxys = 250
		drawed_3 = 0
	print("ENEMY:", enemy_hand)

func play_random_card():
	randomize()
	var temp = randi() % enemy_hand.size()
	var choosed_card = enemy_hand[temp]
	enemy_hand.pop_at(temp)
	Global.enemy_choice = choosed_card
	Global.state = Global.CHECK_WINNER
	print(choosed_card)
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
