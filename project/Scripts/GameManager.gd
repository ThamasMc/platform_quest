extends Node

var score = 0;
@onready var label = $Label

func add_point():
	score += 1
	label.text = "You found " + str(score) + " coins!"
	print(score)
