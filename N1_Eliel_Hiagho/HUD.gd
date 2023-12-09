extends CanvasLayer

signal start_game
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func show_message(text):
	$Control/Message.text = text
	$Control/Message.show()
	$Control/MessageTimer.start()

func show_game_over():
	show_message("Game Over")
	# Wait until the MessageTimer has counted down.
	await $Control/MessageTimer.timeout

	$Control/Message.text = "Mate o maximo de Inimigos que voçe conseguir! Boa Sorte!!!"
	$Control/Message.show()
	# Make a one-shot timer and wait for it to finish.
	await get_tree().create_timer(1.0).timeout
	$Control/StartButton.show()

func update_score(score):
	$Control/InimigosLabel.text = str(score)


func _on_start_button_pressed():
	$Control/StartButton.hide()
	start_game.emit()
	pass # Replace with function body.


func _on_message_timer_timeout():
	$Control/Message.hide()
	pass # Replace with function body.
