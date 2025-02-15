class_name PlayerStateMachine
extends AbstractStateMachine

const STATE_IDLE = "Idle"
const STATE_WALK = "Walk"
const STATE_ATTACK01 = "Attack01"
const STATE_ATTACK02 = "Attack02"
const STATE_ATTACK03 = "Attack03"
const STATE_ATTACK04 = "Attack04"
const STATE_DAMAGED = "Damaged"
const STATE_ATTACK_MANA01 = "AttackMana01"
const STATE_GET_LIFE_BOTTLE = "GetLifeBottle"
const STATE_GAMEOVER = "Gameover"

const INPUT_ATTACK = "attack"
const INPUT_ATTACK_MANA = "attack_mana"


func set_damaged():
	_change_state(STATE_DAMAGED)
	
func get_life_bottle():
	_change_state(STATE_GET_LIFE_BOTTLE)

func gameover():
	_change_state(STATE_GAMEOVER)

func _ready():
	states_map = {
		STATE_IDLE: get_node(STATE_IDLE),
		STATE_WALK: get_node(STATE_WALK),
		STATE_ATTACK01: get_node(STATE_ATTACK01),
		STATE_ATTACK02: get_node(STATE_ATTACK02),
		STATE_ATTACK03: get_node(STATE_ATTACK03),
		STATE_ATTACK04: get_node(STATE_ATTACK04),
		STATE_ATTACK_MANA01: get_node(STATE_ATTACK_MANA01),
		STATE_DAMAGED: get_node(STATE_DAMAGED),
		STATE_GET_LIFE_BOTTLE: get_node(STATE_GET_LIFE_BOTTLE),
		STATE_GAMEOVER: get_node(STATE_GAMEOVER)
	}


func _change_state(state_name):
	
	if not _active:
		return
		
	if get_current_state_name() == STATE_GAMEOVER:
		return

	if get_current_state_name() == STATE_ATTACK_MANA01 and state_name!=STATE_GAMEOVER:
		return

	if state_name in [STATE_ATTACK01, STATE_ATTACK_MANA01, STATE_DAMAGED,STATE_GAMEOVER]:
		states_stack.push_front(states_map[state_name])

	._change_state(state_name)


func _input(event):
	"""
	Here we only handle input that can interrupt states, attacking in this case
	otherwise we let the state node handle it
	"""
	if event.is_action_pressed(INPUT_ATTACK):
		if [get_node(STATE_ATTACK01), get_node(STATE_ATTACK02), get_node(STATE_ATTACK03), get_node(STATE_ATTACK04),].has(
			current_state
		):
			return
		_change_state(STATE_ATTACK01)
		return

	if (
		event.is_action_pressed(INPUT_ATTACK_MANA)
		and GlobalPlayer.can_use_amount_mana(GlobalPlayer.attack_amount_mana)
	):
		if [get_node(STATE_ATTACK_MANA01)].has(current_state):
			return
		_change_state(STATE_ATTACK_MANA01)
		Events.emit_signal("player_launch_mana_attack")
		return
	current_state.handle_input(event)
