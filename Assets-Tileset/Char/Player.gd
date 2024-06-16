extends CharacterBody2D

class_name Player

@export var SPEED : float = 200.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction = Vector2.ZERO

@onready var hitbox = $PunchHitbox
@onready var animation_tree = $AnimationTree
@onready var sprite = $Sprite2D
@onready var state_machine = $CharacterStateMachine

signal facing_direction_changed(facing_right: bool)

func _ready():
	animation_tree.active = true

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if direction.x != 0 and state_machine.check_if_can_move():
		velocity.x = direction.x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	update_animation_parameters()
	update_facing_direction()

func update_animation_parameters():
	animation_tree.set("parameters/move/blend_position", direction.x)

func update_facing_direction():
	if direction.x > 0:
		sprite.flip_h = false;
	elif direction.x < 0:
		sprite.flip_h = true;
		
	emit_signal("facing_direction_changed", !sprite.flip_h)
