extends Node2D

onready var main = get_node("Main")
onready var happy = get_node("Happy")
onready var sad = get_node("Sad")

# Called when the node enters the scene tree for the first time.
func _ready():
	var main = get_node("Main")
	var happy = get_node("Happy")
	var sad = get_node("Sad")
	happy.hide()
	sad.hide()

func become_happy(): # i wish i had this function
	main.hide()
	sad.hide()
	happy.show()

func become_unhappy(): # ic an do this just by looking at my list of accopmlishments
	main.show()
	sad.hide()
	happy.hide()

func become_sad():
	main.hide()
	sad.show()
	happy.hide()
