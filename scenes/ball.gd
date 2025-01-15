extends CharacterBody2D

var window_size : Vector2
const START_SPEED : int = 500
const ACCEL : int = 50
const START_POS : int = 200
var speed : int
var dir : Vector2
const MAX_Y_VECTOR : float = 0.6


func _ready():
	window_size = get_viewport_rect().size
	
func new_ball():
	#randomize start position and direction
	position.x = window_size.x / 2
	position.y = randi_range(START_POS, window_size.y - START_POS)
	speed = START_SPEED
	dir = random_direction()

func _physics_process(delta):
	var collision = move_and_collide(dir*speed*delta)
	var collider
	if collision:
		collider  = collision.get_collider()
		if collider == $"../Player" or collider == $"../CPU":
			speed+=ACCEL
			dir = new_direction(collider)
		else:
			dir = dir.bounce(collision.get_normal())
		
func random_direction():
	var newDir := Vector2()
	newDir.x = [1,-1].pick_random()
	newDir.y = randf_range(-1,1)
	return newDir.normalized()
	
func new_direction(collider):
	var ball_y = position.y
	var pad_y = collider.position.y
	var dist = ball_y - pad_y
	var newDir := Vector2()
	if dir.x > 0:
		newDir.x = -1
	else:
		newDir.x = 1
	newDir.y = (dist/(collider.paddle_height/2)) * MAX_Y_VECTOR
	return newDir.normalized()
	
