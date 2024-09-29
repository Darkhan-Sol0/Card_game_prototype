extends Node2D

var hand_size_max : int = 10
var hand_cards : Array
var hand_field_whith : int = 1500

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	free_null()

func show_cards(card):
	hand_cards.append(card)
	self.add_child(hand_cards[hand_cards.size() - 1])
	hand_cards[hand_cards.size() - 1].global_position = Vector2(get_viewport().size.x * 0.9, get_viewport().size.y * 0.5)
	for i in hand_cards.size():
		hand_cards[i].card_def_pos = Vector2((hand_field_whith / (hand_cards.size() + 1) * (i + 1)) + (get_viewport().size.x - hand_field_whith) / 2, global_position.y)

func free_null():
	for i in range(hand_cards.size() -1, -1, -1):
		if hand_cards[i] == null:
			hand_cards.remove_at(i)
	for i in hand_cards.size():
		hand_cards[i].card_def_pos = Vector2((hand_field_whith / (hand_cards.size() + 1) * (i + 1)) + (get_viewport().size.x - hand_field_whith) / 2, global_position.y)
