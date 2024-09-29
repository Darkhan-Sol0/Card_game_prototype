extends Node2D

var count_max : int = 30
var cards : Array
@onready var lab = $Label

@export_node_path("Node2D") var Hand_path
var Hand : Node2D

func _ready() -> void:
	Hand = get_node(Hand_path)
	for i in count_max:
		var card = preload("res://src/card.tscn").instantiate()
		cards.append(card)

func _process(_delta: float) -> void:
	lab.text = str(cards.size())
	
	if Input.is_action_just_pressed("ui_accept"):
		distribution_cards()

func distribution_cards() -> void:
	if cards.size() > 0 and Hand.hand_cards.size() < Hand.hand_size_max:
		Hand.show_cards(cards[cards.size() - 1])
		cards.pop_back()

func shuffle_deck():
	pass
