extends Node2D

export (PackedScene) var MCQ

# GDSCRIPT has no arrays !!!! :( :(
var p1 = ["y=x^2+4x+4-->Solve for roots", "x=2,2", "x=-2,-2", "x=2,-2", "x=3,1", "x=-2,-2"]
var p2 = ["y=x^2+4x+4-->Solve for roots", "x=2,2", "x=-2,-2", "x=2,-2", "x=3,1", "x=-2,-2"] #
var p3 = ["y=x^2+4x+4-->Solve for roots", "x=2,2", "x=-2,-2", "x=2,-2", "x=3,1", "x=-2,-2"]
var p4 = ["y=2x^2+12x+36-->Solve for roots", "x=2,-2", "x=4,7", "x=4,0", "no roots", "no roots"] #
var p5 = ["y=4x^2+8x+3-->Solve for roots", "x=2,-2",  "x=5,9", "x~0.5, -0.75", "x~-0.5,-1.5", "x~-0.5,-1.5"]
var p6 = ["y=-16x^2+32x-->Solve for roots", "x=2,-2", "x=0.5,-2", "x=2,0", "x=4,0", "x=2,0"]  #
var p7 = ["y=2x^2-4x+10-->Find the vertex", "(2,-2)", "(4,2)", "(0.5, -1.3)", "(1,-8)", "(1,-8)"]
var p8 = ["y=(2x-4)(x+5)-->Find the vertex", "~(-1.5,-22.25)", "~(1.3, 4.75)", "~(4, -0.85)", "~(0.43, -6.57)", "~(-1.5,  -22.25)"]  #
var p9 = ["y=-150x^2+55x+45-->Find the roots", "x~-0.13, 1.64", "x~4.26, 8.02", "x~-0.13, 0.74", "x~-0.39, 0.76", "x~-0.39, 0.76"]
var p10 = ["y= -16x^2+5x+3-->Solve for roots", "x~2,-2", "x~0.1,-0.9",  "x~0.6,-0.3", "x~-5, 0.5", "x~0.6,-0.3"] #

var problems = [p1, p2, p3, p4, p5, p6, p7, p8, p9, p10]
var wrongprobs = []
var curprob = 0
var onwrong = 0
onready var matho = get_node("Matho")

# Called when the node enters the scene tree for the first time.
func _ready():
	prep_question(curprob)
# wha thappens when a question is wrong/right

func move_on():
	matho.become_happy()
	yield(get_tree().create_timer(1.0), "timeout")
	
	if not onwrong:
		if curprob < 9:
			curprob += 1
			kill_children()
			prep_question(curprob)
		elif curprob == 9:
			if not wrongprobs:
				get_tree().change_scene("res://MainScene.tscn")
			if wrongprobs:
				kill_children()
				onwrong = 1
				curprob = wrongprobs[0]
				prep_question(curprob)
	elif onwrong:
		wrongprobs.erase(curprob)
		print(wrongprobs)
		
		if not wrongprobs: # if there are no wrong questions
			get_tree().change_scene("res://MainScene.tscn")
		else:
			curprob = wrongprobs[0]
			kill_children()
			prep_question(curprob)
	
	matho.become_unhappy()

func go_later():
	matho.become_sad()
	yield(get_tree().create_timer(1.0), "timeout")
	print(wrongprobs)
	
	if not onwrong:
		wrongprobs.append(curprob)
		if curprob < 9:
			curprob += 1
			kill_children()
			prep_question(curprob)
		elif curprob == 9:
			if not wrongprobs:
				get_tree().change_scene("res://MainScene.tscn")
			if wrongprobs:
				print("got to wrongprobs")
				kill_children()
				onwrong = 1
				curprob = wrongprobs[0]
				prep_question(curprob)
	elif onwrong:
		print("wrong question wrong")
		wrongprobs.erase(curprob)
		print("b4 " + str(wrongprobs))
		wrongprobs.append(curprob) # move it to the back
		print(wrongprobs)
		curprob = wrongprobs[0]
		kill_children()
		prep_question(curprob)
	
	matho.become_unhappy()

func kill_children():
	for child in get_children():
		if child.name != "Background" and child.name != "Matho":
				child.queue_free()

func prep_question(number):
	var question = MCQ.instance()
	question.ready(problems[number][0], problems[number][1], problems[number][2], problems[number][3], problems[number][4], problems[number][5])
	question.connect("correct", self, "move_on")
	question.connect("incorrect", self, "go_later")
	self.add_child(question)
	question.name = "current"
