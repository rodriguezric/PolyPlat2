extends KinematicBody2D

const GRAVITY = 750
const FRICTION = 0.5
export (int) var move_speed = 100
export (int) var jump_force = -200
var motion : Vector2
onready var animationPlayer = $AnimationPlayer
onready var graphics = $Graphics

func _input(event):
	if event.is_action_pressed("jump"):
		if is_on_floor():
			motion.y = jump_force
	
	if event.is_action_pressed("left"):
		motion.x = -move_speed
		graphics.scale.x = -1
		
		
	if event.is_action_pressed("right"):
		motion.x = move_speed
		graphics.scale.x = 1

func is_pressing_left():
	return Input.is_action_pressed("left")


func is_pressing_right():
	return Input.is_action_pressed("right")


func is_pressing_left_or_right():
	return is_pressing_left() or is_pressing_right()


func apply_gravity(delta):
	if !is_on_floor():
		motion.y += GRAVITY * delta
		if motion.y > 0:
			motion.y = min(motion.y, abs(jump_force) * 2)


func is_walking():
	if is_on_floor():
		return is_pressing_left_or_right()
	
	return false


func is_jumping(): 
	if not is_on_floor():
		return motion.y < 0

func apply_friction(delta):
	if not is_pressing_left_or_right():
		motion.x = lerp(motion.x, 0, FRICTION)
	
func _physics_process(delta):
	apply_gravity(delta)
	apply_friction(delta)
	move_and_slide(motion, Vector2.UP)
	
	if is_walking():
		animationPlayer.play("Walk")
	elif is_jumping():
		animationPlayer.play("Jump")
	else:
		animationPlayer.play("Idle")
