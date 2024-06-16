extends State

@export var JUMP_VELOCITY : float = -200.0

@export var air_state : State
@export var attack_state : State

@export var jump_animation : String = "jump"
@export var attack_animation : String = "attack"

func state_process(delta):
	if !character.is_on_floor():
		next_state = air_state

func state_input(event: InputEvent):
	if event.is_action_pressed("ui_up"):
		jump()
	if event.is_action_pressed("attack"):
		attack()

func jump():
	character.velocity.y = JUMP_VELOCITY
	next_state = air_state
	playback.travel(jump_animation)

func attack():
	next_state = attack_state
	playback.travel(attack_animation)
