extends TextureButton

var lesson = int(self.name)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	pass

func _pressed():
	var go_to = "Lesson" + str(self.name)
	get_tree().change_scene("res://scenes/" + go_to + ".tscn")
	#load lesson 1 scene
