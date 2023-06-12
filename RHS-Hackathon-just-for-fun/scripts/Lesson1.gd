extends Node2D

export (PackedScene) var MCQ

# GDSCRIPT has no arrays !!!! :( :(
var p1 = ["2x = 10-->Solve for x", "x = 10", "x = 4", "x = 5", "x = 3", "x = 5"]
var p2 = ["2x + 5 = 25-->Solve for x", "x = 10", "x = -6", "x = 7", "x = 9", "x = 10"] #
var p3 = ["6x + 3 = x - 7-->Solve for x", "x = 10", "x = 4", "x = -2", "x = 0", "x = -2"]
var p4 = ["2(3x + 5)-->Simplify", "7x + 10", "3x + 6", "6x + 10", "15x + 8", "6x + 10"] #
var p5 = ["6(x + 10) = 84-->Solve for x",  "x = 19", "x = 4", "x = 7", "x = 9", "x = 4"]
var p6 = ["2x = 4-->Solve for x", "x = 5", "x = 9", "x = 19", "x = 2", "x = 2"] #
var p7 = ["5x + 5 = 35-->Solve for x", "x = 13", "x = 14", "x = 6", "x = 16", "x = 6"]
var p8 = ["16x + 3 = 35-->Solve for x", "x = 5", "x = 10", "x = 27", "x = 2", "x = 2"] #
var p9 = ["3x = 24-->Solve for x", "x = 10", "x = 123", "x = 8", "x = 9", "x = 8"]
var p10 = ["x(5 + 6) = 99-->Solve for x", "x = 18", "x = 9", "x = 11", "x = 13", "x = 9"] #

onready var matho = get_node("Matho") # so it doens't blow up
var problems = [p1, p2, p3, p4, p5, p6, p7, p8, p9, p10]
var wrongprobs = []
var onwrong = 0
var curprob = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	prep_question(curprob)

func prep_question(number):
	var question = MCQ.instance()
	question.ready(problems[number][0], problems[number][1], problems[number][2], problems[number][3], problems[number][4], problems[number][5])
	question.connect("correct", self, "move_on")
	question.connect("incorrect", self, "go_later")
	self.add_child(question)
	question.name = "current"
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
