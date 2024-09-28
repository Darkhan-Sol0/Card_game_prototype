extends Node2D

@onready var ui = $UI
@onready var ui_vis = $UI/VBoxContainer

var selected : bool = false
var flip : bool = true

var last_pos : Vector2
var touch_place : Vector2

func _ready() -> void:
	last_pos = get_viewport().size / 2

func _process(delta: float) -> void:
	z_index = global_position.x
	position.x = lerpf(position.x, last_pos.x, delta * 20)
	position.y = lerpf(position.y, last_pos.y, delta * 20)
	
	if position.x <= 75:
		position.x = 75
	if position.y <= 100:
		position.y = 100
	if position.x >= get_viewport().size.x - 75:
		position.x = get_viewport().size.x - 75
	if position.y >= get_viewport().size.y - 100:
		position.y = get_viewport().size.y - 100
	
	ui_vis.visible = flip
	
	if selected:
		get_last_pos()
		z_index = 4000

func get_last_pos():
	last_pos = get_global_mouse_position() - touch_place

func _on_ui_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			selected = true
			touch_place = get_local_mouse_position()
		else:
			selected = false
	
		if event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
			flip = !flip
