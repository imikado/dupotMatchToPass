class_name Player
extends Actor

const MAX_LIFE=100.0
var _life:=100.0

var _damage=40

#onready var _animationTree := get_node("AnimationTree")
onready var _camera:=get_node("Camera2D")
onready var _tween:=get_node("Tween")
onready var _stateDisplay:=get_node("stateDisplay")

onready var _stateMachine:=get_node("StateMachine")

onready var _manaAttackParticules:=get_node("ManaAttackParticules")
onready var _manaFalling:=get_node("ManaFalling")

onready var _manaTween:=get_node("ManaTween")

var look_direction = Vector2(1, 0) setget set_look_direction

var _cameraLimitRect: ReferenceRect

var _mana_count=0

func _ready() -> void:
	updateLife(_life)
	
	_stateDisplay.visible=Game.is_debug()
	_manaAttackParticules.emitting=false
	_manaFalling.visible=false
	
	mana_attack_end()
	
func set_look_direction(value):
	look_direction = value
	emit_signal("direction_changed", value)

func updateLife(newLife:int):
	_life=newLife
	Events.emit_signal("player_health_changed", (_life/MAX_LIFE)*100 )


func took_damage(damage:int):
	updateLife(_life - damage)
	_stateMachine.set_damaged()
	
	_tween.interpolate_property(
		self, "modulate", Color.white, Color.red, 0.1
	)
	_tween.interpolate_property(
		self, "modulate", Color.red, Color.white, 0.1
	)

	_tween.start()


func set_camera_limit_rect(referenceRect : ReferenceRect):
	_cameraLimitRect=referenceRect
	
	var cameraLimitRectGlobalPosition=_cameraLimitRect.rect_global_position
	var cameraLimitRectSize=_cameraLimitRect.rect_size+cameraLimitRectGlobalPosition
	
	_camera.limit_left=cameraLimitRectGlobalPosition.x
	_camera.limit_top=cameraLimitRectGlobalPosition.y
	_camera.limit_right=cameraLimitRectSize.x
	_camera.limit_bottom=cameraLimitRectSize.y



func _on_HitBox_body_entered(body: Node) -> void:
	if body.is_in_group(Game.GROUP_ENEMY):
		Events.emit_signal("actor_took_damage",body,_damage)
	pass # Replace with function body.


func mana_attack_start()->void:
	 fall()


func mana_attack_end()->void:
	_manaFalling.visible=false
	for fallLoop in _manaFalling.get_children():
		fallLoop.end_fall()
	
	_manaAttackParticules.emitting=false
	 
	
func fall()->void:
	_manaFalling.visible=true
	for fallLoop in _manaFalling.get_children():
		fallLoop.start_fall()
	


func _on_ManaFall_fall_ended() -> void:
	_manaFalling.visible=false
	
	if _mana_count < 3:
		fall()
		_mana_count+=1
	
	else:
		_mana_count=0
		mana_attack_end()
	pass # Replace with function body.
