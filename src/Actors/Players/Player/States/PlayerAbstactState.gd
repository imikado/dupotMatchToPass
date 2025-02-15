class_name PlayerAbstractState
extends AbstractState

const STATE_IDLE = "Idle"
const STATE_WALK = "Walk"
const STATE_ATTACK01 = "Attack01"
const STATE_ATTACK02 = "Attack02"
const STATE_ATTACK03 = "Attack03"
const STATE_ATTACK04 = "Attack04"
const STATE_DAMAGED = "Damaged"

const INPUT_ATTACK = "attack"
const INPUT_LEFT = "ui_left"
const INPUT_RIGHT = "ui_right"
const INPUT_UP = "ui_up"
const INPUT_DOWN = "ui_down"
const INPUT_ATTACK_MANA = "attack_mana"

const ANIM_IDLE = "idle"
const ANIM_WALK_RIGHT = "walking_right"
const ANIM_DAMAGED = "damaged"

const ANIM_ATTACK_01_RIGHT = "attacking_01_right"
const ANIM_ATTACK_02_RIGHT = "attacking_02_right"
const ANIM_ATTACK_03_RIGHT = "attacking_03_right"
const ANIM_ATTACK_04_RIGHT = "attacking_04_right"

const ANIM_ATTACK_MANA_01_RIGHT = "attacking_mana_01_right"

const ANIM_GET_LIFE_BOTTLE = "get_life_bottle"
const ANIM_GAMEOVER = "gameover"


func play_animation(animation):
	return owner.get_node("BodyPivot/AnimationPlayer").play(animation)
