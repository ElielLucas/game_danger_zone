extends Control

@onready var counter = $container/kills_container/counter as Label


func _ready():
	counter.text = "Inimigos mortos: " + str(Globals.inimigos_mortos)
	
	
func _process(delta):
	counter.text = "Inimigos mortos: " + str(Globals.inimigos_mortos)
