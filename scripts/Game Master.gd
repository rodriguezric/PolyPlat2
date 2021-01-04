extends Node

onready var player = $Player
onready var start_point = $StartPoint
onready var win_screen = $UI/CanvasLayer/WinScreen
onready var lose_screen = $UI/CanvasLayer/LoseScreen


func reset_player():
	player.position = start_point.position
	
	
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Lava_body_shape_entered(body_id, body, body_shape, area_shape):
	lose_screen.visible = true
	reset_player()
	pass # Replace with function body.


func _on_WinDoor_body_entered(body):
	win_screen.visible = true
	pass # Replace with function body.
