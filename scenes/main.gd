extends Sprite2D

var score := [0,0] # index 0 => player, index 1 => CPU
const PADDLE_SPEED : int = 500 # define fast the player and CPU paddle move


func _on_ball_timer_timeout() -> void:
	$Ball.new_ball()


func _on_score_left_body_entered(body: Node2D) -> void:
	score[1] += 1
	$Hud/CPUScore.text = str(score[1])
	$BallTimer.start()

func _on_score_right_body_entered(body: Node2D) -> void:
	score[0] += 1
	$Hud/PlayerScore.text = str(score[0])
	$BallTimer.start()
