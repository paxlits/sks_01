extends CharacterBody2D

@export var npc_name : String = "NPC"
@export var reward : int = 0
var animations
@export var move_speed: int = 400

func _ready() -> void:
	add_to_group("npcs")
	$Label.text = npc_name
	
