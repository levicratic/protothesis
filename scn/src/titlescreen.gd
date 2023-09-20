extends Node2D

@onready var player = $player
@onready var origin = player.position
@onready var floor: float = $backdrop.get_viewport_rect().size[1]

func _ready():
	position = get_viewport_rect().size / 2 # can skip if there's a camera

func _process(_delta):
	if player.position.y > floor:
		respawn()

func respawn():
	player.position = origin
