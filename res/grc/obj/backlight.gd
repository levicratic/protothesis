# adds positional noise

extends Sprite2D

var origin
var posX
var posY

# set initial position
func _ready():
	origin = position
	posX = PI * (randi() % 100 + 1) / (randi() % 50 + 1)
	posY = posX

# procedural animation
func _process(_delta):
	posX += .01
	posY += .005

	position.x = origin.x + 10*sin(posX)
	position.y = origin.y + 10*cos(posY)
