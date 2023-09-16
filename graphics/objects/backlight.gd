extends Sprite2D

var origin
var posX
var posY

# Called when the node enters the scene tree for the first time.
func _ready():
	origin = position
	posX = 2*PI
	posY = posX

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	posX += .01
	posY += .005

	position.x = origin.x + 10*sin(posX)
	position.y = origin.y + 10*cos(posY)
