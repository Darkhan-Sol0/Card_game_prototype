extends Node2D

var hand_idx : int

@onready var ui = $UI
@onready var ui_vis = $UI/VBoxContainer
@onready var coll: CollisionShape2D = $Area2D/CollisionShape2D

var selected : bool = false
var flip : bool = true

var touch_place : Vector2
var card_pos: Vector2
var card_def_pos: Vector2

func _ready() -> void:
	coll.disabled = true

func _process(delta: float) -> void:
	card_movement(delta)
	ui_vis.visible = flip

func get_last_pos():
	if selected == true:
		z_index = 4000
		card_pos = get_global_mouse_position() - touch_place
	else:
		z_index = hand_idx
		card_pos = card_def_pos

func card_movement(delta: float) -> void:
	get_last_pos()
	global_position.x = lerpf(global_position.x, card_pos.x, delta * 20)
	global_position.y = lerpf(global_position.y, card_pos.y, delta * 20)
	
	if global_position.x <= 75:
		global_position.x = 75
	if global_position.y <= 100:
		global_position.y = 100
	if global_position.x >= get_viewport().size.x - 75:
		global_position.x = get_viewport().size.x - 75
	if global_position.y >= get_viewport().size.y - 100:
		global_position.y = get_viewport().size.y - 100

func _on_ui_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			selected = true
			coll.disabled = true
			touch_place = get_local_mouse_position()
		else: 
			selected = false
			coll.disabled = false
	
		if event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
			flip = !flip

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent().name == "Table":
		queue_free()
