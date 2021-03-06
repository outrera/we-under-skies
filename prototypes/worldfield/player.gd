
extends RigidBody2D



onready var sprite = get_node('Sprite')

var XSPEED = 420
var YSPEED = XSPEED/2
var dir = 1

func _integrate_forces(state):
	var delta = state.get_step()
	# Get flags for Input
	var UP = Input.is_action_pressed('ui_up')
	var DOWN = Input.is_action_pressed('ui_down')
	var LEFT = Input.is_action_pressed('ui_left')
	var RIGHT = Input.is_action_pressed('ui_right')
	
	# Set an initial vector (or for no input)
	var v = Vector2(XSPEED*dir,0)
	
	# modify vector by Input
	if UP: v.y = -YSPEED
		sprite.set_rotd(180)
	if DOWN: v.y = YSPEED
		sprite.set_rotd(0)
	if LEFT:
		if dir > 0:
			dir = -1
		sprite.set_rotd(90+180)
	if RIGHT:
		if dir < 0:
			dir = 1
		sprite.set_rotd(90)

	if UP and LEFT:
		sprite.set_rotd(45+180)
	if UP and RIGHT:
		sprite.set_rotd(45+90)
	if DOWN and LEFT:
		sprite.set_rotd(45-90)
	if DOWN and RIGHT:
		sprite.set_rotd(45)
	
	# cancel out movement if conflicting directions are pressed
	if UP and DOWN: v.y=0
	#if LEFT and RIGHT: v.x=0
	
	# Normalize and scale speed
	#v = v.normalized()
	
	# Apply movement
	set_linear_velocity(v)
	get_node('prograde').set_pos(Vector2(0,0).linear_interpolate(get_linear_velocity(),0.5))
	


