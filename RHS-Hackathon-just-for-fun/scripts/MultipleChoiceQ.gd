extends Node2D

# goals
# list of questions, solutions
# generate text that displays questoin
# generate 3 buttosn taht display answers (randomly assigned, one is correcT)
# if correct one is clicked, repeat and increase an index
# run an animation of Matho beign ahppy
# when index = 10, end lesson and dipslay gained xp

signal correct()
signal incorrect()

var solution

func ready(problem, a1, a2, a3, a4, sol):
	var label = get_node("Label")
	label.text = problem
	label.add_color_override("font_color", Color(0, 0, 0))
	label.add_color_override("font_size", 1000)
	randomize()
	
	var b1 = get_node("b1")
	var b2 = get_node("b2")
	var b3 = get_node("b3")
	var b4 = get_node("b4")
	
	var blist = [b1, b2, b3, b4]
	var slist = [a1, a2, a3, a4]
	
	solution = sol
	var index = 0
	
	for button in blist:
		button.iam = slist[index] #something
		button.text = button.iam
		button.connect("ipress", self, "button_pressed")
		index += 1

func button_pressed(originator):
	var proposal = originator
	if proposal == solution:
		print("correct")
		emit_signal("correct")
	else:
		print("incorrect")
		emit_signal("incorrect")
