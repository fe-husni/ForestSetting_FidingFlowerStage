extends Node

class_name Damageable

signal on_hit(node : Node, damage_taken : int)

@export var health_bar : HealthBar

@export var health : int = 20 :
	get:
		return health
	set(value):
		SignalBus.emit_signal("on_health_changed", get_parent(), value - health)
		health = value
		
@export var dead_animation_name : String = "dead"

func _ready():
	health_bar.init_health(health)

func hit(damage: int, knockback_direction: Vector2):
	health -= damage
	
	health_bar.health = health
	
	emit_signal("on_hit", get_parent(), damage, knockback_direction)
	
func _on_animation_tree_animation_finished(anim_name):
	if anim_name == dead_animation_name:
		get_parent().queue_free()
