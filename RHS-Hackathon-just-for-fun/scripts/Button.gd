extends TextureButton

signal ipress(chicken)

onready var label = get_node("Label")
var text = "" # iam and text set up by parent
var iam

# Called when the node enters the scene tree for the first time.
func _ready():
	label.add_color_override("font_color", Color(0, 0, 0))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	label.text = text # setup text

func _pressed():
	emit_signal("ipress", iam)
