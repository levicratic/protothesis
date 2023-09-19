extends CharacterBody2D

# Get the gravity from the project settings
var gravity = ProjectSettings.get_setting(
	"physics/2d/default_gravity")

@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var animator: AnimationTree = $AnimationTree
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 512.0 # 300.0
const JUMP_VELOCITY = -680.0 # -400.0

var condition: String = "parameters/conditions/%s"
var direction: float

func _ready():
	animator.active = true # avitate animation tree
	animator[condition % "idle"] = true # start in idle

func _process(_delta):
	
	# press direction not facing: backflip
	if Input.is_action_just_pressed(
		"right" if sprite.flip_h else "left"
	): animator[condition % "backflip"] = true
	
	if is_on_floor():
		# press direction facing: run
		if Input.is_action_pressed("right"):
			animator[condition % "idle"] = false
			animator[condition % "run"] = true
			if not animator[condition % "backflip"]:
				sprite.flip_h = false
		
		elif Input.is_action_pressed("left"):
			animator[condition % "idle"] = false
			animator[condition % "run"] = true
			if not animator[condition % "backflip"]:
				sprite.flip_h = true
		else:
			animator[condition % "idle"] = true
			animator[condition % "run"] = false
			animator[condition % "jump"] = false
	else:
		print("jump")
		animator[condition % "jump"] = true
		animator[condition % "idle"] = false
		animator[condition % "run"] = false
	
	# update facing direction
	if direction and not animator[condition % "backflip"]:
		sprite.flip_h = true if direction < 0 else false

func _physics_process(delta):
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta * 2 #

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_axis("left", "right")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
